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
    const lyric          = escapeLyric(row.lyric);
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

function loadRows(xlsmPath) {
  const wb   = XLSX.readFile(xlsmPath);
  const ws   = wb.Sheets[wb.SheetNames[0]];
  const rows = XLSX.utils.sheet_to_json(ws, { defval: null });
  if (rows.length === 0) { console.error('ERROR: シートにデータがありません。'); process.exit(1); }
  return rows;
}

function generateUpdateLyric(xlsmPath) {
  const lines = [];
  for (const row of loadRows(xlsmPath)) {
    const groupName = escape(row.group_name);
    const songName  = escape(row.song_name);
    const lyric     = escapeLyric(row.lyric);
    const seq       = parseInt(row.seq);
    lines.push(
      `UPDATE lyrics SET lyric = '${lyric}' WHERE sounds_id = (SELECT id FROM sounds WHERE group_name = '${groupName}' AND song_name = '${songName}') AND seq = ${seq};`
    );
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
    block += `SELECT l.id INTO v_lyrics_id FROM lyrics l JOIN sounds s ON l.sounds_id = s.id WHERE s.group_name = '${groupName}' AND s.song_name = '${songName}' AND l.seq = ${seq}; `;
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
    block += `SELECT l.id INTO v_lyrics_id FROM lyrics l JOIN sounds s ON l.sounds_id = s.id WHERE s.group_name = '${groupName}' AND s.song_name = '${songName}' AND l.seq = ${seq}; `;
    block += `UPDATE lyrics SET lyric = '${lyric}' WHERE id = v_lyrics_id; `;
    block += `UPDATE quizzes SET easy = ${easy}, normal = ${normal}, hard = ${hard}, expert = ${expert} WHERE lyrics_id = v_lyrics_id; `;
    block += `END $$;`;
    lines.push(block);
  }
  return lines.join('\n');
}

function generateUpdateLyricAndOccurrence(xlsmPath) {
  const wb     = XLSX.readFile(xlsmPath);
  const wsName = wb.SheetNames.includes('quiz_full') ? 'quiz_full' : wb.SheetNames[0];
  const ws     = wb.Sheets[wsName];
  const rows   = XLSX.utils.sheet_to_json(ws, { defval: null });
  if (rows.length === 0) { console.error('ERROR: シートにデータがありません。'); process.exit(1); }

  const lines = [];
  let count = 0;
  for (const row of rows) {
    if (row['new'] != 1) continue;           // new=1 の行だけ対象
    const lyricsId   = parseInt(row.lyrics_id);
    const lyric      = escapeLyric(row.lyrics || row.lyric || '');
    const occurrence = row.occurrence || null;
    const occSql     = occurrence ? `'${occurrence}'::smallint[]` : 'NULL';
    lines.push(`UPDATE lyrics SET lyric = '${lyric}', occurrence = ${occSql} WHERE id = ${lyricsId};`);
    count++;
  }
  console.log(`対象行数: ${count} 件`);
  return lines.join('\n');
}

function generateUpdateNeedsHint(xlsmPath) {
  const wb     = XLSX.readFile(xlsmPath);
  const wsName = wb.SheetNames.includes('quiz_full') ? 'quiz_full' : wb.SheetNames[0];
  const ws     = wb.Sheets[wsName];
  const rows   = XLSX.utils.sheet_to_json(ws, { defval: null });
  if (rows.length === 0) { console.error('ERROR: シートにデータがありません。'); process.exit(1); }

  const lines = [];
  let count = 0;
  const seen = new Set();
  for (const row of rows) {
    if (row['needs_hint'] != 1) continue;
    const lyricsId = parseInt(row.lyrics_id);
    if (seen.has(lyricsId)) continue;
    seen.add(lyricsId);
    lines.push(`UPDATE lyrics SET needs_hint = true WHERE id = ${lyricsId};`);
    count++;
  }
  console.log(`対象行数: ${count} 件`);
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
    block += `SELECT l.id INTO v_lyrics_id FROM lyrics l JOIN sounds s ON l.sounds_id = s.id WHERE s.group_name = '${groupName}' AND s.song_name = '${songName}' AND l.seq = ${seq}; `;
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
  'u-nh': { fn: generateUpdateNeedsHint,            suffix: '_update_needs_hint' },
  'u-m':  { fn: generateUpdateMembers,              suffix: '_update_members' },
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
  console.error('使い方: node excel_to_sql.js [u-l | u-d | u-dl | u-lo | u-nh | u-m]');
  process.exit(1);
}
