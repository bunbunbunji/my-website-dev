Sub ImportLyricsDevFromSupabase()
    Const SUPABASE_URL As String = "https://atinpqtedmrfrtdlkpkd.supabase.co"
    Const SUPABASE_KEY As String = "sb_publishable_SWT3WgKAN77Ujv_lbDSppg_gmedWl64"
    Const QUERY_NAME   As String = "lyrics_dev_data"
    Const SHEET_NAME   As String = "lyrics_dev"
    Const PAGE_SIZE    As Long = 1000

    ' 取得対象の sounds_id（カンマ区切り）
    ' 全件取得する場合は SOUNDS_FILTER = "" にする
    Const SOUNDS_FILTER As String = ""

    Dim filterParam As String
    If SOUNDS_FILTER <> "" Then
        filterParam = "&sounds_id=in.(" & SOUNDS_FILTER & ")"
    Else
        filterParam = ""
    End If

    Dim http As Object
    Set http = CreateObject("WinHttp.WinHttpRequest.5.1")

    ' --- 1. 総件数を取得 ---
    http.Open "GET", SUPABASE_URL & "/rest/v1/lyrics_dev?select=*&limit=1" & filterParam, False
    http.setRequestHeader "apikey", SUPABASE_KEY
    http.setRequestHeader "Authorization", "Bearer " & SUPABASE_KEY
    http.setRequestHeader "Accept", "text/csv"
    http.setRequestHeader "Prefer", "count=exact"
    http.send

    Dim contentRange As String
    contentRange = http.getResponseHeader("Content-Range")
    Dim totalCount As Long
    totalCount = CLng(Mid(contentRange, InStr(contentRange, "/") + 1))

    If totalCount = 0 Then
        MsgBox "データが0件です"
        Exit Sub
    End If

    ' --- 2. CSVファイル準備（BOM付きUTF-8） ---
    Dim csvPath As String
    csvPath = ThisWorkbook.Path & "\lyrics_dev_tmp.csv"

    Dim bom(2) As Byte
    bom(0) = &HEF: bom(1) = &HBB: bom(2) = &HBF

    Dim fNum As Integer
    fNum = FreeFile
    Open csvPath For Binary As #fNum
    Put #fNum, , bom

    ' --- 3. ページング取得 ---
    Dim offset As Long
    offset = 0
    Dim isFirstPage As Boolean
    isFirstPage = True

    Do While offset < totalCount
        http.Open "GET", SUPABASE_URL & "/rest/v1/lyrics_dev?select=*&order=sounds_id,seq&limit=" & PAGE_SIZE & "&offset=" & offset & filterParam, False
        http.setRequestHeader "apikey", SUPABASE_KEY
        http.setRequestHeader "Authorization", "Bearer " & SUPABASE_KEY
        http.setRequestHeader "Accept", "text/csv"
        http.send

        If http.Status <> 200 Then
            Close #fNum
            MsgBox "API エラー: " & http.Status
            Exit Sub
        End If

        Dim pageBytes() As Byte
        pageBytes = http.responseBody

        If isFirstPage Then
            Put #fNum, , pageBytes
            isFirstPage = False
        Else
            Dim i As Long
            For i = LBound(pageBytes) To UBound(pageBytes)
                If pageBytes(i) = 10 Then
                    Dim dataLen As Long
                    dataLen = UBound(pageBytes) - i
                    If dataLen > 0 Then
                        Dim dataBytes() As Byte
                        ReDim dataBytes(dataLen - 1)
                        Dim j As Long
                        For j = 0 To dataLen - 1
                            dataBytes(j) = pageBytes(i + 1 + j)
                        Next j
                        Put #fNum, , dataBytes
                    End If
                    Exit For
                End If
            Next i
        End If

        offset = offset + PAGE_SIZE
    Loop

    Close #fNum

    ' --- 4. シート準備 ---
    Dim ws As Worksheet
    On Error Resume Next
    Set ws = ThisWorkbook.Sheets(SHEET_NAME)
    On Error GoTo 0
    If ws Is Nothing Then
        Set ws = ThisWorkbook.Sheets.Add
        ws.name = SHEET_NAME
    Else
        ' 既存のクエリテーブルを削除
        Dim qt As QueryTable
        For Each qt In ws.QueryTables
            qt.Delete
        Next qt
        ws.Cells.Clear
    End If

    ' --- 5. 既存クエリ削除 ---
    On Error Resume Next
    ThisWorkbook.Queries(QUERY_NAME).Delete
    On Error GoTo 0

    ' --- 6. Power Query ---
    Dim pqFormula As String
    pqFormula = "let" & Chr(10) & _
        "    Source = Csv.Document(File.Contents(""" & Replace(csvPath, "\", "\\") & """),[Delimiter="","",Encoding=65001,QuoteStyle=QuoteStyle.Csv])," & Chr(10) & _
        "    Headers = Table.PromoteHeaders(Source,[PromoteAllScalars=true])," & Chr(10) & _
        "    Reordered = Table.SelectColumns(Headers,{""id"",""sounds_id"",""seq"",""section_name"",""lyric"",""occurrence"",""lyric_col"",""col_space"",""is_active""})" & Chr(10) & _
        "in" & Chr(10) & _
        "    Reordered"

    ThisWorkbook.Queries.Add name:=QUERY_NAME, Formula:=pqFormula

    ' --- 7. シートに展開（テーブル化しない: QueryTableとして展開） ---
    Application.DisplayAlerts = False
    With ws.QueryTables.Add( _
        Connection:="OLEDB;Provider=Microsoft.Mashup.OleDb.1;Data Source=$Workbook$;Location=" & QUERY_NAME & ";Extended Properties=""""", _
        Destination:=ws.range("A1"))
        .CommandType = xlCmdDefault
        .CommandText = Array(QUERY_NAME)
        .Refresh BackgroundQuery:=False
    End With
    Application.DisplayAlerts = True

    On Error Resume Next
    Kill csvPath
    On Error GoTo 0

    MsgBox "取得完了: " & totalCount & " 件"
End Sub
