const XLSX = require('xlsx');
const fs   = require('fs');
const path = require('path');

function escape(val) {
  if (val === null || val === undefined) return '';
  return String(val).replace(/\r\n|\r|\n/g, '').replace(/'/g, "''");
}

function generateSql(xlsmPath) {
  const wb   = XLSX.readFile(xlsmPath);
  const ws   = wb.Sheets[wb.SheetNames[0]];
  const rows = XLSX.utils.sheet_to_json(ws, { defval: null });

  if (rows.length === 0) {
    console.error('ERROR: シートにデータがありません。');
    process.exit(1);
  }

  const lines = [];

  for (const row of rows) {
    const groupName      = escape(row.group_name);
    const songName       = escape(row.song_name);
    const lyric          = escape(row.lyric);
    const correctMembers = escape(row.correct_members);
    const seq            = parseInt(row.seq);
    const sectionName    = escape(row.section_name);
    const easy           = row.easy   ?? 0;
    const normal         = row.normal ?? 0;
    const hard           = row.hard   ?? 0;
    const expert         = row.expert ?? 0;

    let block = `DO $$ DECLARE v_sounds_id bigint; v_lyrics_id bigint; BEGIN `;
    block += `SELECT id INTO v_sounds_id FROM sounds WHERE group_name = '${groupName}' AND song_name = '${songName}'; `;
    block += `IF v_sounds_id IS NULL THEN `;
    block += `INSERT INTO sounds (group_name, song_name, is_active) VALUES ('${groupName}', '${songName}', true) RETURNING id INTO v_sounds_id; `;
    block += `END IF; `;
    block += `INSERT INTO lyrics (sounds_id, lyric, section_name, seq, is_active) VALUES (v_sounds_id, '${lyric}', '${sectionName}', ${seq}, true) RETURNING id INTO v_lyrics_id; `;
    if (correctMembers) {
      block += `INSERT INTO lyric_members (lyric_id, member_id) SELECT v_lyrics_id, id FROM members WHERE name = ANY(string_to_array('${correctMembers}', ',')); `;
    }
    block += `INSERT INTO quizzes (lyrics_id, easy, normal, hard, expert, is_active) VALUES (v_lyrics_id, ${easy}, ${normal}, ${hard}, ${expert}, true); `;
    block += `END $$;`;

    lines.push(block);
  }

  return lines.join('\n');
}

const xlsmFiles = fs.readdirSync('.').filter(f => f.toLowerCase().endsWith('.xlsm'));
if (xlsmFiles.length === 0) {
  console.error('ERROR: .xlsmファイルが見つかりません。sqlフォルダに配置してください。');
  process.exit(1);
}

const inputFile  = xlsmFiles[0];
const outputFile = path.basename(inputFile, path.extname(inputFile)) + '.sql';

const sql = generateSql(inputFile);
fs.writeFileSync(outputFile, sql, 'utf8');
console.log(`完了: ${inputFile} → ${outputFile} (${sql.split('\n').length}行のSQL)`);
