const XLSX = require('xlsx');
const fs   = require('fs');
const path = require('path');

function escape(val) {
  if (val === null || val === undefined) return '';
  return String(val).replace(/\r\n|\r|\n/g, '').replace(/'/g, "''");
}

function escapeLyric(val) {
  if (val === null || val === undefined) return '';
  return String(val).replace(/\r/g, '').replace(/'/g, "''");
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
    const lyric          = escapeLyric(row.lyrics);
    const correctMembers = escape(row.correct_members);
    const seq            = parseInt(row.seq);
    const sectionName    = escape(row.section_name);
    const easy           = row.easy   ?? 0;
    const normal         = row.normal ?? 0;
    const hard           = row.hard   ?? 0;
    const expert         = row.expert ?? 0;
    const occurrence     = row.occurrence || null;
    const occSql         = occurrence ? `'${occurrence}'::smallint[]` : 'NULL';
    const needsHint      = (row.needs_hint === true || row.needs_hint == 1 || row.needs_hint === 'true' || row.needs_hint === 't') ? 'true' : 'false';

    let block = `DO $$ DECLARE v_sounds_id bigint; v_lyrics_id bigint; BEGIN `;
    block += `SELECT id INTO v_sounds_id FROM sounds WHERE group_name = '${groupName}' AND song_name = '${songName}'; `;
    block += `IF v_sounds_id IS NULL THEN `;
    block += `INSERT INTO sounds (group_name, song_name, is_active) VALUES ('${groupName}', '${songName}', true) RETURNING id INTO v_sounds_id; `;
    block += `END IF; `;
    block += `INSERT INTO lyrics (sounds_id, lyric, section_name, seq, is_active, occurrence, needs_hint) VALUES (v_sounds_id, '${lyric}', '${sectionName}', ${seq}, true, ${occSql}, ${needsHint}) RETURNING id INTO v_lyrics_id; `;
    if (correctMembers) {
      block += `INSERT INTO lyric_members (lyric_id, member_id) SELECT v_lyrics_id, id FROM members WHERE name = ANY(string_to_array('${correctMembers}', ',')); `;
    }
    block += `INSERT INTO quizzes (lyrics_id, easy, normal, hard, expert, is_active) VALUES (v_lyrics_id, ${easy}, ${normal}, ${hard}, ${expert}, true); `;
    block += `END $$;`;

    lines.push(block);
  }

  return lines.join('\n');
}

function loadRows(xlsmPath) {
  const wb   = XLSX.readFile(xlsmPath);
  const ws   = wb.Sheets[wb.SheetNames[0]];
  const rows = XLSX.utils.sheet_to_json(ws, { defval: null });
  if (rows.length === 0) { console.error('ERROR: シートにデータがありません。'); process.exit(1); }
  return rows;
}

function loadRowsFromSheet(xlsmPath, sheetName) {
  const wb     = XLSX.readFile(xlsmPath);
  const wsName = wb.SheetNames.includes(sheetName) ? sheetName : wb.SheetNames[0];
  const ws     = wb.Sheets[wsName];
  const rows   = XLSX.utils.sheet_to_json(ws, { defval: null });
  if (rows.length === 0) { console.error('ERROR: シートにデータがありません。'); process.exit(1); }
  return rows;
}

function toBoolOrNull(val) {
  if (val === true || val === 1 || val === '1' || val === 'true' || val === 'TRUE') return 'true';
  if (val === false || val === 0 || val === '0' || val === 'false' || val === 'FALSE') return 'false';
  return 'NULL';
}

// lyrics_dev."unique" / length / weight の更新（"lyrics"シート、id列で直接更新）
// length は char_count 列（CountLyricChars関数で算出した文字数）の値を使う。
// 半角アルファベット0.5文字換算で小数になることがあるため、smallint列に入れる前に四捨五入する。
// weight は前後の歌詞や歌詞自体に歌い手の名前が入っていて簡単すぎる歌詞の出題率を
// 下げるための値（未入力ならNULL→アプリ側で1扱い）。
function generateUpdateLyricTags(xlsmPath) {
  const lines = [];
  for (const row of loadRowsFromSheet(xlsmPath, 'lyrics')) {
    const id = parseInt(row.id);
    if (!id) continue;
    const uniqueVal = toBoolOrNull(row['unique']);
    const rawLength = row.char_count ?? row.length;
    const lengthVal = (rawLength === null || rawLength === undefined || rawLength === '') ? 'NULL' : Math.round(parseFloat(rawLength));
    const rawWeight = row.weight;
    const weightVal = (rawWeight === null || rawWeight === undefined || rawWeight === '') ? 'NULL' : parseFloat(rawWeight);
    lines.push(`UPDATE lyrics_dev SET "unique" = ${uniqueVal}, length = ${lengthVal}, weight = ${weightVal} WHERE id = ${id};`);
  }
  return lines.join('\n');
}

// lyrics_dev.length のみの更新（"lyrics"シート、id列で直接更新）
// unique / weight には触れない。lengthだけ直したい場合に使う。
function generateUpdateLyricLength(xlsmPath) {
  const lines = [];
  for (const row of loadRowsFromSheet(xlsmPath, 'lyrics')) {
    const id = parseInt(row.id);
    if (!id) continue;
    const rawLength = row.char_count ?? row.length;
    if (rawLength === null || rawLength === undefined || rawLength === '') continue;
    const lengthVal = Math.round(parseFloat(rawLength));
    lines.push(`UPDATE lyrics_dev SET length = ${lengthVal} WHERE id = ${id};`);
  }
  return lines.join('\n');
}

// lyrics_dev.weight のみの更新（"lyrics"シート、id列で直接更新）
// unique / length には触れない。weightに値を入れた行だけSQLを生成する（空欄はスキップ）。
function generateUpdateLyricWeight(xlsmPath) {
  const lines = [];
  for (const row of loadRowsFromSheet(xlsmPath, 'lyrics')) {
    const id = parseInt(row.id);
    if (!id) continue;
    const rawWeight = row.weight;
    if (rawWeight === null || rawWeight === undefined || rawWeight === '') continue;
    const weightVal = parseFloat(rawWeight);
    lines.push(`UPDATE lyrics_dev SET weight = ${weightVal} WHERE id = ${id};`);
  }
  return lines.join('\n');
}

// sounds.mv / fam / bars_per_phrase の更新（"sounds_tags"シート、id列で直接更新）
function generateUpdateSoundsTags(xlsmPath) {
  const lines = [];
  for (const row of loadRowsFromSheet(xlsmPath, 'sounds_tags')) {
    const id = parseInt(row.id);
    if (!id) continue;
    const barsPerPhrase = (row.bars_per_phrase === null || row.bars_per_phrase === undefined || row.bars_per_phrase === '') ? 'NULL' : parseInt(row.bars_per_phrase);
    lines.push(`UPDATE sounds SET mv = ${toBoolOrNull(row.mv)}, fam = ${toBoolOrNull(row.fam)}, bars_per_phrase = ${barsPerPhrase} WHERE id = ${id};`);
  }
  return lines.join('\n');
}

// lyrics_dev.lyric の更新（"lyrics"シート、id列で直接更新）
function generateUpdateLyric(xlsmPath) {
  const lines = [];
  for (const row of loadRowsFromSheet(xlsmPath, 'lyrics')) {
    const id = parseInt(row.id);
    if (!id) continue;
    const lyric = escapeLyric(row.lyric);
    lines.push(`UPDATE lyrics_dev SET lyric = '${lyric}' WHERE id = ${id};`);
  }
  return lines.join('\n');
}

function generateUpdateDifficulty(xlsmPath) {
  const lines = [];
  for (const row of loadRows(xlsmPath)) {
    const groupName = escape(row.group_name);
    const songName  = escape(row.song_name);
    const seq       = parseInt(row.seq);
    const easy      = row.easy   ?? 0;
    const normal    = row.normal ?? 0;
    const hard      = row.hard   ?? 0;
    const expert    = row.expert ?? 0;
    let block = `DO $$ DECLARE v_lyrics_id bigint; BEGIN `;
    block += `SELECT l.id INTO v_lyrics_id FROM lyrics_dev l JOIN sounds s ON l.sounds_id = s.id WHERE s.group_name = '${groupName}' AND s.song_name = '${songName}' AND l.seq = ${seq}; `;
    block += `UPDATE quizzes SET easy = ${easy}, normal = ${normal}, hard = ${hard}, expert = ${expert} WHERE lyrics_id = v_lyrics_id; `;
    block += `END $$;`;
    lines.push(block);
  }
  return lines.join('\n');
}

function generateUpdateLyricAndDifficulty(xlsmPath) {
  const lines = [];
  for (const row of loadRows(xlsmPath)) {
    const groupName = escape(row.group_name);
    const songName  = escape(row.song_name);
    const lyric     = escapeLyric(row.lyric);
    const seq       = parseInt(row.seq);
    const easy      = row.easy   ?? 0;
    const normal    = row.normal ?? 0;
    const hard      = row.hard   ?? 0;
    const expert    = row.expert ?? 0;
    let block = `DO $$ DECLARE v_lyrics_id bigint; BEGIN `;
    block += `SELECT l.id INTO v_lyrics_id FROM lyrics_dev l JOIN sounds s ON l.sounds_id = s.id WHERE s.group_name = '${groupName}' AND s.song_name = '${songName}' AND l.seq = ${seq}; `;
    block += `UPDATE lyrics_dev SET lyric = '${lyric}' WHERE id = v_lyrics_id; `;
    block += `UPDATE quizzes SET easy = ${easy}, normal = ${normal}, hard = ${hard}, expert = ${expert} WHERE lyrics_id = v_lyrics_id; `;
    block += `END $$;`;
    lines.push(block);
  }
  return lines.join('\n');
}

function generateUpdateLyricAndOccurrence(xlsmPath) {
  const lines = [];
  for (const row of loadRows(xlsmPath)) {
    const groupName  = escape(row.group_name);
    const songName   = escape(row.song_name);
    const seq        = parseInt(row.seq);
    const lyric      = escapeLyric(row.lyrics);
    const occurrence = row.occurrence || null;
    const occSql     = occurrence ? `'${occurrence}'::smallint[]` : 'NULL';
    lines.push(
      `UPDATE lyrics_dev SET lyric = '${lyric}', occurrence = ${occSql} WHERE sounds_id = (SELECT id FROM sounds WHERE group_name = '${groupName}' AND song_name = '${songName}') AND seq = ${seq};`
    );
  }
  return lines.join('\n');
}

function generateUpdateAll(xlsmPath) {
  const lines = [];
  for (const row of loadRows(xlsmPath)) {
    const groupName      = escape(row.group_name);
    const songName       = escape(row.song_name);
    const seq            = parseInt(row.seq);
    const lyric          = escapeLyric(row.lyrics);
    const occurrence     = row.occurrence || null;
    const occSql         = occurrence ? `'${occurrence}'::smallint[]` : 'NULL';
    const sectionName    = escape(row.section_name);
    const correctMembers = escape(row.correct_members);
    const easy           = row.easy   ?? 0;
    const normal         = row.normal ?? 0;
    const hard           = row.hard   ?? 0;
    const expert         = row.expert ?? 0;

    let block = `DO $$ DECLARE v_lyrics_id bigint; BEGIN `;
    block += `SELECT l.id INTO v_lyrics_id FROM lyrics_dev l JOIN sounds s ON l.sounds_id = s.id WHERE s.group_name = '${groupName}' AND s.song_name = '${songName}' AND l.seq = ${seq}; `;
    block += `UPDATE lyrics_dev SET lyric = '${lyric}', occurrence = ${occSql}, section_name = '${sectionName}' WHERE id = v_lyrics_id; `;
    block += `UPDATE quizzes SET easy = ${easy}, normal = ${normal}, hard = ${hard}, expert = ${expert} WHERE lyrics_id = v_lyrics_id; `;
    block += `DELETE FROM lyric_members WHERE lyric_id = v_lyrics_id; `;
    if (correctMembers) {
      block += `INSERT INTO lyric_members (lyric_id, member_id) SELECT v_lyrics_id, id FROM members WHERE name = ANY(string_to_array('${correctMembers}', ',')); `;
    }
    block += `END $$;`;
    lines.push(block);
  }
  return lines.join('\n');
}

function generateUpdateMembers(xlsmPath) {
  const lines = [];
  for (const row of loadRows(xlsmPath)) {
    const groupName      = escape(row.group_name);
    const songName       = escape(row.song_name);
    const seq            = parseInt(row.seq);
    const correctMembers = escape(row.correct_members);
    let block = `DO $$ DECLARE v_lyrics_id bigint; BEGIN `;
    block += `SELECT l.id INTO v_lyrics_id FROM lyrics_dev l JOIN sounds s ON l.sounds_id = s.id WHERE s.group_name = '${groupName}' AND s.song_name = '${songName}' AND l.seq = ${seq}; `;
    block += `DELETE FROM lyric_members WHERE lyric_id = v_lyrics_id; `;
    if (correctMembers) {
      block += `INSERT INTO lyric_members (lyric_id, member_id) SELECT v_lyrics_id, id FROM members WHERE name = ANY(string_to_array('${correctMembers}', ',')); `;
    }
    block += `END $$;`;
    lines.push(block);
  }
  return lines.join('\n');
}

const mode = process.argv[2];

const xlsmFiles = fs.readdirSync('.').filter(f => f.toLowerCase().endsWith('.xlsm'));
if (xlsmFiles.length === 0) {
  console.error('ERROR: .xlsmファイルが見つかりません。sqlフォルダに配置してください。');
  process.exit(1);
}

const inputFile = xlsmFiles[0];
const baseName  = path.basename(inputFile, path.extname(inputFile));

const modeMap = {
  'u-l':  { fn: generateUpdateLyric,                suffix: '_update_lyric' },
  'u-d':  { fn: generateUpdateDifficulty,           suffix: '_update_difficulty' },
  'u-dl': { fn: generateUpdateLyricAndDifficulty,   suffix: '_update_lyric_difficulty' },
  'u-lo': { fn: generateUpdateLyricAndOccurrence,   suffix: '_update_lyric_occurrence' },
  'u-a':  { fn: generateUpdateAll,                  suffix: '_update_all' },
  'u-m':  { fn: generateUpdateMembers,              suffix: '_update_members' },
  'u-t':  { fn: generateUpdateLyricTags,            suffix: '_update_lyric_tags' },
  'u-len': { fn: generateUpdateLyricLength,         suffix: '_update_lyric_length' },
  'u-w':  { fn: generateUpdateLyricWeight,          suffix: '_update_lyric_weight' },
  'u-st': { fn: generateUpdateSoundsTags,            suffix: '_update_sounds_tags' },
};

if (mode && modeMap[mode]) {
  const { fn, suffix } = modeMap[mode];
  const outputFile = baseName + suffix + '.sql';
  const sql = fn(inputFile);
  fs.writeFileSync(outputFile, sql, 'utf8');
  console.log(`完了: ${inputFile} → ${outputFile} (${sql.split('\n').length}行のSQL)`);
} else if (!mode) {
  const outputFile = baseName + '.sql';
  const sql = generateSql(inputFile);
  fs.writeFileSync(outputFile, sql, 'utf8');
  console.log(`完了: ${inputFile} → ${outputFile} (${sql.split('\n').length}行のSQL)`);
} else {
  console.error(`ERROR: 不明なモード "${mode}"`);
  console.error('使い方: node excel_to_sql.js [u-l | u-d | u-dl | u-lo | u-a | u-m | u-t | u-len | u-w | u-st]');
  process.exit(1);
}
