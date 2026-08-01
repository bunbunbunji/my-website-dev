import { useState, useEffect, useLayoutEffect, useRef, Fragment } from 'react'
import { createClient } from '@supabase/supabase-js'
import confetti from 'canvas-confetti'
import './App.css'
import logo from './assets/logo.png'

// ===== Supabase 設定 =====
const supabaseUrl = "https://atinpqtedmrfrtdlkpkd.supabase.co";
const supabaseKey = import.meta.env.VITE_SUPABASE_KEY;
const supabase = createClient(supabaseUrl, supabaseKey);

const memberColorCSS = {
  '紫': '#9c27b0', 'オレンジ': '#ff8a65', '空': '#87ceeb', '赤': '#f44336',
  'ミントグリーン': '#4db6ac', 'ベビーピンク': '#ffb6c1', '黄': '#FFB800',
  '水': '#81d4fa', 'ピンク': '#ff69b2', '青': '#2196f3', 'シルバー': '#9e9e9e',
};

// 文字列の正規化（空白と記号を完全に排除）
const superNormalize = (str) => {
  if (!str) return "";
  return str
    .replace(/[！-～]/g, s => String.fromCharCode(s.charCodeAt(0) - 0xFEE0))
    .replace(/[\s　]/g, "")
    .replace(/[^a-zA-Z0-9ぁ-んァ-ヶー一-龠]/g, "")
    .toLowerCase()
    .trim();
};

// 正解メンバーの表示ラベルを組み立てる（全員なら「全員」、それ以外は名前を連結）
const formatCorrectLabel = (members, allFlag) => {
  if (String(allFlag) === '1') return '全員';
  if (members.length < 3) return members.join('・');
  const pairs = [];
  for (let i = 0; i < members.length; i += 2) {
    pairs.push(members.slice(i, i + 2).join('・'));
  }
  return pairs.join('<br>');
};

const renderLineWithAite = (line, keyPrefix = 'a') => {
  if (!/\([^)]+\)/.test(line)) return line;
  return line.split(/(\([^)]+\))/).map((part, i) =>
    /^\([^)]+\)$/.test(part)
      ? <span key={`${keyPrefix}-${i}`} className="aite">{part}</span>
      : part
  );
};

const renderLyricsWithAite = (lyrics) => {
  if (!lyrics) return null;
  if (!/\([^)]+\)/.test(lyrics)) return lyrics;
  const result = [];
  lyrics.split('\n').forEach((line, i) => {
    if (i > 0) result.push('\n');
    const rendered = renderLineWithAite(line, `lo-${i}`);
    Array.isArray(rendered) ? result.push(...rendered) : result.push(rendered);
  });
  return result;
};

// lyric_col に基づいて歌詞行をグループ化する
// col=null → 単独行, col=1 → グループ開始, col=2以上 → 直前グループの末尾に追記
const groupLyricRows = (rows) => {
  const groups = [];
  let cur = null;
  let prevSection = null;
  rows.forEach((row, i) => {
    if (i > 0 && row.section_name !== prevSection) {
      if (cur) { groups.push(cur); cur = null; }
      groups.push({ type: 'section-break', key: `sb-${i}` });
    }
    prevSection = row.section_name;
    if (!row.lyric_col || row.lyric_col === 1) {
      if (cur) groups.push(cur);
      if (!row.lyric_col) {
        groups.push({ type: 'single', row });
        cur = null;
      } else {
        cur = { type: 'group', base: row, appends: [] };
      }
    } else {
      if (cur) cur.appends.push(row);
      else groups.push({ type: 'single', row }); // fallback
    }
  });
  if (cur) groups.push(cur);
  return groups;
};

// グループ化済み歌詞をJSXに変換する
// baseClass: 通常行のクラス名, targetClass: 問題行のクラス名
// targetLyricsId: グループ内のどの歌詞を点滅させるかを指定するID
const renderLyricGroup = (group, isTarget, refProp = {}, baseClass = 'scrolling-lyric-row', targetClass = 'scrolling-lyric-target', targetLyricsId = null) => {
  const spaceChar = (sp) => sp === 'half' ? ' ' : sp === 'full' ? '　' : '';
  const cls = `${baseClass}${isTarget ? ` ${targetClass}` : ''}`;

  if (group.type === 'single') {
    if (!isTarget) {
      return (
        <div {...refProp} className={cls}>
          {group.row.lyrics}
        </div>
      );
    }
    const rowLines = (group.row.lyrics || '').split('\n');
    // 全行が同一テキストの繰り返し（「まだ まだ まだ まだ」等）の場合のみ、
    // 最終行だけが実際の問題歌詞なのでそこだけ点滅させ、他は薄く表示する。
    // 内容の異なる複数行（1つのフレーズが2行にまたがる場合）はまとめて点滅させる。
    const isRepeatedPhrase = rowLines.length > 1 && rowLines.every(l => l.trim() === rowLines[0].trim());
    if (!isRepeatedPhrase) {
      return (
        <div {...refProp} className={cls}>
          <span className="lyric-blink-text">{group.row.lyrics}</span>
        </div>
      );
    }
    return (
      <div {...refProp} className={cls}>
        {rowLines.map((line, i) => (
          <Fragment key={i}>
            {i > 0 && <br />}
            {i === rowLines.length - 1
              ? <span className="lyric-blink-text">{line}</span>
              : <span className="lyric-group-dim">{line}</span>}
          </Fragment>
        ))}
      </div>
    );
  }

  // col=1 のテキストを行分割し、最終行に col=2以降をインラインで追記
  const lines = (group.base.lyrics || '').split('\n');
  const lastLine = lines[lines.length - 1];
  const prevLines = lines.slice(0, -1);

  // targetLyricsId が指定されていれば、対象の歌詞だけに lyric-blink-text を適用
  const baseIsTarget = isTarget && targetLyricsId != null && group.base.lyrics_id === targetLyricsId;
  const shouldDimOthers = isTarget && targetLyricsId != null;

  const groupContent = (
    <>
      {prevLines.map((line, i) => (
        <Fragment key={i}>
          {baseIsTarget
            ? <span className="lyric-blink-text">{line}</span>
            : shouldDimOthers ? <span className="lyric-group-dim">{line}</span> : line}
          <br />
        </Fragment>
      ))}
      {baseIsTarget
        ? <span className="lyric-blink-text">{lastLine}</span>
        : <span className={shouldDimOthers ? 'lyric-group-dim' : undefined}>{lastLine}</span>}
      {group.appends.map((ap, ai) => {
        const prevRow = ai === 0 ? group.base : group.appends[ai - 1];
        const apIsTarget = isTarget && targetLyricsId != null && ap.lyrics_id === targetLyricsId;
        return (
          <span key={ai} className={`lyric-inline-append${shouldDimOthers && !apIsTarget ? ' lyric-group-dim' : ''}`}>
            {spaceChar(prevRow.col_space)}
            {apIsTarget
              ? <span className="lyric-blink-text">{ap.lyrics}</span>
              : ap.lyrics}
          </span>
        );
      })}
    </>
  );

  return (
    <div {...refProp} className={cls}>
      {groupContent}
    </div>
  );
};


function App() {
  const [termsAgreed, setTermsAgreed] = useState(() =>
    localStorage.getItem('kawaii_terms_agreed') === 'true'
  );

  const handleTermsAgree = () => {
    localStorage.setItem('kawaii_terms_agreed', 'true');
    setTermsAgreed(true);
  };

  const [screen, setScreen] = useState('top');
  const [showPolicy, setShowPolicy] = useState(false);
  const [showProfile, setShowProfile] = useState(false);
  const [closingPolicy, setClosingPolicy] = useState(false);
  const [closingProfile, setClosingProfile] = useState(false);

  const closePolicy = () => { setClosingPolicy(true); setTimeout(() => { setShowPolicy(false); setClosingPolicy(false); }, 220); };
  const closeProfile = () => { setClosingProfile(true); setTimeout(() => { setShowProfile(false); setClosingProfile(false); }, 220); };
  const [tooltipLevel, setTooltipLevel] = useState(null);
  const [tooltipClosing, setTooltipClosing] = useState(false);
  const [timerLevel, setTimerLevel] = useState(null);
  const [timerKey, setTimerKey] = useState(0);
  const [closingResumeModal, setClosingResumeModal] = useState(false);
  const [closingSongModal, setClosingSongModal] = useState(false);
  const tooltipHoverTimerRef = useRef(null);
  const tooltipCloseTimerRef = useRef(null);
  const longPressTimerRef = useRef(null);
  const longPressTriggeredRef = useRef(false);
  const touchEndedRef = useRef(false);
  const touchEndTimerRef = useRef(null);
  const touchAnnotRef = useRef(null);

  const openTooltip = (level) => {
    clearTimeout(tooltipCloseTimerRef.current);
    setTooltipClosing(false);
    setTooltipLevel(level);
  };
  const closeTooltip = () => {
    setTooltipClosing(true);
    tooltipCloseTimerRef.current = setTimeout(() => {
      setTooltipLevel(null);
      setTooltipClosing(false);
    }, 200);
  };

  const closeResumeModal = () => { setClosingResumeModal(true); setTimeout(() => { setShowResumeModal(false); setClosingResumeModal(false); }, 220); };
  const closeSongModal = () => { setClosingSongModal(true); setTimeout(() => { setSongModal(null); setClosingSongModal(false); }, 220); };

  const [quizState, setQuizState] = useState({
    group: null,
    difficulty: null,
    currentIndex: 0,
    correctCount: 0,
    quizzes: []
  });

  const [members, setMembers] = useState([]);
  const [selectedMembers, setSelectedMembers] = useState(new Set());
  const [isPreparing, setIsPreparing] = useState(false);
  const [statusMsg, setStatusMsg] = useState("問題を準備しています…");
  const [answered, setAnswered] = useState(false);
  const [resultMsg, setResultMsg] = useState({ text: "", type: "" });
  const [displayScore, setDisplayScore] = useState(0);
  const [resultPhase, setResultPhase] = useState('idle');

  // --- モード管理 ---
  const [gameMode, setGameMode] = useState('normal'); // 'normal' | 'endless'
  const [questionTimer, setQuestionTimer] = useState(60);
  const questionTimerIntervalRef = useRef(null);
  const timerStartRef = useRef(null);

  // --- エンドレスモード ---
  const endlessPoolRef = useRef([]);
  const endlessPendingNotifRef = useRef(null);
  const [endlessQNum, setEndlessQNum] = useState(1);
  const [endlessLives, setEndlessLives] = useState(3);
  const [endlessConsecutive, setEndlessConsecutive] = useState(0);
  const [endlessIsOver, setEndlessIsOver] = useState(false);
  const [endlessNextQ, setEndlessNextQ] = useState(null);
  const [endlessNextQLoading, setEndlessNextQLoading] = useState(false);
  const [nextQLoading, setNextQLoading] = useState(false);
  const [endlessLifeBonus, setEndlessLifeBonus] = useState({ type: 'none', amount: 0, key: 0 });
  const [endlessDiffNotif, setEndlessDiffNotif] = useState({ text: '', key: 0 });
  const [endlessUnlockedGroups, setEndlessUnlockedGroups] = useState(() => {
    const saved = localStorage.getItem('kawaii_endless_unlocked_groups');
    return new Set(saved ? JSON.parse(saved) : []);
  });
  const [endlessNewUnlockNotif, setEndlessNewUnlockNotif] = useState('');

  // --- カスタムモード ---
  const [customSelectedGroups, setCustomSelectedGroups] = useState(new Set());
  const [customSongList, setCustomSongList] = useState([]);
  const [customSelectedSongs, setCustomSelectedSongs] = useState(new Set());
  const customQueueRef = useRef([]);
  const customOriginalPoolRef = useRef([]);
  const customResultReadyRef = useRef(false);
  const [customTotalQ, setCustomTotalQ] = useState(0);
  const [customRemaining, setCustomRemaining] = useState(0);
  const [customAnsweredTotal, setCustomAnsweredTotal] = useState(0);
  const [customWrongAnswers, setCustomWrongAnswers] = useState([]);
  const [customMembersByGroup, setCustomMembersByGroup] = useState({});
  const [customIsLoading, setCustomIsLoading] = useState(false);
  const [customDifficulties, setCustomDifficulties] = useState(new Set(['easy', 'normal', 'hard', 'expert']));
  const [customDiffError, setCustomDiffError] = useState(false);
  const [customIsLoadingSongs, setCustomIsLoadingSongs] = useState(false);
  const [customQuitModal, setCustomQuitModal] = useState(false);
  const [customUnlocked, setCustomUnlocked] = useState(() => localStorage.getItem('kawaii_custom_unlocked') === 'true');
  const [customNewUnlockNotif, setCustomNewUnlockNotif] = useState(false);
  const [newlyUnlockedMode, setNewlyUnlockedMode] = useState(null); // 'custom' | 'endless' | null
  const [debugForceHideEndless, setDebugForceHideEndless] = useState(false);
  const [debugForceHideCustom, setDebugForceHideCustom] = useState(false);
  const [pendingEndlessReveal, setPendingEndlessReveal] = useState(false);
  const [pendingCustomReveal, setPendingCustomReveal] = useState(false);
  const [isUnlockAnimating, setIsUnlockAnimating] = useState(false);

  const [songListData, setSongListData] = useState([]);
  const [isLoadingList, setIsLoadingList] = useState(false);
  const [songModal, setSongModal] = useState(null);
  const [songModalData, setSongModalData] = useState([]);
  const [songModalMembers, setSongModalMembers] = useState([]);
  const [isLoadingSongModal, setIsLoadingSongModal] = useState(false);

  const [sessionId, setSessionId] = useState(null);
  const [pendingResume, setPendingResume] = useState(null);
  const [isResumingSession, setIsResumingSession] = useState(false);
  const [showResumeModal, setShowResumeModal] = useState(false);
  const [resumeModalSource, setResumeModalSource] = useState('group');
  const [showBackConfirm, setShowBackConfirm] = useState(false);

  // --- 検定モード 新クイズフロー ---
  const [quizPhase, setQuizPhase] = useState(null); // 'announce' | 'scrolling' | 'question'
  const [fullSongLyrics, setFullSongLyrics] = useState([]);
  const [showFullLyrics, setShowFullLyrics] = useState(false);
  const [fullLyricsBlink, setFullLyricsBlink] = useState(false);
  const [isLoadingLyrics, setIsLoadingLyrics] = useState(false);

  const openSongModal = async (title, groupName) => {
    setSongModal({ title, groupName });
    setSongModalData([]);
    setSongModalMembers([]);
    setIsLoadingSongModal(true);
    const { data } = await supabase
      .from('quiz_full_dev')
      .select('lyrics, correct_members, seq, section_name, easy, normal, hard, expert, occurrence, lyric_col, col_space')
      .eq('group_name', groupName)
      .eq('song_name', title)
      .order('seq');
    setSongModalData(data || []);
    const { data: mData } = await supabase
      .from('members')
      .select('name, Last_name, color')
      .eq('group_name', groupName);
    setSongModalMembers(mData || []);
    setIsLoadingSongModal(false);
  };

  const diffTooltipRef = useRef(null);
  const lyricsRef = useRef(null);
  const commentRef = useRef(null);
  const questionLyricScrollRef = useRef(null);
  const fullLyricsHighlightRef = useRef(null);
  const lyricBodyRef  = useRef(null);
  const [scrollAnimPhase, setScrollAnimPhase] = useState('scrolling'); // 'scrolling' | 'zooming'
  const rankRef = useRef(null);
  const descTextRef = useRef(null);
  const catchText1Ref = useRef(null);
  const catchText2Ref = useRef(null);
  const listBtnRef = useRef(null);
  const activeSoundsIdsRef = useRef([]);


  const DEBUG_ENABLED = true; // ?debug によるデバッグモードを有効にする (本番マージ時は false に)
  const debugMode = DEBUG_ENABLED && new URLSearchParams(window.location.search).has('debug');
  const [debugScore, setDebugScore] = useState(0);
  const [debugGroup, setDebugGroup] = useState('FRUITS ZIPPER');
  const [debugDiff, setDebugDiff] = useState('easy');
  const [debugQuizId, setDebugQuizId] = useState('');
  const [debugQuizStatus, setDebugQuizStatus] = useState('');
  const [debugPanelOpen, setDebugPanelOpen] = useState(true);

  const debugGroups = ['FRUITS ZIPPER', 'CANDY TUNE', 'SWEET STEADY', 'CUTIE STREET', 'MORE STAR'];
  const debugDiffs = ['easy', 'normal', 'hard', 'expert'];

  const difficultyLabel = { easy: "やさしい", normal: "ふつう", hard: "むずかしい", expert: "げきむず" };

  // --- エンドレスモード補助関数 ---
  const getEndlessEligiblePool = (pool, qNum) => {
    const try_ = (fn) => { const r = pool.filter(fn); return r.length > 0 ? r : null; };
    if (qNum <= 10)
      return try_(q => q.easy > 0) || try_(q => q.normal > 0) || try_(q => q.hard > 0) || pool;
    if (qNum <= 20)
      return try_(q => q.easy > 0 || q.normal > 0) || try_(q => q.hard > 0) || pool;
    if (qNum <= 35)
      return try_(q => q.normal > 0) || try_(q => q.easy > 0) || try_(q => q.hard > 0) || pool;
    if (qNum <= 50)
      return try_(q => q.normal > 0 || q.hard > 0) || try_(q => q.expert > 0) || pool;
    if (qNum <= 70)
      return try_(q => q.hard > 0) || try_(q => q.normal > 0) || try_(q => q.expert > 0) || pool;
    return try_(q => q.hard > 0 || q.expert > 0) || try_(q => q.normal > 0) || try_(q => q.easy > 0) || pool;
  };

  const selectEndlessWeighted = (eligible) => {
    return eligible[Math.floor(Math.random() * eligible.length)];
  };

  const prefetchEndlessNext = (pool, nextQNum) => {
    const eligible = getEndlessEligiblePool(pool, nextQNum);
    if (!eligible || eligible.length === 0) { setEndlessNextQ(null); setEndlessNextQLoading(false); return; }
    const selected = selectEndlessWeighted(eligible);
    const newPool = pool.filter(q => q.id !== selected.id);
    endlessPoolRef.current = newPool;
    setEndlessNextQ(addSurrounds(selected));
    setEndlessNextQLoading(false);
  };

  // --- カスタムモード補助関数 ---
  const shuffle = (arr) => {
    const a = [...arr];
    for (let i = a.length - 1; i > 0; i--) {
      const j = Math.floor(Math.random() * (i + 1));
      [a[i], a[j]] = [a[j], a[i]];
    }
    return a;
  };

  const loadCustomSongs = async () => {
    setCustomIsLoadingSongs(true);
    const groups = [...customSelectedGroups];
    let allData = [];
    let from = 0;
    let hasMore = true;
    while (hasMore) {
      const { data } = await supabase.from('quiz_full_dev').select('group_name, song_name').in('group_name', groups).in('sounds_id', activeSoundsIdsRef.current).range(from, from + 999);
      if (!data || data.length === 0) { hasMore = false; }
      else { allData = [...allData, ...data]; from += 1000; if (data.length < 1000) hasMore = false; }
    }
    const seen = new Set();
    const songs = allData.filter(s => {
      const key = `${s.group_name}::${s.song_name}`;
      if (seen.has(key)) return false;
      seen.add(key);
      return true;
    }).sort((a, b) => {
      const ORDER = ['FRUITS ZIPPER', 'CANDY TUNE', 'SWEET STEADY', 'CUTIE STREET', 'MORE STAR'];
      const gi = ORDER.indexOf(a.group_name) - ORDER.indexOf(b.group_name);
      if (gi !== 0) return gi;
      return a.song_name.localeCompare(b.song_name, 'ja');
    });
    setCustomSongList(songs);
    setCustomSelectedSongs(new Set(songs.map(s => `${s.group_name}::${s.song_name}`)));
    setCustomIsLoadingSongs(false);
    setScreen('custom-select-song');
  };

  const startCustomMode = async () => {
    setCustomIsLoading(true);
    const groups = [...customSelectedGroups];
    let qData = [];
    for (const group of groups) {
      let groupData = getGroupCache(group);
      if (!groupData) {
        groupData = [];
        let from = 0;
        let hasMore = true;
        while (hasMore) {
          const { data } = await supabase.from('quiz_full_dev').select('*').eq('group_name', group).in('sounds_id', activeSoundsIdsRef.current).range(from, from + 999);
          if (!data || data.length === 0) { hasMore = false; }
          else { groupData = [...groupData, ...data]; from += 1000; if (data.length < 1000) hasMore = false; }
        }
        if (groupData.length > 0) setGroupCache(group, groupData);
      }
      qData = [...qData, ...groupData];
    }
    const filtered = qData.filter(q =>
      customSelectedSongs.has(`${q.group_name}::${q.song_name}`) &&
      [...customDifficulties].some(diff => (q[diff] || 0) > 0)
    );
    if (filtered.length === 0) {
      setCustomIsLoading(false);
      setCustomDiffError(true);
      setTimeout(() => setCustomDiffError(false), 3500);
      return;
    }
    const shuffled = shuffle(filtered).map(addSurrounds);
    const { data: mData } = await supabase.from('members').select('*').in('group_name', groups).order('sort_order');
    const memberMap = {};
    (mData || []).forEach(m => {
      if (!memberMap[m.group_name]) memberMap[m.group_name] = [];
      memberMap[m.group_name].push(m);
    });
    customOriginalPoolRef.current = shuffled;
    customQueueRef.current = shuffled;
    setCustomMembersByGroup(memberMap);
    setCustomTotalQ(shuffled.length);
    setCustomRemaining(shuffled.length);
    setCustomWrongAnswers([]);
    setQuizState(prev => ({ ...prev, quizzes: [shuffled[0]], currentIndex: 0, correctCount: 0 }));
    setSelectedMembers(new Set());
    setAnswered(false);
    setResultMsg({ text: '', type: '' });
    setCustomIsLoading(false);
    setGameMode('custom');
    if (shuffled[0]?.sounds_id) await fetchSongLyrics(shuffled[0].sounds_id);
    setScrollAnimPhase('scrolling');
    setQuizPhase('announce');
    setScreen('quiz');
  };

  const nextCustomQuestion = async (isSkip = false) => {
    const queue = customQueueRef.current;
    const newQueue = isSkip ? [...queue.slice(1), queue[0]] : queue.slice(1);
    customQueueRef.current = newQueue;
    if (newQueue.length === 0) { customResultReadyRef.current = false; setCustomAnsweredTotal(customTotalQ); setScreen('result'); return; }
    const nextQ = newQueue[0];
    if (nextQ?.sounds_id) await fetchSongLyrics(nextQ.sounds_id);
    setCustomRemaining(newQueue.length);
    setQuizState(prev => ({ ...prev, quizzes: [nextQ], currentIndex: 0 }));
    setSelectedMembers(new Set());
    setAnswered(false);
    setResultMsg({ text: '', type: '' });
    setShowFullLyrics(false);
    setScrollAnimPhase('scrolling');
    setQuizPhase('announce');
    window.scrollTo({ top: 0, behavior: 'smooth' });
  };

  const restartCustomMode = async () => {
    customResultReadyRef.current = false;
    const shuffled = shuffle(customOriginalPoolRef.current);
    customQueueRef.current = shuffled;
    setCustomRemaining(shuffled.length);
    setCustomTotalQ(shuffled.length);
    setQuizState(prev => ({ ...prev, quizzes: [shuffled[0]], currentIndex: 0, correctCount: 0 }));
    setSelectedMembers(new Set());
    setAnswered(false);
    setResultMsg({ text: '', type: '' });
    setCustomWrongAnswers([]);
    if (shuffled[0]?.sounds_id) await fetchSongLyrics(shuffled[0].sounds_id);
    setScrollAnimPhase('scrolling');
    setQuizPhase('announce');
    setScreen('quiz');
  };


  const descriptions = {
    easy:   ["有名な曲の特徴的な歌詞が選出されます","1人で歌う歌詞が選出されます"],
    normal: ["MVがある曲の歌詞が選出されます","1人で歌う歌詞が選出されます"],
    hard:   ["すべての曲の歌詞から選出されます","1人または全員で歌う歌詞が選出されます", "曲中で繰り返し使われる歌詞も登場します"],
    expert: ["すべての曲の歌詞から選出されます","2人以上で歌う歌詞が選出されます", "曲中で繰り返し使われる歌詞も登場します"],
  };

  const resultMessages = {
    easy: { zero: "え…？やる気ある...？<br>1つも当たらないのはある意味すごいかも。w", low: "本当にちゃんと聴いてるの…？<br>まずは曲をしっかり聴き込みましょう。", mid: "こんなんじゃまだまだ聴いたとは言えない！<br>「やさしい」なら全問正解を目指したいところ！", high: "初心者なら及第点！<br>次は全問正解に挑戦だ！", perfect: "全問正解！ナイスです！<br>「やさしい」はもう余裕かな？次の難易度にレッツゴー！" },
    normal: { zero: "全滅…だと…！？<br>泣きたい気持ちを抑えて、もう1回チャレンジ！", low: "まだまだ聴き込み不足！<br>曲をたくさん聴いて耳を鍛えよう。", mid: "まずまずの結果です。<br>さらに聴き込めばもっと正解できるはず！", high: "素晴らしい！<br>そろそろファンを名乗ってもいいかもね？", perfect: "全問正解！よくできました！<br>素晴らしい結果です！次は「むずかしい」に挑戦だ！" },
    hard: { zero: "全問不正解…。<br>「むずかしい」の壁はかなり高かったようだ。", low: "この難易度はまだ早かったかも…？<br>でも挑戦する姿勢は最高にかっこいいぜ。", mid: "大健闘！<br>「むずかしい」でこれだけ解ければ相当なもの。", high: "すごい！よくここまで正解できましたね！<br>全問正解までもうちょっと。もう一回チャレンジだ！", perfect: "全問正解！コングラッチュレーション！！<br>この難易度で満点はもはや職人の域ですな！" },
    expert: { zero: "へんじがない。ただのしかばねのようだ。<br>0点でも泣かないで。当てる方がおかしいレベルですから。", low: "相手が悪すぎた…。<br>一筋縄ではいかないね。ドンマイドンマイ！", mid: "素晴らしい！<br>この難問揃いで半分解けるとは、なかなかやるな？", high: "素晴らしすぎて鳥肌ものです。<br>もしかしたら本人よりも詳しいかも…！？", perfect: "👼⛩️✨神、降臨✨⛩️👼。<br>あなたは一体何者…？まさか本人？？" }
  };

  // --- アクティブな sounds_id を起動時に取得 ---
  useEffect(() => {
    supabase.from('sounds').select('id').eq('is_active', true)
      .then(({ data }) => { if (data) activeSoundsIdsRef.current = data.map(s => s.id); });
  }, []);


  // --- セッション復元チェック（マウント時）: エンドレスのみ対象 ---
  useEffect(() => {
    const sid = localStorage.getItem('quiz_session_id');
    if (!sid) return;
    supabase.from('sessions').select('*').eq('session_id', sid).maybeSingle()
      .then(({ data }) => {
        if (data && data.difficulty === 'endless') setPendingResume(data);
        else {
          localStorage.removeItem('quiz_session_id');
          if (data) supabase.from('sessions').delete().eq('session_id', data.session_id).then(() => {});
        }
      });
  }, []);

  // --- クイズ開始 ---
  const startQuiz = async () => {
    if (gameMode === 'endless') {
      // 既存セッションがあれば削除してから新規作成
      if (sessionId) {
        await supabase.from('sessions').delete().eq('session_id', sessionId);
        localStorage.removeItem('quiz_session_id');
        setSessionId(null);
      }
      setSelectedMembers(new Set());
      const currentQ = quizState.quizzes[0];
      const poolIds = endlessPoolRef.current.map(q => q.id);
      const { data } = await supabase.from('sessions').insert({
        group_name: quizState.group,
        difficulty: 'endless',
        current_step: 1,
        quiz_ids: { current: currentQ?.id, pool: poolIds, lives: 3, consecutive: 0 },
        correct_count: 0
      }).select('session_id').single();
      if (data?.session_id) {
        localStorage.setItem('quiz_session_id', data.session_id);
        setSessionId(data.session_id);
      }
      setScrollAnimPhase('scrolling');
      if (currentQ?.sounds_id) await fetchSongLyrics(currentQ.sounds_id);
      setQuizPhase('announce');
      setScreen('quiz');
      return;
    }
    // 検定モード・カスタムモード: セッション不要
    setSelectedMembers(new Set());
    setPendingResume(null);
    if (gameMode !== 'endless') {
      setShowFullLyrics(false);
      setScrollAnimPhase('scrolling');
      setQuizPhase('announce');
    }
    setScreen('quiz');
  };

  // --- エンドレスセッション復元 ---
  const resumeQuiz = async () => {
    setIsResumingSession(true);
    const s = pendingResume;
    const saved = s.quiz_ids; // { current, pool, lives, consecutive }

    // 現在の問題と残プールを取得
    const [{ data: qData }, { data: mData }, { data: pData }] = await Promise.all([
      supabase.from('quiz_full_dev').select('*').eq('id', saved.current).single(),
      supabase.from('members').select('*').eq('group_name', s.group_name).order('sort_order'),
      saved.pool?.length > 0
        ? supabase.from('quiz_full_dev').select('*').in('id', saved.pool)
        : Promise.resolve({ data: [] }),
    ]);
    const poolData = pData || [];
    const q1 = addSurrounds(qData);

    const lives = saved.lives ?? 3;
    const consecutive = saved.consecutive ?? 0;
    const qNum = s.current_step ?? 1;

    endlessPoolRef.current = poolData;
    endlessPendingNotifRef.current = null;
    setEndlessQNum(qNum);
    setEndlessLives(lives);
    setEndlessConsecutive(consecutive);
    setEndlessIsOver(false);
    setEndlessLifeBonus({ type: 'none', amount: 0, key: 0 });
    setEndlessDiffNotif({ text: '', key: 0 });
    setMembers(mData || []);
    setQuizState({
      group: s.group_name,
      difficulty: null,
      currentIndex: 0,
      correctCount: s.correct_count,
      quizzes: [q1]
    });
    setSessionId(s.session_id);
    setPendingResume(null);
    setIsResumingSession(false);
    setSelectedMembers(new Set());
    setAnswered(false);
    setResultMsg({ text: '', type: '' });
    setGameMode('endless');
    setScrollAnimPhase('scrolling');
    if (q1?.sounds_id) await fetchSongLyrics(q1.sounds_id);
    setQuizPhase('announce');
    setScreen('quiz');
    prefetchEndlessNext(poolData, qNum + 1);
  };

  // --- セッション破棄 ---
  const discardSession = () => {
    supabase.from('sessions').delete().eq('session_id', pendingResume.session_id).then(() => {});
    localStorage.removeItem('quiz_session_id');
    setPendingResume(null);
  };

  const addSurrounds = (quiz) => ({
    ...quiz,
    surroundPrev: [quiz.surround_prev_2, quiz.surround_prev_1].filter(v => v != null),
    surroundNext: [quiz.surround_next_1, quiz.surround_next_2].filter(v => v != null),
  });

  const fetchSongLyrics = async (soundsId) => {
    setIsLoadingLyrics(true);
    const { data } = await supabase.from('song_lyrics_dev').select('*').eq('sounds_id', soundsId).order('seq');
    setFullSongLyrics(data || []);
    setIsLoadingLyrics(false);
  };

  const QUIZ_CACHE_TTL = 5 * 60 * 1000;
  const getGroupCache = (groupName) => {
    try {
      const cached = sessionStorage.getItem(`quiz_cache_${groupName}`);
      if (!cached) return null;
      const { data, timestamp } = JSON.parse(cached);
      if (Date.now() - timestamp > QUIZ_CACHE_TTL) { sessionStorage.removeItem(`quiz_cache_${groupName}`); return null; }
      return data;
    } catch { return null; }
  };
  const setGroupCache = (groupName, data) => {
    try { sessionStorage.setItem(`quiz_cache_${groupName}`, JSON.stringify({ data, timestamp: Date.now() })); } catch {}
  };

  // --- クイズ準備 ---
  const prepareQuiz = async (selectedGroup, selectedDiff) => {
    setIsPreparing(true);
    setStatusMsg("問題を準備しています…");
    const cachedData = getGroupCache(selectedGroup);
    const { data: mData } = await supabase.from("members").select("*").eq("group_name", selectedGroup).order("sort_order");
    let allData = cachedData;
    if (!allData) {
      allData = [];
      let from = 0;
      while (true) {
        const { data } = await supabase.from("quiz_full_dev").select("*").eq("group_name", selectedGroup).in('sounds_id', activeSoundsIdsRef.current).range(from, from + 999);
        if (!data || data.length === 0) break;
        allData = allData.concat(data);
        if (data.length < 1000) break;
        from += 1000;
      }
      if (allData.length > 0) setGroupCache(selectedGroup, allData);
    }
    const qData = allData.filter(q => (q[selectedDiff] || 0) > 0);

    if (!qData || qData.length === 0) {
      setStatusMsg("問題が見つかりませんでした");
      setIsPreparing(false);
      return false;
    }

    const selectedQuizzes = [];
    const tempPool = [...qData];
    for (let i = 0; i < 10 && tempPool.length > 0; i++) {
      const totalWeight = tempPool.reduce((sum, q) => sum + (q[selectedDiff] || 0), 0);
      let random = Math.random() * totalWeight;
      for (let j = 0; j < tempPool.length; j++) {
        random -= tempPool[j][selectedDiff];
        if (random <= 0) {
          selectedQuizzes.push(tempPool[j]);
          tempPool.splice(j, 1);
          break;
        }
      }
    }
    localStorage.setItem('debug_selected_quizzes', JSON.stringify(
      selectedQuizzes.map((q, i) => ({
        no: i + 1,
        id: q.id,
        song_name: q.song_name,
        seq: q.seq,
        lyric: q.lyrics,
        easy: q.easy, normal: q.normal, hard: q.hard, expert: q.expert,
      }))
    ));
    const quizzesWithSurrounds = selectedQuizzes.map(addSurrounds);
    // 1問目の歌詞をアナウンス前に取得（announce時に即座に表示するため）
    const firstSoundsId = quizzesWithSurrounds[0]?.sounds_id;
    if (firstSoundsId) await fetchSongLyrics(firstSoundsId);
    setQuizState(prev => ({ ...prev, quizzes: quizzesWithSurrounds, currentIndex: 0, correctCount: 0 }));
    setMembers(mData || []);
    setIsPreparing(false);
    return true;
  };

  // --- エンドレスモード準備（全問メタデータ取得 + Q1先読み） ---
  const prepareEndlessMode = async (selectedGroup) => {
    setIsPreparing(true);
    setEndlessNextQ(null);
    setEndlessNextQLoading(false);
    setStatusMsg("問題を準備しています…");
    const membersPromise = supabase.from("members").select("*").eq("group_name", selectedGroup).order("sort_order");
    let qData = getGroupCache(selectedGroup);
    if (!qData) {
      qData = [];
      let from = 0;
      let hasMore = true;
      while (hasMore) {
        const { data } = await supabase.from("quiz_full_dev").select("*").eq("group_name", selectedGroup).in('sounds_id', activeSoundsIdsRef.current).range(from, from + 999);
        if (!data || data.length === 0) { hasMore = false; }
        else { qData = [...qData, ...data]; from += 1000; if (data.length < 1000) hasMore = false; }
      }
      if (qData.length > 0) setGroupCache(selectedGroup, qData);
    }
    const { data: mData } = await membersPromise;
    if (qData.length === 0) {
      setStatusMsg("問題が見つかりませんでした");
      setIsPreparing(false);
      return;
    }
    setMembers(mData || []);
    // Q1を選択してfullデータ取得
    if (qData.length > 999) qData = shuffle(qData).slice(0, 999);
    let pool = [...qData];
    const eligible1 = getEndlessEligiblePool(pool, 1);
    const q1Meta = selectEndlessWeighted(eligible1);
    pool = pool.filter(q => q.id !== q1Meta.id);
    const q1 = addSurrounds(q1Meta);
    // 状態を初期化
    endlessPoolRef.current = pool;
    endlessPendingNotifRef.current = null;
    setEndlessQNum(1);
    setEndlessLives(3);
    setEndlessConsecutive(0);
    setEndlessIsOver(false);
    setEndlessLifeBonus({ type: 'none', amount: 0, key: 0 });
    setEndlessDiffNotif({ text: '', key: 0 });
    setQuizState(prev => ({ ...prev, group: selectedGroup, quizzes: [q1], currentIndex: 0, correctCount: 0 }));
    setAnswered(false);
    setSelectedMembers(new Set());
    setResultMsg({ text: '', type: '' });
    setStatusMsg(`全${qData.length}問から出題します！`);
    setIsPreparing(false);
    // Q2を裏で先読み
    prefetchEndlessNext(pool, 2);
  };

  // --- 楽曲リスト取得（ループ取得 & 強力正規化） ---
  const fetchSongList = async () => {
    setIsLoadingList(true);
    setScreen('lyrics');
    try {
      // 起動直後に activeSoundsIdsRef がまだ未ロードの場合は先に取得する
      if (activeSoundsIdsRef.current.length === 0) {
        const { data } = await supabase.from('sounds').select('id').eq('is_active', true);
        if (data) activeSoundsIdsRef.current = data.map(s => s.id);
      }

      const groups = [
        { name: 'FRUITS ZIPPER' },
        { name: 'CANDY TUNE' },
        { name: 'SWEET STEADY' },
        { name: 'CUTIE STREET' },
        { name: 'MORE STAR' }
      ];

      let allQuizData = [];
      let from = 0;
      let hasMore = true;

      while (hasMore) {
        const { data, error } = await supabase
          .from('quiz_full_dev')
          .select('group_name, song_name')
          .in('sounds_id', activeSoundsIdsRef.current)
          .range(from, from + 999);

        if (error) throw error;
        if (!data || data.length === 0) {
          hasMore = false;
        } else {
          allQuizData = [...allQuizData, ...data];
          from += 1000;
          if (data.length < 1000) hasMore = false;
        }
      }

      const activeSongsSet = new Set();

      allQuizData.forEach(q => {
        if (q.song_name) activeSongsSet.add(superNormalize(q.song_name));
      });

      const finalData = [];
      for (const group of groups) {
        const { data: songs } = await supabase
          .from('sounds')
          .select('song_name')
          .eq('group_name', group.name)
          .eq('is_active', true)
          .order('song_name', { ascending: true });
        if (songs) {
          const processedSongs = songs.map(s => ({
            title: s.song_name,
            hasQuiz: activeSongsSet.has(superNormalize(s.song_name)),
          }));
          finalData.push({ groupName: group.name, songs: processedSongs });
        }
      }
      setSongListData(finalData);
    } catch (err) {
      console.error(err);
    } finally {
      setIsLoadingList(false);
    }
  };

  const normalizeMemberName = (name) => name.trim().replace(/[\s　]/g, '');

  const handleAnswer = () => {
    if (selectedMembers.size === 0) {
      setResultMsg({ text: "⚠️ メンバーを選択してください！", type: "warning" });
      return;
    }
    const current = quizState.quizzes[quizState.currentIndex];
    const correctArray = current.correct_members
      .split(/[,、]/)
      .map(normalizeMemberName)
      .filter(Boolean)
      .sort((a, b) => a.localeCompare(b, 'ja'));
    const selectedArray = Array.from(selectedMembers)
      .map(normalizeMemberName)
      .sort((a, b) => a.localeCompare(b, 'ja'));
    const isCorrect = JSON.stringify(correctArray) === JSON.stringify(selectedArray);

    const isAll = correctArray.length === members.length && members.length > 0;
    const correctLabel = formatCorrectLabel(correctArray, isAll ? '1' : '0');

    // --- 検定モード：タイマー停止 ---
    if (gameMode === 'normal') clearInterval(questionTimerIntervalRef.current);

    // --- エンドレスモード ---
    if (gameMode === 'endless') {
      setAnswered(true);
      if (isCorrect) {
        setQuizState(prev => ({ ...prev, correctCount: prev.correctCount + 1 }));
        const newConsec = endlessConsecutive + 1;
        setEndlessConsecutive(newConsec);
        if (newConsec % 5 === 0) {
          const bonus = newConsec / 5;
          endlessPendingNotifRef.current = { type: 'bonus', amount: bonus, lifeDelta: bonus };
        }
        setResultMsg({ text: `<span style="font-size:1.15em">⭕ 正解！😄</span><br><span style="font-size:0.8em">( 正解：${correctLabel} )</span>`, type: "correct" });
      } else {
        setEndlessConsecutive(0);
        if (endlessLives === 0) {
          setEndlessIsOver(true);
        } else {
          endlessPendingNotifRef.current = { type: 'penalty', amount: 1, lifeDelta: -1 };
        }
        setResultMsg({ text: `<span style="font-size:1.15em">❌ 不正解！💔</span><br><span style="font-size:0.8em">( 正解：${correctLabel} )</span>`, type: "incorrect" });
      }
      setTimeout(() => window.scrollTo({ top: document.body.scrollHeight, behavior: "smooth" }), 100);
      return;
    }

    // --- カスタムモード ---
    if (gameMode === 'custom') {
      const currentMembers = customMembersByGroup[current.group_name] || [];
      const isAllCustom = correctArray.length === currentMembers.length && currentMembers.length > 0;
      const correctLabelCustom = formatCorrectLabel(correctArray, isAllCustom ? '1' : '0');
      if (isCorrect) {
        setQuizState(prev => ({ ...prev, correctCount: prev.correctCount + 1 }));
        setResultMsg({ text: `<span style="font-size:1.15em">⭕ 正解！😄</span><br><span style="font-size:0.8em">( 正解：${correctLabelCustom} )</span>`, type: "correct" });
      } else {
        setCustomWrongAnswers(prev => [...prev, { lyrics: current.lyrics, song_name: current.song_name, correct_members: current.correct_members, group_name: current.group_name, occurrence: current.occurrence }]);
        setResultMsg({ text: `<span style="font-size:1.15em">❌ 不正解！😫</span><br><span style="font-size:0.8em">( 正解：${correctLabelCustom} )</span>`, type: "incorrect" });
      }
      setAnswered(true);
      setTimeout(() => window.scrollTo({ top: document.body.scrollHeight, behavior: "smooth" }), 100);
      return;
    }

    // --- 通常モード ---
    if (isCorrect) {
      setQuizState(prev => ({ ...prev, correctCount: prev.correctCount + 1 }));
      setResultMsg({ text: `<span style="font-size:1.15em">⭕ 正解！😄</span><br><span style="font-size:0.8em">( 正解：${correctLabel} )</span>`, type: "correct" });
    } else {
      setResultMsg({ text: `<span style="font-size:1.15em">❌ 不正解！😫</span><br><span style="font-size:0.8em">( 正解：${correctLabel} )</span>`, type: "incorrect" });
    }
    setAnswered(true);
    setTimeout(() => window.scrollTo({ top: document.body.scrollHeight, behavior: "smooth" }), 100);
  };

  const nextQuestion = async () => {
    if (gameMode === 'endless') { advanceEndlessQuestion(); return; }
    if (gameMode === 'custom') {
      setNextQLoading(true);
      try { await nextCustomQuestion(); } finally { setNextQLoading(false); }
      return;
    }
    // 検定モード
    setNextQLoading(true);
    try {
      const nextIndex = quizState.currentIndex + 1;
      if (nextIndex >= quizState.quizzes.length) {
        setScreen('result');
        return;
      }
      // 先に歌詞を取得してからannounceへ（モーダル表示時に歌詞が確実に表示される）
      const nextQuiz = quizState.quizzes[nextIndex];
      if (nextQuiz?.sounds_id) await fetchSongLyrics(nextQuiz.sounds_id);
      setQuestionTimer(60);
      setQuizState(prev => ({ ...prev, currentIndex: nextIndex }));
      setSelectedMembers(new Set());
      setAnswered(false);
      setResultMsg({ text: "", type: "" });
      setShowFullLyrics(false);
      setScrollAnimPhase('scrolling');
      setQuizPhase('announce');
      window.scrollTo({ top: 0, behavior: "smooth" });
    } finally {
      setNextQLoading(false);
    }
  };

  const advanceEndlessQuestion = async () => {
    // プール枯渇 → セッション削除してリザルトへ
    if (!endlessNextQ && !endlessNextQLoading) {
      if (sessionId) {
        supabase.from('sessions').delete().eq('session_id', sessionId).then(() => {});
        localStorage.removeItem('quiz_session_id');
        setSessionId(null);
      }
      setScreen('result');
      return;
    }
    if (!endlessNextQ) return; // まだ先読み中（ボタンはdisabledのため通常ここには来ない）
    // 予約済みの通知とライフ増減を次の問題画面で適用
    const pending = endlessPendingNotifRef.current;
    endlessPendingNotifRef.current = null;
    const newLives = (pending?.lifeDelta) ? endlessLives + pending.lifeDelta : endlessLives;
    if (pending) {
      setEndlessLives(newLives);
      setEndlessLifeBonus({ type: pending.type, amount: pending.amount, key: Date.now() });
    } else {
      setEndlessLifeBonus({ type: 'none', amount: 0, key: 0 });
    }
    const newQNum = endlessQNum + 1;
    setEndlessQNum(newQNum);
    const nextQ = endlessNextQ;
    if (nextQ?.sounds_id) await fetchSongLyrics(nextQ.sounds_id);
    setQuizState(prev => ({ ...prev, quizzes: [nextQ], currentIndex: 0 }));
    setEndlessNextQ(null);
    setAnswered(false);
    setSelectedMembers(new Set());
    setResultMsg({ text: "", type: "" });
    setScrollAnimPhase('scrolling');
    setQuizPhase('announce');
    window.scrollTo({ top: 0, behavior: "smooth" });
    // セッション更新（次の問題・残プール・ライフ等を保存）
    if (sessionId) {
      supabase.from('sessions').update({
        current_step: newQNum,
        correct_count: quizState.correctCount,
        quiz_ids: {
          current: nextQ.id,
          pool: endlessPoolRef.current.map(q => q.id),
          lives: newLives,
          consecutive: endlessConsecutive
        }
      }).eq('session_id', sessionId).then(() => {});
    }
    // 次の次を先読み
    prefetchEndlessNext(endlessPoolRef.current, newQNum + 1);
  };

  // --- 検定モード：問題タイマー（60秒・問題が変わるたびリセット） ---
  // Date.now() ベースで計算することで、バックグラウンド時の throttle に対応
  useEffect(() => {
    if (screen !== 'quiz' || gameMode !== 'normal' || quizPhase !== 'question') return;
    setQuestionTimer(60);
    timerStartRef.current = Date.now();
    const id = setInterval(() => {
      const elapsed = Math.floor((Date.now() - timerStartRef.current) / 1000);
      const remaining = Math.max(0, 60 - elapsed);
      setQuestionTimer(remaining);
      if (remaining <= 0) clearInterval(id);
    }, 500);
    questionTimerIntervalRef.current = id;
    return () => clearInterval(id);
  }, [quizState.currentIndex, screen, gameMode, quizPhase]);

  // --- タブ復帰時にタイマーを即時補正 ---
  useEffect(() => {
    if (screen !== 'quiz' || gameMode !== 'normal' || quizPhase !== 'question' || answered) return;
    const handleVisibilityChange = () => {
      if (!document.hidden && timerStartRef.current) {
        const elapsed = Math.floor((Date.now() - timerStartRef.current) / 1000);
        const remaining = Math.max(0, 60 - elapsed);
        setQuestionTimer(remaining);
        if (remaining <= 0) clearInterval(questionTimerIntervalRef.current);
      }
    };
    document.addEventListener('visibilitychange', handleVisibilityChange);
    return () => document.removeEventListener('visibilitychange', handleVisibilityChange);
  }, [screen, gameMode, answered, quizPhase]);

  // --- 検定モード：タイムアップ → 強制不正解 ---
  useEffect(() => {
    if (gameMode !== 'normal' || screen !== 'quiz' || quizPhase !== 'question' || answered) return;
    if (questionTimer === 0) {
      clearInterval(questionTimerIntervalRef.current);
      const curr = quizState.quizzes[quizState.currentIndex];
      const correctArr = (curr?.correct_members || '').split(',').map(normalizeMemberName).filter(Boolean);
      const isAll = correctArr.length === members.length && members.length > 0;
      const correctLabel = formatCorrectLabel(correctArr, isAll ? '1' : '0');
      setResultMsg({
        text: `<span style="font-size:1.15em">⏱️ 時間切れ！😢</span><br><span style="font-size:0.8em">( 正解：${correctLabel} )</span>`,
        type: "incorrect"
      });
      setAnswered(true);
      setTimeout(() => window.scrollTo({ top: document.body.scrollHeight, behavior: "smooth" }), 100);
    }
  }, [questionTimer, gameMode, screen, answered, members]);

  // --- アナウンス画面：2秒後にスクロール画面へ ---
  useEffect(() => {
    if (quizPhase !== 'announce') return;
    const t = setTimeout(() => setQuizPhase('scrolling'), 2000);
    return () => clearTimeout(t);
  }, [quizPhase, quizState.currentIndex, gameMode]);

  // --- 検定モード：全歌詞スクロールアニメーション (rAF) ---
  useEffect(() => {
    if (quizPhase !== 'scrolling') return;
    setScrollAnimPhase('scrolling');
    if (!fullSongLyrics.length || isLoadingLyrics) return;

    let rafId;

    // 0.5秒待ってからスクロール開始
    const delayTimer = setTimeout(() => {
      rafId = requestAnimationFrame(() => {
        const body = lyricBodyRef.current;
        if (!body) { setQuizPhase('question'); return; }

        body.scrollTop = 0;

        const TOTAL_DURATION = 2500;
        const endScroll = body.scrollHeight - body.clientHeight;

        let startTime = null;

        const animate = (ts) => {
          if (!startTime) startTime = ts;
          const t = Math.min((ts - startTime) / TOTAL_DURATION, 1);
          // cubic ease-in-out（ゆっくり開始・速く中盤・ゆっくり終了）
          const ease = t < 0.5 ? 4 * t * t * t : 1 - Math.pow(-2 * t + 2, 3) / 2;
          body.scrollTop = endScroll * ease;

          if (t < 1) {
            rafId = requestAnimationFrame(animate);
          } else {
            body.scrollTop = endScroll;
            // 3秒スクロール後、対象歌詞を中央に再スクロール
            const targetEl = questionLyricScrollRef.current;
            if (targetEl) {
              const bodyRect = body.getBoundingClientRect();
              const elRect = targetEl.getBoundingClientRect();
              const deltaToCenter = (elRect.top + elRect.height / 2) - (bodyRect.top + bodyRect.height / 2);
              const targetScrollTop = Math.max(0, Math.min(
                body.scrollTop + deltaToCenter,
                body.scrollHeight - body.clientHeight
              ));
              body.scrollTo({ top: targetScrollTop, behavior: 'smooth' });
            }
            setTimeout(() => {
              setScrollAnimPhase('zooming');
              setTimeout(() => setQuizPhase('question'), 2600);
            }, 700);
          }
        };

        rafId = requestAnimationFrame(animate);
      });
    }, 500);

    return () => {
      clearTimeout(delayTimer);
      if (rafId) cancelAnimationFrame(rafId);
    };
  }, [quizPhase, isLoadingLyrics, fullSongLyrics]);

  // --- 検定モード：全歌詞オーバーレイ表示時に問題箇所へスクロール ---
  useEffect(() => {
    if (!showFullLyrics) { setFullLyricsBlink(false); return; }
    const t = setTimeout(() => {
      fullLyricsHighlightRef.current?.scrollIntoView({ behavior: 'smooth', block: 'center' });
      setFullLyricsBlink(true);
    }, 150);
    const blinkOffT = setTimeout(() => setFullLyricsBlink(false), 150 + 1500);
    return () => { clearTimeout(t); clearTimeout(blinkOffT); setFullLyricsBlink(false); };
  }, [showFullLyrics]);

  useEffect(() => {
    if (screen === 'result') {
      if (gameMode === 'endless') {
        setDisplayScore(0);
        setResultPhase('announce');
        const target = quizState.correctCount;
        const announceTimer = setTimeout(() => {
          setResultPhase('drumroll');
          if (target > 0) {
            const totalMs = 2800;
            const raw = Array.from({ length: target + 1 }, (_, i) => {
              const t = i / target;
              const speed = Math.sin(t * Math.PI);
              return 1 / Math.max(speed, 0.25);
            });
            const sum = raw.reduce((s, d) => s + d, 0);
            let elapsed = 0;
            for (let i = 0; i <= target; i++) {
              const delay = elapsed;
              const val = i;
              setTimeout(() => setDisplayScore(val), delay);
              elapsed += (raw[i] / sum) * totalMs;
            }
            setTimeout(() => { setResultPhase('reveal'); }, elapsed + 300);
          } else {
            setTimeout(() => { setResultPhase('reveal'); }, 600);
          }
        }, 1000);
        return () => clearTimeout(announceTimer);
      }
      if (gameMode === 'custom') {
        if (customResultReadyRef.current) {
          setResultPhase('reveal');
          return;
        }
        customResultReadyRef.current = true;
        setDisplayScore(0);
        setResultPhase('announce');
        const target = quizState.correctCount;
        const announceTimer = setTimeout(() => {
          setResultPhase('drumroll');
          if (target > 0) {
            const totalMs = 2800;
            const raw = Array.from({ length: target + 1 }, (_, i) => {
              const t = i / target;
              const speed = Math.sin(t * Math.PI);
              return 1 / Math.max(speed, 0.25);
            });
            const sum = raw.reduce((s, d) => s + d, 0);
            let elapsed = 0;
            for (let i = 0; i <= target; i++) {
              const delay = elapsed;
              const val = i;
              setTimeout(() => setDisplayScore(val), delay);
              elapsed += (raw[i] / sum) * totalMs;
            }
            setTimeout(() => { setResultPhase('reveal'); }, elapsed + 300);
          } else {
            setTimeout(() => { setResultPhase('reveal'); }, 600);
          }
        }, 1000);
        return () => clearTimeout(announceTimer);
      }
      setDisplayScore(0);
      setResultPhase('announce');
      const target = quizState.correctCount;

      const fireConfetti = () => {
        if (target !== 10) return;
        if (quizState.difficulty === 'expert') {
          const colors = ['#ff69b2', '#ffb6c1', '#ffbe0b', '#4ecdc4', '#ffffff', '#ff006e', '#8338ec'];
          confetti({ particleCount: 350, spread: 120, startVelocity: 65, origin: { x: 0.5, y: 0.55 }, colors, shapes: ['star', 'circle', 'square'], scalar: 1.3 });
          setTimeout(() => {
            confetti({ particleCount: 250, angle: 60, spread: 60, startVelocity: 70, origin: { x: 0, y: 0.6 }, colors });
            confetti({ particleCount: 250, angle: 120, spread: 60, startVelocity: 70, origin: { x: 1, y: 0.6 }, colors });
          }, 350);
          let rain = 0;
          const rainTimer = setInterval(() => {
            confetti({ particleCount: 60, angle: 70, spread: 50, origin: { x: 0, y: 0.2 }, colors, gravity: 0.8 });
            confetti({ particleCount: 60, angle: 110, spread: 50, origin: { x: 1, y: 0.2 }, colors, gravity: 0.8 });
            if (++rain >= 10) clearInterval(rainTimer);
          }, 350);
          const spots = [[0.2, 0.3], [0.8, 0.3], [0.5, 0.4], [0.15, 0.6], [0.85, 0.6], [0.5, 0.7]];
          spots.forEach(([x, y], i) => {
            setTimeout(() => {
              confetti({ particleCount: 120, spread: 360, startVelocity: 35, decay: 0.88, gravity: 0.6, origin: { x, y }, colors, shapes: ['star'] });
            }, 1800 + i * 220);
          });
        } else {
          confetti({ particleCount: 150, spread: 70, origin: { y: 0.6 }, colors: ['#ff69b2', '#ffb6c1', '#ffffff', '#4ecdc4'] });
        }
      };

      const announceTimer = setTimeout(() => {
        setResultPhase('drumroll');
        if (!localStorage.getItem('kawaii_custom_unlocked')) {
          const count = parseInt(localStorage.getItem('kawaii_normal_play_count') || '0') + 1;
          localStorage.setItem('kawaii_normal_play_count', String(count));
          if (count >= 5) {
            localStorage.setItem('kawaii_custom_unlocked', 'true');
            localStorage.setItem('kawaii_custom_new_unlock', 'true');
            setCustomUnlocked(true);
          }
        }
        if (target > 0) {
          const totalMs = 2000;
          const raw = Array.from({ length: target + 1 }, (_, i) => {
            const t = i / target;
            const speed = t < 0.5 ? 4 * t : 4 * (1 - t);
            return 1 / Math.max(speed, 0.15);
          });
          const sum = raw.reduce((s, d) => s + d, 0);
          let elapsed = 0;
          for (let i = 0; i <= target; i++) {
            const delay = elapsed;
            const val = i;
            setTimeout(() => setDisplayScore(val), delay);
            elapsed += (raw[i] / sum) * totalMs;
          }
          setTimeout(() => {
            setResultPhase('reveal');
            fireConfetti();
            if (target === 10 && (quizState.difficulty === 'hard' || quizState.difficulty === 'expert')) {
              setEndlessUnlockedGroups(prev => {
                if (prev.has(quizState.group)) return prev;
                const next = new Set(prev);
                next.add(quizState.group);
                localStorage.setItem('kawaii_endless_unlocked_groups', JSON.stringify([...next]));
                const pending = JSON.parse(localStorage.getItem('kawaii_endless_pending_unlocks') || '[]');
                const wasEmpty = pending.length === 0;
                if (!pending.includes(quizState.group)) {
                  pending.push(quizState.group);
                  localStorage.setItem('kawaii_endless_pending_unlocks', JSON.stringify(pending));
                }
                if (prev.size === 0 && wasEmpty) {
                  localStorage.setItem('kawaii_endless_first_unlock', 'true');
                }
                return next;
              });
            }
          }, elapsed + 300);
        } else {
          setTimeout(() => { setResultPhase('reveal'); }, 600);
        }
      }, 1000);

      return () => clearTimeout(announceTimer);
    }
    if (screen === 'quiz') {
      setResultPhase('idle');
      setResultMsg({ text: "", type: "" });
      setAnswered(false);
    }
    if (screen === 'mode') {
      const GROUP_ORDER = ['FRUITS ZIPPER','CANDY TUNE','SWEET STEADY','CUTIE STREET','MORE STAR'];
      const queue = [];

      if (localStorage.getItem('kawaii_custom_new_unlock')) {
        localStorage.removeItem('kawaii_custom_new_unlock');
        queue.push({ type: 'custom' });
      }

      const pendingEndless = JSON.parse(localStorage.getItem('kawaii_endless_pending_unlocks') || '[]');
      if (pendingEndless.length > 0) {
        localStorage.removeItem('kawaii_endless_pending_unlocks');
        const isFirst = !!localStorage.getItem('kawaii_endless_first_unlock');
        if (isFirst) localStorage.removeItem('kawaii_endless_first_unlock');
        const sorted = [...pendingEndless].sort((a, b) => GROUP_ORDER.indexOf(a) - GROUP_ORDER.indexOf(b));
        sorted.forEach((group, i) => {
          queue.push({ type: 'endless', group, isFirst: isFirst && i === 0 });
        });
      }

      if (queue.length > 0) {
        if (queue.some(q => q.type === 'custom')) setPendingCustomReveal(true);
        if (queue.some(q => q.type === 'endless' && q.isFirst)) setPendingEndlessReveal(true);
        setIsUnlockAnimating(true);

        const processQueue = (q) => {
          if (q.length === 0) { setIsUnlockAnimating(false); return; }
          const [current, ...rest] = q;
          if (current.type === 'custom') {
            setCustomNewUnlockNotif(true);
            setTimeout(() => {
              setCustomNewUnlockNotif(false);
              setPendingCustomReveal(false);
              setNewlyUnlockedMode('custom');
              setTimeout(() => { setNewlyUnlockedMode(null); processQueue(rest); }, 1000);
            }, 3000);
          } else {
            setEndlessNewUnlockNotif(current.group);
            setTimeout(() => {
              setEndlessNewUnlockNotif('');
              if (current.isFirst) {
                setPendingEndlessReveal(false);
                setNewlyUnlockedMode('endless');
                setTimeout(() => { setNewlyUnlockedMode(null); processQueue(rest); }, 1000);
              } else {
                processQueue(rest);
              }
            }, 3000);
          }
        };
        processQueue(queue);
      }
    }
  }, [screen]);

  useEffect(() => {
    const NO_SCROLL_SCREENS = ['top', 'lyrics', 'mode', 'group', 'difficulty', 'confirm', 'custom-select-group', 'custom-select-song', 'result'];
    const html = document.documentElement;
    if (NO_SCROLL_SCREENS.includes(screen)) {
      html.classList.add('no-scroll');
    } else {
      html.classList.remove('no-scroll');
    }
    clearTimeout(tooltipHoverTimerRef.current);
    clearTimeout(tooltipCloseTimerRef.current);
    setTooltipLevel(null);
    setTooltipClosing(false);
    setTimerLevel(null);
    return () => html.classList.remove('no-scroll');
  }, [screen]);

  useLayoutEffect(() => {
    if (screen !== 'top') return;
    const fitEl = (el, startRem, minPx) => {
      if (!el) return;
      el.style.fontSize = startRem + 'rem';
      const cs = window.getComputedStyle(el);
      const rect = el.getBoundingClientRect();
      const availWidth = rect.width - parseFloat(cs.paddingLeft) - parseFloat(cs.paddingRight);
      if (availWidth <= 0) return;
      const ruler = document.createElement('span');
      ruler.style.cssText = 'position:absolute;top:-9999px;left:0;visibility:hidden;white-space:nowrap;pointer-events:none;';
      ruler.style.fontFamily = cs.fontFamily;
      ruler.style.fontSize = cs.fontSize;
      ruler.style.fontWeight = cs.fontWeight;
      ruler.textContent = el.textContent.trim();
      document.body.appendChild(ruler);
      const textWidth = ruler.getBoundingClientRect().width;
      document.body.removeChild(ruler);
      if (textWidth > availWidth) {
        const newSize = Math.max(parseFloat(cs.fontSize) * (availWidth / textWidth) * 0.95, minPx);
        el.style.fontSize = `${newSize}px`;
      }
    };
    const fitAll = () => {
      fitEl(descTextRef.current, 0.88, 8);
      fitEl(catchText1Ref.current, 0.88, 8);
      fitEl(catchText2Ref.current, 0.88, 8);
      fitEl(listBtnRef.current, 0.82, 8);

    };
    fitAll();
    document.fonts.ready.then(fitAll);
  }, [screen]);

  useLayoutEffect(() => {
    const fitText = (el, startRem, minPx) => {
      if (!el) return;
      el.style.fontSize = startRem + 'rem';
      let size = parseFloat(window.getComputedStyle(el).fontSize);
      while (el.scrollWidth > el.clientWidth && size > minPx) {
        size -= 0.5;
        el.style.fontSize = `${size}px`;
        if (size <= minPx) break;
      }
    };
    const fitAll = () => {
      fitText(lyricsRef.current, 1.4, 10);
      if (lyricsRef.current && window.innerWidth <= 540) {
        const cur = parseFloat(window.getComputedStyle(lyricsRef.current).fontSize);
        if (cur > 16) lyricsRef.current.style.fontSize = '16px';
      }
    };
    fitAll();
    document.fonts.ready.then(fitAll);
  }, [screen, quizPhase, quizState.currentIndex, quizState.quizzes]);

  // ツールチップのテキストがはみ出る場合にフォントを縮小
  useLayoutEffect(() => {
    const el = diffTooltipRef.current;
    if (!el) return;
    el.style.fontSize = '';
    const minPx = 9;
    let size = parseFloat(window.getComputedStyle(el).fontSize);
    const items = el.querySelectorAll('.diff-tooltip-item');
    while (size > minPx && Array.from(items).some(item => item.scrollWidth > item.clientWidth)) {
      size -= 0.5;
      el.style.fontSize = `${size}px`;
    }
  }, [tooltipLevel]);

  useEffect(() => {
    if (!songModalData.length) return;
    requestAnimationFrame(() => {
      document.querySelectorAll('.song-modal-lyrics').forEach(el => {
        const base = 0.75;
        el.style.fontSize = base + 'rem';
        if (el.clientWidth > 0 && el.scrollWidth > el.clientWidth) {
          const ratio = el.clientWidth / el.scrollWidth;
          el.style.fontSize = Math.max(base * ratio * 0.93, 0.4) + 'rem';
        }
      });
    });
  }, [songModalData]);

  useEffect(() => {
    if (!songListData.length) return;
    document.fonts.ready.then(() => requestAnimationFrame(() => {
      document.querySelectorAll('.song-title-cell').forEach(el => {
        el.style.fontSize = '';
        let currentSize = parseFloat(window.getComputedStyle(el).fontSize);
        const minSize = 8;
        while (el.scrollWidth > el.clientWidth && currentSize > minSize) {
          currentSize -= 0.5;
          el.style.fontSize = `${currentSize}px`;
          if (currentSize <= minSize) break;
        }
      });
    }));
  }, [songListData]);

  useEffect(() => {
    if (!resultMsg.text) return;
    requestAnimationFrame(() => {
      const el = document.getElementById('result');
      if (!el) return;
      el.style.fontSize = '';
      let size = parseFloat(window.getComputedStyle(el).fontSize);
      const minSize = 9;
      while (el.scrollWidth > el.clientWidth && size > minSize) {
        size -= 0.5;
        el.style.fontSize = `${size}px`;
        if (size <= minSize) break;
      }
    });
  }, [resultMsg]);

  useEffect(() => {
    if (!answered) return;
    requestAnimationFrame(() => {
      const el = document.getElementById('explanation');
      if (!el) return;
      el.style.fontSize = '';
      let size = parseFloat(window.getComputedStyle(el).fontSize);
      const minSize = 9;
      while (el.scrollWidth > el.clientWidth && size > minSize) {
        size -= 0.5;
        el.style.fontSize = `${size}px`;
        if (size <= minSize) break;
      }
    });
  }, [answered]);

  useLayoutEffect(() => {
    if (screen !== 'result' || resultPhase !== 'reveal') return;
    const el = rankRef.current;
    if (!el) return;
    el.style.fontSize = '1.8rem';
    if (el.scrollWidth > el.clientWidth) {
      const ratio = el.clientWidth / el.scrollWidth;
      el.style.fontSize = Math.max(1.8 * ratio * 0.95, 0.9) + 'rem';
    }
  }, [screen, resultPhase, quizState.correctCount]);

  useLayoutEffect(() => {
    if (screen !== 'result') return;
    const el = commentRef.current;
    if (!el) return;
    el.style.fontSize = '1.1rem';
    if (el.scrollWidth > el.clientWidth) {
      const ratio = el.clientWidth / el.scrollWidth;
      el.style.fontSize = Math.max(1.1 * ratio * 0.95, 0.6) + 'rem';
    }
  }, [screen, resultPhase, quizState.correctCount, quizState.difficulty]);

  const getRank = (score) => {
    if (score === 10) return "🌟神推し級🌟";
    if (score >= 7) return "🥇物知り級";
    if (score >= 4) return "🥈ファン級";
    if (score >= 1) return "🥉ビギナー級";
    return "💩オワコン級";
  };

  const getRankTier = (score) => {
    if (score === 10) return 'perfect';
    if (score >= 7) return 'high';
    if (score >= 4) return 'mid';
    if (score >= 1) return 'low';
    return 'zero';
  };

  const shareEndlessOnX = () => {
    const text = encodeURIComponent(`エンドレスモードの結果！\n【${endlessQNum}問中${quizState.correctCount}問正解】\n${quizState.group}\n#KAWAIILAB歌割り検定\nhttps://kawalab-utaken.jp/`);
    window.open(`https://twitter.com/intent/tweet?text=${text}`, '_blank');
  };

  const shareOnX = () => {
    const rank = getRank(quizState.correctCount);
    const text = encodeURIComponent(`歌割り検定の結果は…\n【${rank}】でした！(正解：${quizState.correctCount}/10問)\n難易度：${difficultyLabel[quizState.difficulty]}\n#KAWAIILAB歌割り検定\nhttps://kawalab-utaken.jp/`);
    window.open(`https://twitter.com/intent/tweet?text=${text}`, '_blank');
  };

  const isSingleSelectMode =
    (gameMode === 'normal' && (quizState.difficulty === 'easy' || quizState.difficulty === 'normal'));

  const toggleMember = (name) => {
    if (answered) return;
    if (selectedMembers.size === displayMembers.length && displayMembers.length > 0) {
      setSelectedMembers(new Set([name]));
      return;
    }
    if (isSingleSelectMode) {
      setSelectedMembers(selectedMembers.has(name) ? new Set() : new Set([name]));
    } else {
      const newSet = new Set(selectedMembers);
      newSet.has(name) ? newSet.delete(name) : newSet.add(name);
      setSelectedMembers(newSet);
    }
  };

  const quizCurr = quizState.quizzes[quizState.currentIndex];
  const quizExplanation = (quizCurr?.song_name && quizCurr?.section_name)
    ? `この歌詞は「${quizCurr.song_name}」の\n${quizCurr.section_name}部分でした！` : "";
  const displayMembers = gameMode === 'custom'
    ? (customMembersByGroup[quizCurr?.group_name] || [])
    : members;

  if (!termsAgreed) {
    return (
      <div className="app-root">
        <div className="box terms-box fade-in">
          <img src={logo} alt="KAWAII LAB検定" className="site-logo" style={{marginBottom: '12px'}} />
          <p className="terms-title">注意事項<br />
            是非お読みください</p>
          <div className="terms-scroll">
            <p><strong>本サイトについて</strong><br />
            本サイトは、KAWAII LAB所属グループに関する非公式のファンサイトです。</p>
            <p><strong>歌詞と歌割りについて</strong><br />
            掲載している歌詞と歌割りは、KAWAII LAB公式から正式に歌詞・歌割りが発表されている曲を除き、運営者が独自調査したものです。事実と異なる可能性は往々にしてございますので、ご了承ください。</p>
            <p><strong>個人制作について</strong><br />
            本サイトは、ITエンジニアではない個人が趣味の範囲で制作・運営しています。内容の正確性については最善を尽くしていますが、すべてが正しいとは限りません。また、動作が不安定になったり、予期しない不具合が発生する場合もあります。「なんか変」と思う箇所があっても、温かい目で見ていただけると幸いです。不具合や誤りを発見した場合は、<a href="https://docs.google.com/forms/d/e/1FAIpQLSe6iTD1ky8LKFzE5_G_aAe2NwLo7OegGcRTm5mwVp3i6lZJ8Q/viewform" target="_blank" rel="noreferrer" style={{color:'#ff69b2'}}>アンケートフォーム</a>からご連絡いただけると大変助かります。</p>
            <p><strong>ブラウザのデータについて</strong><br />
            本サイトでは、プレイ履歴や解放状況などをブラウザのローカルストレージに保存しています。ブラウザを変更したり、キャッシュ・サイトデータをクリアすると、これらのデータがリセットされますのでご注意ください。</p>
          </div>
          <p className="terms-note">上記の注意事項に同意の上、お楽しみください。</p>
          <button className="terms-agree-btn" onClick={handleTermsAgree}>同意して始める</button>
        </div>
      </div>
    );
  }

  return (
    <div className="app-root">
      <div className="global-footer-link">
        {screen !== 'top' && screen !== 'result' && screen !== 'custom-review' && (
          <span onClick={async () => {
            if (gameMode === 'normal' && screen === 'quiz') {
              setShowBackConfirm(true);
              return;
            }
            clearInterval(questionTimerIntervalRef.current);
            // エンドレスモードはセッションが既に保存済み → 再フェッチしてpendingResumeに反映
            if (gameMode === 'endless' && sessionId) {
              const { data } = await supabase.from('sessions').select('*').eq('session_id', sessionId).maybeSingle();
              if (data) setPendingResume(data);
            }
            setScreen('top');
          }}>🏠 トップにもどる</span>
        )}
        {(screen === 'top' || screen === 'custom-review' || (screen === 'result' && resultPhase === 'reveal')) && (
          <a href="https://forms.gle/EguRX6uWZYmJJLZx5" target="_blank" rel="noreferrer" className="survey-corner-link">アンケートにご協力ください</a>
        )}
      </div>
      {!(screen === 'result' && resultPhase !== 'reveal') && (
        <div className="legal-links">
          <span onClick={() => setShowPolicy(true)}>プライバシーポリシー</span>
          <span onClick={() => setShowProfile(true)}>運営者情報</span>
        </div>
      )}

      {/* --- トップ画面 --- */}
      {screen === 'top' && (
        <div className="box top-card fade-in">
          <div className="logo-area">
            <img src={logo} alt="KAWAII LAB検定" className="site-logo bounce" />
            <h1 className="title-sub">
              <span>こ</span><span>の</span><span>歌</span><span>詞</span><br />
              <span>だ</span><span>れ</span><span>が</span><span>う</span><span>た</span><span>っ</span><span>て</span><span>る</span><span>？</span><span>？</span>
            </h1>
          </div>
          <p ref={descTextRef} className="desc-text">歌詞の一部を見て、誰のパートか当てるクイズです。</p>
          <p ref={catchText1Ref} className="catch-text">✨正解数で理解度を測定！✨</p>
          <p ref={catchText2Ref} className="catch-text">✨たくさん正解して推しへの愛を証明しよう！✨</p>

          <div className="top-buttons">
            <button className="start-btn-sparkle" onClick={() => setScreen('mode')}>
              <span className="btn-inner">検定開始！</span>
            </button>
            <button className="start-btn-list" onClick={() => {
              if (pendingResume) { setResumeModalSource('songlist'); setShowResumeModal(true); }
              else fetchSongList();
            }}>
              <span className="btn-inner">♫楽曲リスト♫</span>
            </button>
          </div>
        </div>
      )}

      {/* --- 楽曲リスト画面 --- */}
      {screen === 'lyrics' && (
        <div className="box list-card zoom-in">
          <h2 className="title">出題楽曲リスト</h2>
          {isLoadingList ? (
            <div className="status-text loading-bounce">データを取得中...</div>
          ) : (
            <div className="list-container">
              {songListData.map((group, idx) => (
                <div key={idx} className="group-section">
                  <div className="group-name-title">{group.groupName}</div>
                  {group.songs.map((song, sIdx) => (
                    <div key={sIdx}
                      className={`song-item-row ${!song.hasQuiz ? 'song-unreleased' : 'song-clickable'}`}
                      onClick={() => song.hasQuiz && openSongModal(song.title, group.groupName)}
                    >
                      <div className="song-title-cell">♪ {song.title}</div>
                      <div className="badge-area">
                        {!song.hasQuiz && <span className="status-tag-unreleased">準備中</span>}
                      </div>
                    </div>
                  ))}
                </div>
              ))}
            </div>
          )}
          <button className="list-back-btn" onClick={() => setScreen('top')}>戻る</button>
        </div>
      )}

      {/* --- モード選択 --- */}
      {screen === 'mode' && (
        <div className="box mode-card zoom-in">
          <h2 className="title">モードを選んでね！</h2>
          <button className="mode-btn mode-btn-normal" onClick={() => {
            setGameMode('normal');
            setScreen('group');
          }}>
            <span className="mode-btn-icon">📝</span>
            <span className="mode-btn-name">検定モード</span>
            <span className="mode-btn-desc">1問60秒！めざせ10点満点！</span>
          </button>
          {(!pendingCustomReveal && !debugForceHideCustom && (debugMode || customUnlocked)) && (
            <div className={`mode-btn-unlock-wrapper${newlyUnlockedMode === 'custom' ? ' mode-btn-reveal-anim' : ''}`}>
              <button className={`mode-btn mode-btn-custom${newlyUnlockedMode === 'custom' ? ' mode-btn--new' : ''}`} onClick={() => { setGameMode('custom'); setScreen('custom-select-group'); }}>
                <span className="mode-btn-icon">🎵</span>
                <span className="mode-btn-name">カスタムモード</span>
                <span className="mode-btn-desc">好きな曲を選んで練習！</span>
              </button>
            </div>
          )}
          {(!pendingEndlessReveal && !debugForceHideEndless && (debugMode || endlessUnlockedGroups.size > 0)) && (
            <div className={`mode-btn-unlock-wrapper${newlyUnlockedMode === 'endless' ? ' mode-btn-reveal-anim' : ''}`}>
              <button className={`mode-btn mode-btn-endless${newlyUnlockedMode === 'endless' ? ' mode-btn--new' : ''}`} onClick={() => {
                setGameMode('endless');
                if (pendingResume) { setShowResumeModal(true); }
                else { setScreen('group'); }
              }}>
                <span className="mode-btn-icon">🏃‍♀️🏃‍♂️🏃</span>
                <span className="mode-btn-name">エンドレスモード</span>
                <span className="mode-btn-desc">問題が尽きるまで挑戦！</span>
              </button>
            </div>
          )}
          <button className="back-btn-group back-btn-top" onClick={() => setScreen('top')}>トップに戻る</button>
        </div>
      )}

      {/* --- カスタム：グループ選択 --- */}
      {screen === 'custom-select-group' && (
        <div className="box custom-select-card zoom-in">
          <h2 className="title">グループを選択しましょう！</h2>
          <p className="custom-select-hint">1つ以上選択してください</p>
          <div className="group-grid">
            {[
              { name: 'FRUITS ZIPPER', label: '🍎FRUITS ZIPPER🍎', cls: 'fz' },
              { name: 'CANDY TUNE',    label: '🍬CANDY TUNE🍬',    cls: 'cd' },
              { name: 'SWEET STEADY',  label: '💐SWEET STEADY💐',  cls: 'ss' },
              { name: 'CUTIE STREET',  label: '💎CUTIE STREET💎',  cls: 'cs' },
              { name: 'MORE STAR',     label: '🌟MORE STAR🌟',     cls: 'ms' },
            ].map(g => {
              const sel = customSelectedGroups.has(g.name);
              return (
                <button key={g.name}
                  className={`group-card-btn group-btn-${g.cls} custom-group-card-btn${sel ? ' selected' : ''}`}
                  onClick={() => {
                    setCustomSelectedGroups(prev => {
                      const next = new Set(prev);
                      next.has(g.name) ? next.delete(g.name) : next.add(g.name);
                      return next;
                    });
                  }}
                >
                  {sel && <span className="custom-group-check">✓</span>}
                  {g.label}
                </button>
              );
            })}
          </div>
          <button className="start-btn" disabled={customSelectedGroups.size === 0 || customIsLoadingSongs} onClick={loadCustomSongs}>
            {customIsLoadingSongs ? '読み込み中…' : '曲を選ぶ →'}
          </button>
          <button className="back-btn" onClick={() => setScreen('mode')}>モード選択へ</button>
        </div>
      )}

      {/* --- カスタム：曲選択 --- */}
      {screen === 'custom-select-song' && (
        <div className="box custom-select-card zoom-in">
          <h2 className="title">曲を選んでください</h2>
          <div className="custom-song-toggle-row">
            <button className="custom-toggle-btn" onClick={() => setCustomSelectedSongs(new Set(customSongList.map(s => `${s.group_name}::${s.song_name}`)))}>全選択</button>
            <button className="custom-toggle-btn" onClick={() => setCustomSelectedSongs(new Set())}>全解除</button>
            <span className="custom-selected-count">{customSelectedSongs.size}曲選択中</span>
          </div>
          <div className="custom-song-list">
            {[...new Set(customSongList.map(s => s.group_name))].map(groupName => (
              <div key={groupName}>
                <div className="custom-song-group-header">{groupName}</div>
                {customSongList.filter(s => s.group_name === groupName).map(s => {
                  const key = `${s.group_name}::${s.song_name}`;
                  return (
                    <label key={key} className={`custom-song-item${customSelectedSongs.has(key) ? ' selected' : ''}`}>
                      <input type="checkbox" checked={customSelectedSongs.has(key)} onChange={() => {
                        setCustomSelectedSongs(prev => {
                          const next = new Set(prev);
                          next.has(key) ? next.delete(key) : next.add(key);
                          return next;
                        });
                      }} />
                      {s.song_name}
                    </label>
                  );
                })}
              </div>
            ))}
          </div>
          <div className="custom-diff-row">
            <span className="custom-diff-label">難易度</span>
            <div className="custom-diff-toggles">
              {['easy', 'normal', 'hard', 'expert'].map(level => (
                <button
                  key={level}
                  className={`custom-diff-toggle custom-diff-toggle--${level}${customDifficulties.has(level) ? ' on' : ''}`}
                  onClick={() => {
                    setCustomDiffError(false);
                    setCustomDifficulties(prev => {
                      if (prev.has(level) && prev.size === 1) return prev;
                      const next = new Set(prev);
                      next.has(level) ? next.delete(level) : next.add(level);
                      return next;
                    });
                  }}
                >
                  {difficultyLabel[level]}
                </button>
              ))}
            </div>
          </div>
          {customDiffError && (
            <p className="custom-diff-error">選択した難易度に該当する歌詞がありません！</p>
          )}
          <button className="start-btn" disabled={customSelectedSongs.size === 0 || customIsLoading} onClick={startCustomMode}>
            {customIsLoading ? '問題を準備中…' : `スタート！（${customSelectedSongs.size}曲）`}
          </button>
          <button className="back-btn" onClick={() => setScreen('custom-select-group')}>グループ選択に戻る</button>
        </div>
      )}

      {/* --- グループ選択 --- */}
      {screen === 'group' && (
        <div className="box group-card zoom-in">
          <h2 className="title">グループを選択しましょう！</h2>
          <div className="group-grid">
          {[
            { name: 'FRUITS ZIPPER', label: '🍎FRUITS ZIPPER🍎', cls: 'fz' },
            { name: 'CANDY TUNE',    label: '🍬CANDY TUNE🍬',    cls: 'cd' },
            { name: 'SWEET STEADY',  label: '💐SWEET STEADY💐',  cls: 'ss' },
            { name: 'CUTIE STREET',  label: '💎CUTIE STREET💎',  cls: 'cs' },
            { name: 'MORE STAR',     label: '🌟MORE STAR🌟',     cls: 'ms' },
          ].filter(g => gameMode !== 'endless' || debugMode || endlessUnlockedGroups.has(g.name))
           .map(g => (
            <button key={g.name} className={`group-card-btn group-btn-${g.cls}`} onClick={() => {
              setQuizState(prev => ({ ...prev, group: g.name }));
              if (gameMode === 'endless') { setScreen('confirm'); prepareEndlessMode(g.name); }
              else setScreen('difficulty');
            }}>{g.label}</button>
          ))}
          </div>
          <button className="back-btn-group back-btn-top" onClick={() => setScreen('mode')}>モード選択に戻る</button>
        </div>
      )}

      {/* --- 難易度選択 --- */}
      {screen === 'difficulty' && (
        <div className="box difficulty-card zoom-in">
          <div className={`selected-group-badge selected-group-badge--${{ 'FRUITS ZIPPER': 'fz', 'CANDY TUNE': 'cd', 'SWEET STEADY': 'ss', 'CUTIE STREET': 'cs', 'MORE STAR': 'ms' }[quizState.group] || 'fz'}`}>{quizState.group}</div>
          <h2 className="title">難易度を選択しましょう！</h2>
          <p className="diff-longpress-hint">
            {window.matchMedia('(pointer: coarse)').matches
              ? 'ボタンの長押しで難易度の説明を確認してね'
              : 'ボタンにカーソルを乗せて難易度の説明を確認してね'}
          </p>
          <div className="difficulty-grid">
            {['easy', 'normal', 'hard', 'expert'].map((level, idx) => (
              <div key={level} className="difficulty-item">
                <button
                  className={`diff-btn diff-btn-${level}${timerLevel === level ? ' is-pressing' : ''}`}
                  onClick={() => {
                    if (longPressTriggeredRef.current) { longPressTriggeredRef.current = false; return; }
                    setQuizState(prev => ({...prev, difficulty: level, quizzes: []}));
                    setStatusMsg('');
                    setScreen('confirm');
                  }}
                  onMouseEnter={() => {
                    if (touchEndedRef.current) return; // タッチ後の合成mouseenterを無視
                    clearTimeout(tooltipHoverTimerRef.current);
                    if (tooltipLevel === level && tooltipClosing) {
                      clearTimeout(tooltipCloseTimerRef.current);
                      setTooltipClosing(false);
                    } else if (tooltipLevel !== level) {
                      setTimerLevel(level);
                      setTimerKey(k => k + 1);
                      tooltipHoverTimerRef.current = setTimeout(() => openTooltip(level), 1000);
                    }
                  }}
                  onMouseLeave={() => {
                    if (touchEndedRef.current) return;
                    clearTimeout(tooltipHoverTimerRef.current);
                    setTimerLevel(null);
                    if (tooltipLevel === level && !tooltipClosing) closeTooltip();
                  }}
                  onTouchStart={() => {
                    touchEndedRef.current = false;
                    clearTimeout(touchEndTimerRef.current);
                    longPressTriggeredRef.current = false;
                    setTimerLevel(level);
                    setTimerKey(k => k + 1);
                    longPressTimerRef.current = setTimeout(() => {
                      longPressTriggeredRef.current = true;
                      openTooltip(level);
                    }, 1000);
                  }}
                  onTouchEnd={(e) => {
                    e.currentTarget.blur();
                    touchEndedRef.current = true;
                    clearTimeout(touchEndTimerRef.current);
                    touchEndTimerRef.current = setTimeout(() => { touchEndedRef.current = false; }, 600);
                    clearTimeout(longPressTimerRef.current);
                    setTimerLevel(null);
                    if (tooltipLevel === level) closeTooltip();
                  }}
                  onTouchCancel={() => {
                    touchEndedRef.current = true;
                    clearTimeout(touchEndTimerRef.current);
                    touchEndTimerRef.current = setTimeout(() => { touchEndedRef.current = false; }, 600);
                    clearTimeout(longPressTimerRef.current);
                    setTimerLevel(null);
                    if (tooltipLevel === level) closeTooltip();
                  }}
                  onContextMenu={(e) => e.preventDefault()}
                >
                  {difficultyLabel[level]}
                  {timerLevel === level && (
                    <span key={timerKey} className="diff-btn-timer" />
                  )}
                </button>
                {tooltipLevel === level && (
                  <div
                    ref={diffTooltipRef}
                    className={`diff-tooltip diff-tooltip--${idx % 2 === 0 ? 'left' : 'right'}${tooltipClosing ? ' closing' : ''}`}
                    onMouseEnter={() => {
                      clearTimeout(tooltipCloseTimerRef.current);
                      setTooltipClosing(false);
                    }}
                    onMouseLeave={() => closeTooltip()}
                  >
                    {descriptions[level].map((item, i) => (
                      <div key={i} className="diff-tooltip-item">・{item}</div>
                    ))}
                  </div>
                )}
              </div>
            ))}
          </div>
          <button className="back-btn-group" onClick={() => setScreen('group')}>グループ選択に戻る</button>
        </div>
      )}

      {/* --- 確認画面 --- */}
      {screen === 'confirm' && (
        <div className="box confirm-card zoom-in">
          <h2 className="title">出題内容の確認</h2>
          <div className="info-card">
            <div className="confirm-item"><span className="confirm-label">グループ</span><span className="confirm-value">{quizState.group}</span></div>
            <div className="confirm-item"><span className="confirm-label">難易度</span><span className="confirm-value">{gameMode === 'endless' ? '全難易度' : difficultyLabel[quizState.difficulty]}</span></div>
            <p className="preparing-status">{statusMsg}</p>
          </div>
          <div className="confirm-rules">
            {gameMode === 'normal' ? (<>
              <p className="confirm-rules-title">📋 ルール　📋</p>
              <ul>
                <li><strong>60秒</strong>以内に回答してください</li>
                <li>途中でやめることはできません</li>
              </ul>
            </>) : (<>
              <p className="confirm-rules-title">📋 ルール　📋</p>
              <ul>
                <li>時間制限なし、じっくり考えてください</li>
                <li>難易度が段階的に上がります</li>
                <li><span style={{color:'#e53935'}}>♥</span> がなくると終了、連続正解で <span style={{color:'#e53935'}}>♥</span> を獲得</li>
                <li>いつでも中断OK、続きから再開できます</li>
              </ul>
            </>)}
          </div>
          <button className="start-btn" disabled={isPreparing} onClick={async () => {
            setIsPreparing(true);
            try {
              if (gameMode === 'endless') { await startQuiz(); return; }
              const ok = await prepareQuiz(quizState.group, quizState.difficulty);
              if (ok) await startQuiz();
            } finally {
              setIsPreparing(false);
            }
          }}>{isPreparing ? 'ロード中…' : 'クイズを始める！'}</button>
          <button className="back-btn" onClick={() => setScreen(gameMode === 'endless' ? 'group' : 'difficulty')}>
            {gameMode === 'endless' ? 'グループ選択に戻る' : '難易度選択に戻る'}
          </button>
        </div>
      )}

      {/* --- アナウンス画面 --- */}
      {screen === 'quiz' && quizPhase === 'announce' && (
        <div className="quiz-announce-overlay">
          <div className="announce-main">
            <p className="announce-question-num">
              {gameMode === 'endless' ? `第${endlessQNum}問` :
               gameMode === 'custom' ? `第${customTotalQ - customRemaining + 1}問` :
               `第${quizState.currentIndex + 1}問`}
            </p>
            <p className="announce-from-text">
              <span className="announce-song-name">{quizCurr?.song_name}</span>
              <br />
              <span className="announce-from-suffix">からの出題です！</span>
            </p>
          </div>
          <button className="announce-skip-btn-overlay" onClick={() => setQuizPhase('question')}>スキップ →</button>
        </div>
      )}

      {/* --- 全歌詞スクロール画面（アナウンス時はバック表示） --- */}
      {screen === 'quiz' && (quizPhase === 'announce' || quizPhase === 'scrolling') && (
        <div className="box quiz-scrolling-card">
          <div className="scrolling-topbar">
            <p className="scrolling-song-name">{quizCurr?.song_name}</p>
            <button className="scrolling-skip-btn" onClick={() => setQuizPhase('question')}>スキップ →</button>
          </div>
          <div ref={lyricBodyRef} className={`scrolling-lyrics-body${scrollAnimPhase === 'zooming' ? ' is-zooming' : ''}`}>
            {isLoadingLyrics && quizPhase === 'scrolling' ? (
              <p className="scrolling-loading">読み込み中...</p>
            ) : groupLyricRows(fullSongLyrics).map((group) => {
              if (group.type === 'section-break') return <div key={group.key} className="lyric-section-break" />;
              const ids = group.type === 'single'
                ? [group.row.lyrics_id]
                : [group.base.lyrics_id, ...group.appends.map(a => a.lyrics_id)];
              const isQ = ids.includes(quizCurr?.lyrics_id);
              const key = group.type === 'single' ? group.row.lyrics_id : group.base.lyrics_id;
              return renderLyricGroup(group, isQ, { key, ref: isQ ? questionLyricScrollRef : null }, 'scrolling-lyric-row', 'scrolling-lyric-target', quizCurr?.lyrics_id);
            })}
          </div>
        </div>
      )}

      {/* --- クイズ画面 --- */}
      {screen === 'quiz' && quizPhase === 'question' && (
        <div className="box quiz-card zoom-in">
          {/* カスタムモード：上部ボタン行 */}
          {gameMode === 'custom' && (
            <div className="custom-quiz-toprow">
              <button className="custom-quit-btn" onClick={() => setCustomQuitModal(true)}>クイズを終わる</button>
              {!answered && (
                <button className="custom-skip-btn" onClick={() => nextCustomQuestion(true)}>スキップ</button>
              )}
            </div>
          )}
          {/* エンドレスモード：ライフ表示 */}
          {gameMode === 'endless' && (
            <div className="endless-quiz-header">
              <div className="endless-lives-row">
                {(() => {
                  const yellow = Math.floor(endlessLives / 10);
                  const red = endlessLives % 10;
                  return (<>
                    {Array.from({ length: Math.min(yellow, 9) }).map((_, i) => (
                      <span key={`y${i}`} className="endless-heart yellow">♥</span>
                    ))}
                    {yellow > 9 && <span className="endless-heart-overflow">×{yellow}</span>}
                    {Array.from({ length: red }).map((_, i) => (
                      <span key={`r${i}`} className="endless-heart">♥</span>
                    ))}
                    {endlessLives === 0 && <span className="endless-heart empty">♡</span>}
                  </>);
                })()}
              </div>
              {endlessLifeBonus.type !== 'none' && (
                <span key={endlessLifeBonus.key} className={`endless-life-bonus-popup${endlessLifeBonus.type === 'penalty' ? ' endless-life-penalty-popup' : ''}`}>
                  {endlessLifeBonus.type === 'bonus'
                    ? `COMBOボーナス！♥+${endlessLifeBonus.amount}`
                    : `♥-1`}
                </span>
              )}
            </div>
          )}
          <p className="quiz-challenge-label">
            {gameMode === 'custom'
              ? 'カスタムモードに挑戦中'
              : `${quizState.group}の${gameMode === 'endless' ? 'エンドレス' : difficultyLabel[quizState.difficulty]}に挑戦中`}
          </p>
          {gameMode === 'endless' ? (
            <p className="quiz-counter">{endlessQNum} 問目</p>
          ) : gameMode === 'custom' ? (
            <p className="quiz-counter">残り <strong>{customRemaining}</strong> 問</p>
          ) : (
            <p className="quiz-counter">{quizState.currentIndex + 1} / {quizState.quizzes.length} 問目</p>
          )}
          {gameMode === 'normal' && (
            <div className="progress-container">
              <div className="progress-bar" style={{width: `${(quizState.currentIndex + 1) / quizState.quizzes.length * 100}%`}}></div>
            </div>
          )}
          {/* 検定モード：60秒タイマー */}
          {gameMode === 'normal' && (
            <div className="quiz-qtimer-wrap">
              <div className="quiz-qtimer-track">
                <div className={`quiz-qtimer-bar${questionTimer <= 10 ? ' danger' : ''}`}
                     style={{ width: `${(questionTimer / 60) * 100}%` }} />
              </div>
              <span className={`quiz-qtimer-num${questionTimer <= 10 ? ' danger' : ''}`}>{questionTimer}秒</span>
            </div>
          )}
          {/* 検定・カスタムモード：歌詞全体確認ボタン */}
          {(gameMode === 'normal' || gameMode === 'custom') && (
            <button className="lyrics-toggle-btn" onClick={() => setShowFullLyrics(v => !v)}>
              {showFullLyrics ? '問題の歌詞に戻る' : '歌詞全体を確認する'}
            </button>
          )}
          <h2 className="title quiz-title">だれが歌ってる？</h2>

          <p id="lyrics" ref={lyricsRef}>{renderLyricsWithAite(quizCurr?.lyrics)}</p>

          <div className="members">
            {displayMembers.map(m => (
              <button key={m.id}
                className={`member-btn${selectedMembers.has(m.name) ? ' on' : ''}`}
                onClick={() => toggleMember(m.name)}
                disabled={answered}
              >{m.name}</button>
            ))}
            <button
              className={`member-btn all-btn${selectedMembers.size === displayMembers.length && displayMembers.length > 0 ? ' on' : ''}`}
              onClick={() => {
                if (selectedMembers.size === displayMembers.length) setSelectedMembers(new Set());
                else setSelectedMembers(new Set(displayMembers.map(m => m.name)));
              }}
              disabled={answered}
            >全員</button>
          </div>

          {!answered && (
            <button className="submit" onClick={handleAnswer}>回答する</button>
          )}

          {resultMsg.text && (
            <p id="result" className={`animate ${resultMsg.type}`} dangerouslySetInnerHTML={{__html: resultMsg.text}}></p>
          )}

          {answered && quizExplanation && (
            <div id="explanation">{quizExplanation}</div>
          )}

          {answered && !(gameMode === 'endless' && endlessIsOver) && (
            <button
              className="submit"
              onClick={nextQuestion}
              disabled={(gameMode === 'endless' && endlessNextQLoading) || nextQLoading}
            >
              {(gameMode === 'endless' && endlessNextQLoading) || nextQLoading ? 'ロード中…' : '次の問題へ'}
            </button>
          )}
        </div>
      )}

      {/* --- 検定・カスタムモード：全歌詞モーダル --- */}
      {screen === 'quiz' && (gameMode === 'normal' || gameMode === 'custom') && quizPhase === 'question' && showFullLyrics && (
        <div className="modal-overlay" onClick={() => setShowFullLyrics(false)}>
          <div className="modal-content song-lyrics-modal" onClick={e => e.stopPropagation()}>
            <h2>{quizCurr?.song_name}</h2>
            <div className="full-lyrics-list">
              {groupLyricRows(fullSongLyrics).map((group) => {
                if (group.type === 'section-break') return <div key={group.key} className="lyric-section-break" />;
                const ids = group.type === 'single'
                  ? [group.row.lyrics_id]
                  : [group.base.lyrics_id, ...group.appends.map(a => a.lyrics_id)];
                const isQ = ids.includes(quizCurr?.lyrics_id);
                const key = group.type === 'single' ? group.row.lyrics_id : group.base.lyrics_id;
                return renderLyricGroup(
                  group, isQ,
                  { key, ref: isQ ? fullLyricsHighlightRef : null },
                  'full-lyrics-row', `full-lyrics-highlight${fullLyricsBlink ? ' full-lyrics-blink' : ''}`,
                  quizCurr?.lyrics_id
                );
              })}
            </div>
            <button className="modal-close-btn" onClick={() => setShowFullLyrics(false)}>問題に戻る</button>
          </div>
        </div>
      )}

      {/* --- エンドレスゲームオーバーオーバーレイ --- */}
      {screen === 'quiz' && gameMode === 'endless' && endlessIsOver && (
        <div className="endless-gameover-overlay">
          <div className="endless-gameover-box">
            <p className="endless-go-title">💔 ゲームオーバー！</p>
            <button className="endless-go-btn" onClick={() => {
              if (sessionId) {
                supabase.from('sessions').delete().eq('session_id', sessionId).then(() => {});
                localStorage.removeItem('quiz_session_id');
                setSessionId(null);
              }
              setScreen('result');
            }}>
              リザルトへ進む →
            </button>
          </div>
        </div>
      )}

      {/* --- 解放アニメーション中クリックブロック --- */}
      {isUnlockAnimating && (
        <div style={{position:'fixed',inset:0,zIndex:9998,pointerEvents:'all'}} />
      )}

      {/* --- エンドレスモード解放フラッシュ --- */}
      {endlessNewUnlockNotif && (
        <div className="endless-unlock-flash-overlay">
          <div className="endless-unlock-flash-text">🎉 エンドレスモード解放！<br/><span className="endless-unlock-flash-group">{endlessNewUnlockNotif}</span></div>
        </div>
      )}

      {/* --- カスタムモード解放フラッシュ --- */}
      {customNewUnlockNotif && (
        <div className="endless-unlock-flash-overlay">
          <div className="endless-unlock-flash-text">🎉 カスタムモード解放！</div>
        </div>
      )}

      {/* --- カスタムドラムロールオーバーレイ --- */}
      {screen === 'result' && gameMode === 'custom' && (resultPhase === 'announce' || resultPhase === 'drumroll') && (
        <div className="drumroll-overlay">
          {resultPhase === 'announce' ? (
            <p className="drumroll-announce">あなたの正解数は…</p>
          ) : (
            <div className="score-circle drumroll-circle">
              <span className="score-num">{displayScore}</span>
            </div>
          )}
        </div>
      )}

      {/* --- エンドレスドラムロールオーバーレイ --- */}
      {screen === 'result' && gameMode === 'endless' && (resultPhase === 'announce' || resultPhase === 'drumroll') && (
        <div className="drumroll-overlay">
          {resultPhase === 'announce' ? (
            <p className="drumroll-announce">あなたの正解数は…</p>
          ) : (
            <div className="score-circle drumroll-circle">
              <span className="score-num">{displayScore}</span>
            </div>
          )}
        </div>
      )}

      {/* --- ドラムロールオーバーレイ --- */}
      {screen === 'result' && gameMode === 'normal' && (resultPhase === 'announce' || resultPhase === 'drumroll') && (
        <div className="drumroll-overlay">
          {resultPhase === 'announce' ? (
            <p className="drumroll-announce">あなたの得点は…</p>
          ) : (
            <div className="score-circle drumroll-circle">
              <span className="score-num">{displayScore}</span>
            </div>
          )}
        </div>
      )}

      {/* --- カスタムリザルト画面 --- */}
      {screen === 'result' && gameMode === 'custom' && resultPhase === 'reveal' && (
        <div className="box result-box zoom-in">
          <p className="result-label">カスタムモードの結果</p>
          <div className="endless-result-hero">
            <span className="endless-result-num">{quizState.correctCount}</span>
            <span className="endless-result-slash"> / </span>
            <span className="endless-result-total">{customAnsweredTotal}</span>
            <span className="endless-result-unit">問正解！</span>
          </div>

          {customWrongAnswers.length > 0 && (
            <button className="review-btn" onClick={() => setScreen('custom-review')}>
              不正解の歌詞を確認（{customWrongAnswers.length}問）
            </button>
          )}
          <p className="custom-perfect-msg">またチャレンジしてね！</p>
          <div className="result-buttons">
            <div className="result-btn-row">
              <button className="group-btn" onClick={() => setScreen('custom-select-group')}>曲を選び直す</button>
              <button className="mode-back-btn" onClick={() => setScreen('mode')}>モード選択へ</button>
            </div>
            <button className="result-back-link" onClick={() => setScreen('top')}>トップに戻る</button>
          </div>
        </div>
      )}

      {/* --- カスタム：終了確認モーダル --- */}
      {customQuitModal && (
        <div className="modal-overlay" onClick={() => setCustomQuitModal(false)}>
          <div className="modal-content" onClick={e => e.stopPropagation()} style={{textAlign: 'center'}}>
            <h2>クイズを終了しますか？</h2>
            <p style={{color: '#888', fontSize: '0.85rem', marginBottom: '10px'}}>現在の正解数でリザルトを表示します</p>
            <button className="resume-continue-btn" onClick={() => { setCustomQuitModal(false); customResultReadyRef.current = false; setCustomAnsweredTotal(customTotalQ - customRemaining); setScreen('result'); }}>はい</button>
            <button className="resume-discard-btn" style={{marginTop: '6px'}} onClick={() => setCustomQuitModal(false)}>いいえ</button>
          </div>
        </div>
      )}

      {/* --- カスタムレビュー画面 --- */}
      {screen === 'custom-review' && (() => {
        const allMembersList = Object.values(customMembersByGroup).flat();
        const memberColorLookup = {};
        const memberLastNameLookup = {};
        allMembersList.forEach(m => {
          memberColorLookup[m.name] = memberColorCSS[m.color] || '#333';
          memberLastNameLookup[m.name] = m.Last_name || m.name;
        });
        return (
          <div className="box custom-review-box zoom-in">
            <h2 className="title">不正解だった歌詞</h2>
            <div className="custom-review-list">
              {customWrongAnswers.map((w, i) => {
                const correctArr = w.correct_members.split(',').map(s => s.trim()).filter(Boolean);
                const isSolo = correctArr.length === 1;
                const lyricsColor = isSolo ? (memberColorLookup[correctArr[0]] || '#333') : '#333';
                return (
                  <div key={i} className="custom-review-item">
                    <div className="custom-review-song">
                      ♪ {w.song_name}
                      <span className="custom-review-group">（{w.group_name}）</span>
                    </div>
                    <div className="custom-review-lyrics">
                      {w.lyrics ? w.lyrics.split('\n').map((line, li) => {
                        const occ = w.occurrence && w.occurrence[li];
                        return (
                          <Fragment key={li}>
                            {li > 0 && '\n'}
                            {renderLineWithAite(line, `cr-${li}`)}
                            {occ != null && <span className="song-modal-occurrence">（{occ}回目）</span>}
                          </Fragment>
                        );
                      }) : ''}
                    </div>
                    <div className="custom-review-answer">
                      🎤 {correctArr.map((name, ni) => (
                        <span key={ni}>
                          {ni > 0 && <span style={{ color: '#888' }}>・</span>}
                          <span style={{ color: memberColorLookup[name] || '#c2185b' }}>{memberLastNameLookup[name] || name}</span>
                        </span>
                      ))}
                    </div>
                  </div>
                );
              })}
            </div>
            <button className="back-btn" onClick={() => setScreen('result')}>リザルトに戻る</button>
          </div>
        );
      })()}

      {/* --- エンドレスリザルト画面 --- */}
      {screen === 'result' && gameMode === 'endless' && resultPhase === 'reveal' && (
        <div className="box result-box zoom-in">
          <p className="result-label">エンドレスの結果は…</p>
          <div className="endless-result-hero">
            <span className="endless-result-num">{quizState.correctCount}</span>
            <span className="endless-result-slash"> / </span>
            <span className="endless-result-total">{endlessQNum}</span>
            <span className="endless-result-unit">問正解！</span>
          </div>
          <div className="info-badges">
            <span className="badge">{quizState.group}</span>
            <span className="badge badge-endless">エンドレス</span>
          </div>
          <div className="result-buttons">
            <button className="share-btn" onClick={shareEndlessOnX}>
              <svg width="16" height="16" viewBox="0 0 24 24" fill="currentColor" style={{marginRight: '8px'}}>
                <path d="M18.244 2.25h3.308l-7.227 8.26 8.502 11.24H16.17l-5.214-6.817L4.99 21.75H1.68l7.73-8.835L1.254 2.25H8.08l4.713 6.231zm-1.161 17.52h1.833L7.084 4.126H5.117z"></path>
              </svg>
              結果をXでつぶやく
            </button>
            <div className="result-btn-row">
              <button className="retry-btn" onClick={() => {
                if (sessionId) {
                  supabase.from('sessions').delete().eq('session_id', sessionId).then(() => {});
                  localStorage.removeItem('quiz_session_id');
                  setSessionId(null);
                }
                setScreen('confirm');
                prepareEndlessMode(quizState.group);
              }}>もう一回！</button>
              <button className="mode-back-btn" onClick={() => setScreen('mode')}>モード選択へ</button>
            </div>
            <button className="result-back-link" onClick={() => setScreen('top')}>トップに戻る</button>
          </div>
        </div>
      )}

      {/* --- 通常モードリザルト画面 --- */}
      {screen === 'result' && gameMode === 'normal' && resultPhase === 'reveal' && (
        <div className="box result-box zoom-in">
          <p className="result-label">あなたの検定結果は…</p>

          <div className="result-hero">
            <h2 ref={rankRef} className={`rank-display rank-display--${getRankTier(quizState.correctCount)}${quizState.difficulty === 'expert' && quizState.correctCount === 10 ? ' genius' : ''}`}>{getRank(quizState.correctCount)}</h2>
            <div className={`score-circle score-circle--${getRankTier(quizState.correctCount)}`}>
              <span className="score-num">{displayScore}</span>
            </div>
          </div>

          <div className="info-badges">
            <span className="badge">{quizState.group}</span>
            <span className="badge">{difficultyLabel[quizState.difficulty]}</span>
          </div>

          <div className="message-area">
            <p className="comment-text" ref={commentRef} dangerouslySetInnerHTML={{ __html: resultMessages[quizState.difficulty][quizState.correctCount === 10 ? 'perfect' : quizState.correctCount === 0 ? 'zero' : quizState.correctCount >= 7 ? 'high' : quizState.correctCount >= 4 ? 'mid' : 'low'] }}></p>
          </div>

          <div className="result-buttons">
            <button className="share-btn" onClick={shareOnX}>
              <svg width="16" height="16" viewBox="0 0 24 24" fill="currentColor" style={{marginRight: '8px'}}>
                <path d="M18.244 2.25h3.308l-7.227 8.26 8.502 11.24H16.17l-5.214-6.817L4.99 21.75H1.68l7.73-8.835L1.254 2.25H8.08l4.713 6.231zm-1.161 17.52h1.833L7.084 4.126H5.117z"></path>
              </svg>
              結果をXでつぶやく
            </button>
            <div className="result-btn-row">
              <button className="retry-btn" onClick={() => { setScreen('confirm'); setAnswered(false); setStatusMsg(''); setQuizState(p=>({...p, correctCount:0, currentIndex:0, quizzes:[]})); setSelectedMembers(new Set()); }}>もう一回！</button>
              <button className="mode-back-btn" onClick={() => setScreen('mode')}>モード選択へ</button>
            </div>
            <button className="result-back-link" onClick={() => setScreen('top')}>トップに戻る</button>
          </div>
        </div>
      )}

      {/* --- 楽曲歌詞モーダル --- */}
      {(songModal || closingSongModal) && (() => {
        const memberLookup = {};
        songModalMembers.forEach(m => {
          memberLookup[m.name] = { lastName: m.Last_name, color: memberColorCSS[m.color] || '#333' };
        });

        const spaceChar = (sp) => sp === 'half' ? ' ' : sp === 'full' ? '　' : '';
        const groups = [];
        let prevSec = null;
        let curGroup = null;
        songModalData.forEach((row, i) => {
          if (i > 0 && row.section_name !== prevSec) {
            if (curGroup) { groups.push(curGroup); curGroup = null; }
            groups.push({ type: 'break', key: `sb-${i}` });
          }
          prevSec = row.section_name;
          const col = row.lyric_col;
          if (!col || col === 1) {
            if (curGroup) groups.push(curGroup);
            if (!col) {
              groups.push({ type: 'row', row, i });
              curGroup = null;
            } else {
              curGroup = { type: 'group', base: row, baseIdx: i, appends: [] };
            }
          } else {
            if (curGroup) curGroup.appends.push({ row, i });
            else groups.push({ type: 'row', row, i });
          }
        });
        if (curGroup) groups.push(curGroup);

        const getAnnotHTML = (correctArr, lyricText) => {
          const lyricsColor = correctArr.length === 1 ? (memberLookup[correctArr[0]]?.color || '#333') : '#333';
          const lyricEsc = (lyricText || '').replace(/</g, '&lt;').replace(/>/g, '&gt;');
          const membersHTML = correctArr.map((n, ni) => {
            const sep = ni > 0 ? '<span style="color:#777">・</span>' : '';
            const color = memberLookup[n]?.color || '#555';
            const name = (memberLookup[n]?.lastName || n).replace(/</g, '&lt;').replace(/>/g, '&gt;');
            return `${sep}<span style="color:${color}">${name}</span>`;
          }).join('');
          return `<div class="song-modal-annot-card-lyrics" style="color:${lyricsColor}">${lyricEsc}</div><div class="song-modal-annot-card-members">🎤 ${membersHTML}</div>`;
        };
        const showTouchAnnot = (rectTop, rectBottom, left, correctArr, lyricText) => {
          const el = touchAnnotRef.current;
          if (!el) return;
          el.innerHTML = getAnnotHTML(correctArr, lyricText);
          el.style.left = `${left}px`;
          el.style.top = '-9999px';
          el.style.transition = 'none';
          el.style.opacity = '0';
          void el.offsetHeight; // 高さを確定
          const elH = el.offsetHeight;
          const posAbove = rectTop - elH - 5;
          el.style.top = `${posAbove >= 8 ? posAbove : rectBottom + 5}px`;
          void el.offsetHeight; // ブラウザに位置を確定させてからトランジション開始
          el.style.transition = 'opacity 0.18s ease-out';
          el.style.opacity = '1';
        };
        const hideTouchAnnot = () => {
          const el = touchAnnotRef.current;
          if (!el) return;
          el.style.transition = 'opacity 0.18s ease-in';
          el.style.opacity = '0';
        };

        const renderAnnotContent = (correctArr, lyricText) => {
          const lyricsColor = correctArr.length === 1 ? (memberLookup[correctArr[0]]?.color || '#333') : '#333';
          return (
            <>
              <div className="song-modal-annot-card-lyrics" style={{ color: lyricsColor }}>
                {(lyricText || '').split('\n').map((line, li) => (
                  <Fragment key={li}>{li > 0 && <br />}{line}</Fragment>
                ))}
              </div>
              <div className="song-modal-annot-card-members">
                🎤 {correctArr.map((n, ni) => (
                  <Fragment key={ni}>
                    {ni > 0 && <span style={{ color: '#777' }}>・</span>}
                    <span style={{ color: memberLookup[n]?.color || '#555' }}>
                      {memberLookup[n]?.lastName || n}
                    </span>
                  </Fragment>
                ))}
              </div>
            </>
          );
        };

        return (
          <div className={`modal-overlay${closingSongModal ? ' closing' : ''}`} onClick={closeSongModal}>
            <div className="modal-content song-lyrics-modal" onClick={e => e.stopPropagation()}>
              <h2>{songModal?.title}</h2>
              <div className="song-modal-legend">
                {songModalMembers.map((m, mi) => (
                  <span key={mi} className="song-modal-legend-item">
                    <span className="song-modal-legend-dot" style={{ background: memberColorCSS[m.color] || '#333' }} />
                    <span style={{ color: memberColorCSS[m.color] || '#333' }}>{m.Last_name}</span>
                  </span>
                ))}
                {songModalMembers.length > 0 && <>
                  <span className="song-modal-legend-item">
                    <span className="song-modal-legend-dot" style={{ background: '#444' }} />
                    <span style={{ color: '#444', fontWeight: 'bold' }}>複数</span>
                  </span>
                  <span className="song-modal-legend-item">
                    <span className="song-modal-legend-dot" style={{ background: '#333' }} />
                    <span style={{ color: '#333' }}>全員</span>
                  </span>
                </>}
              </div>
              {isLoadingSongModal ? (
                <div className="song-modal-loading">データを取得中...</div>
              ) : songModalData.length === 0 ? (
                <div className="song-modal-loading">データがありません</div>
              ) : (
                <div className="full-lyrics-list">
                  {groups.map((item) => {
                    if (item.type === 'break') return <div key={item.key} className="lyric-section-break" />;

                    const partColor = (r) => {
                      const arr = (r.correct_members || '').split(',').map(s => s.trim()).filter(Boolean);
                      return arr.length === 1 ? (memberLookup[arr[0]]?.color || '#333') : '#333';
                    };
                    const partBold = (r) => {
                      const arr = (r.correct_members || '').split(',').map(s => s.trim()).filter(Boolean);
                      return arr.length >= 2 && arr.length < songModalMembers.length;
                    };

                    if (item.type === 'group') {
                      const i = item.baseIdx;
                      const allParts = [item.base, ...item.appends.map(ap => ap.row)];

                      const renderPartLines = (r, kp) => {
                        const color = partColor(r);
                        const bold = partBold(r);
                        return (r.lyrics ? r.lyrics.split('\n') : ['']).map((line, li) => (
                          <Fragment key={`${kp}-${li}`}>
                            {li > 0 && '\n'}
                            <span style={{ color, fontWeight: bold ? 'bold' : undefined }}>{renderLineWithAite(line, `${kp}-${li}`)}</span>
                          </Fragment>
                        ));
                      };

                      return (
                        <div key={i} className="song-modal-lyric-row">
                          {allParts.map((r, ri) => {
                            const prev = ri === 0 ? null : allParts[ri - 1];
                            const arr = (r.correct_members || '').split(',').map(s => s.trim()).filter(Boolean);
                            const isPartMulti = arr.length >= 2 && arr.length < songModalMembers.length;
                            return (
                              <Fragment key={ri}>
                                {ri > 0 && spaceChar(prev.col_space)}
                                {isPartMulti ? (
                                  <>
                                    <span
                                      className="song-modal-lyric-text"
                                      onTouchStart={(e) => { const rect = e.currentTarget.getBoundingClientRect(); showTouchAnnot(rect.top, rect.bottom, rect.left, arr, r.lyrics || ''); }}
                                      onTouchEnd={hideTouchAnnot}
                                      onTouchCancel={hideTouchAnnot}
                                    >
                                      {renderPartLines(r, `sm-g-${i}-${ri}`)}
                                    </span>
                                    <div className="song-modal-lyric-annotation">{renderAnnotContent(arr, r.lyrics || '')}</div>
                                  </>
                                ) : (
                                  renderPartLines(r, `sm-g-${i}-${ri}`)
                                )}
                              </Fragment>
                            );
                          })}
                        </div>
                      );
                    }

                    // type: 'row'
                    const { row, i } = item;
                    const correctArr = (row.correct_members || '').split(',').map(s => s.trim()).filter(Boolean);
                    const hasAnnot = correctArr.length >= 2 && correctArr.length < songModalMembers.length;
                    const lyricColor = partColor(row);
                    const lyricBold = partBold(row);
                    const lyricLines = row.lyrics ? row.lyrics.split('\n') : [''];
                    const lyricText = row.lyrics || '';
                    return (
                      <div key={i} className="song-modal-lyric-row" style={{ color: lyricColor, fontWeight: lyricBold ? 'bold' : undefined }}>
                        <span
                          className={hasAnnot ? 'song-modal-lyric-text' : undefined}
                          onTouchStart={hasAnnot ? (e) => { const rect = e.currentTarget.getBoundingClientRect(); showTouchAnnot(rect.top, rect.bottom, rect.left, correctArr, lyricText); } : undefined}
                          onTouchEnd={hasAnnot ? hideTouchAnnot : undefined}
                          onTouchCancel={hasAnnot ? hideTouchAnnot : undefined}
                        >
                          {lyricLines.map((line, li) => (
                            <Fragment key={li}>
                              {li > 0 && '\n'}
                              {renderLineWithAite(line, `sm-${i}-${li}`)}
                            </Fragment>
                          ))}
                        </span>
                        {hasAnnot && <span className="song-modal-lyric-annotation">{renderAnnotContent(correctArr, lyricText)}</span>}
                      </div>
                    );
                  })}
                </div>
              )}
              <button className="modal-close-btn" onClick={closeSongModal}>とじる</button>
            </div>
            <div ref={touchAnnotRef} className="song-modal-annot-fixed" />
          </div>
        );
      })()}

      {/* --- 検定モード トップ戻り確認モーダル --- */}
      {showBackConfirm && (
        <div className="modal-overlay" onClick={() => setShowBackConfirm(false)}>
          <div className="modal-content" onClick={e => e.stopPropagation()} style={{textAlign: 'center'}}>
            <h2>⚠️ トップに戻りますか？</h2>
            <p style={{marginBottom: '10px'}}>検定モードはセッションが残りません！<br />本当に戻りますか？</p>
            <button className="resume-continue-btn" onClick={() => {
              setShowBackConfirm(false);
              clearInterval(questionTimerIntervalRef.current);
              setScreen('top');
            }}>トップに戻る</button>
            <button className="resume-discard-btn" style={{marginTop: '6px'}} onClick={() => setShowBackConfirm(false)}>
              キャンセル
            </button>
          </div>
        </div>
      )}

      {/* --- セッション再開モーダル --- */}
      {(showResumeModal || closingResumeModal) && pendingResume && (
        <div className={`modal-overlay${closingResumeModal ? ' closing' : ''}`} onClick={closeResumeModal}>
          <div className="modal-content" onClick={e => e.stopPropagation()} style={{textAlign: 'center'}}>
            <h2>📖 途中のエンドレスが見つかりました</h2>
            <p style={{marginBottom: '6px'}}>{pendingResume.group_name}・エンドレスモード</p>
            <p style={{marginBottom: '10px'}}>{pendingResume.current_step}問目から再開できます</p>
            <button className="resume-continue-btn" onClick={() => { closeResumeModal(); resumeQuiz(); }} disabled={isResumingSession}>
              {isResumingSession ? '読み込み中…' : '▶ 続きから始める'}
            </button>
            <button className="resume-discard-btn" style={{marginTop: '6px'}} onClick={() => { closeResumeModal(); discardSession(); if (resumeModalSource === 'songlist') fetchSongList(); else setScreen('group'); }}>
              クイズのセッションをリセットする
            </button>
          </div>
        </div>
      )}

      {/* --- モーダル --- */}
      {showPolicy && (
        <div className={`modal-overlay${closingPolicy ? ' closing' : ''}`} onClick={closePolicy}>
          <div className="modal-content" onClick={e => e.stopPropagation()}>
            <h2>プライバシーポリシー</h2>
            <div className="modal-body">
              <h3>個人情報の収集について</h3>
              <p>当サイトでは、ユーザーの氏名・メールアドレス・住所等の個人情報を一切収集しておりません。</p>
              <h3>セッションデータについて</h3>
              <p>クイズの進行状況を保存するため、匿名のセッションID（ランダムに生成された識別子）をサーバーに一時保存しています。このデータに個人を特定できる情報は含まれておらず、ゲーム終了時に自動的に削除されます。</p>
              <h3>アクセス解析ツールについて</h3>
              <p>当サイトでは、サイトの利用状況を把握するために「Google アナリティクス」を利用しています。Google アナリティクスはデータの収集のためにCookie（クッキー）を使用しますが、このデータは匿名で収集されており、個人を特定するものではありません。Google アナリティクスのデータ収集・利用については、<a href="https://policies.google.com/privacy" target="_blank" style={{color: '#ff69b2'}}>Googleのプライバシーポリシー</a>をご確認ください。</p>
              <h3>外部リンクについて</h3>
              <p>当サイトには外部サイトへのリンクが含まれています。リンク先のサイトのプライバシーポリシーや内容については、当サイトでは責任を負いかねます。</p>
              <h3>免責事項</h3>
              <p>当サイトのクイズ内容や歌割り情報は、可能な限り正確を期しておりますが、その正確性や安全性を保証するものではありません。当サイトの利用により生じた損害等の一切の責任を負いかねますのでご了承ください。</p>
              <h3>著作権・肖像権</h3>
              <p>当サイトはファン活動の一環として運営されており、使用している歌詞やグループに関する権利は各権利所有者に帰属します。著作権の侵害を目的としたものではありません。万が一問題がある場合は、お手数ですがアンケートフォーム等よりご連絡ください。速やかに対応いたします。</p>
              <h3>プライバシーポリシーの変更について</h3>
              <p>本ポリシーの内容は、必要に応じて変更する場合があります。変更後のポリシーは、当サイト上に掲載した時点で効力を生じるものとします。</p>
            </div>
            <button className="modal-close-btn" onClick={closePolicy}>とじる</button>
          </div>
        </div>
      )}
      {showProfile && (
        <div className={`modal-overlay${closingProfile ? ' closing' : ''}`} onClick={closeProfile}>
          <div className="modal-content" onClick={e => e.stopPropagation()}>
            <h2>運営者情報</h2>
            <div className="modal-body">
              <h3>ご挨拶</h3>
              <p>みなさまはじめまして。<br />むちゅむちゅおゆいと申します。</p>
              <p>この度「KAWAII LAB.歌割検定」サイトを作成させていただきました。</p>
              <p>本サイトを作ろうと思ったきっかけは、仕事中に職場の同僚と社内チャットで「この歌詞だれが歌ってるでしょうか？」と、仕事をせずクイズを出し合ってたのが大変おもしろく、なんとなく生成AIに、そんなサイトを作れるか聞いてみたのが、事の発端です。</p>
              <p>どなたでも無料でお遊びいただけます。多くのユーザーに楽しんでほしいと思っておりますので、どうか皆様、SNSなどで広めていただけますと幸いです。<br />（広告等一切ありませんので、私には一銭も入りません）</p>
              <p>何卒よろしくお願い申し上げます。</p>
              <h3>運営者</h3>
              <p>むちゅむちゅおゆい</p>
              <h3>サイトの目的</h3>
              <p>KAWAII LAB.のグループの楽曲や歌割りをより深く楽しむためのファンサイトです。</p>
              <h3>お問い合わせ</h3>
              <p>ご意見・ご感想、掲載情報の誤り等は、以下のアンケートフォームよりご連絡ください。</p>
              <p><a href="https://forms.gle/EguRX6uWZYmJJLZx5" target="_blank" style={{color: '#ff69b2'}}>アンケートフォーム</a></p>
            </div>
            <button className="modal-close-btn" onClick={closeProfile}>とじる</button>
          </div>
        </div>
      )}

      {/* --- デバッグパネル (URL: ?debug) --- */}
      {debugMode && (
        <div className="debug-panel">
          {debugPanelOpen && <><div className="debug-header">🛠 Debug Mode</div>

          <div className="debug-section">
            <div className="debug-label">グループ</div>
            <div className="debug-btn-group">
              {debugGroups.map(g => (
                <button key={g}
                  className={`debug-btn ${debugGroup === g ? 'on' : ''}`}
                  onClick={() => setDebugGroup(g)}
                >{g}</button>
              ))}
            </div>
          </div>

          <div className="debug-section">
            <div className="debug-label">難易度</div>
            <div className="debug-btn-group">
              {debugDiffs.map(d => (
                <button key={d}
                  className={`debug-btn ${debugDiff === d ? 'on' : ''}`}
                  onClick={() => setDebugDiff(d)}
                >{difficultyLabel[d]}</button>
              ))}
            </div>
          </div>

          <div className="debug-section">
            <div className="debug-label">正解数: <strong>{debugScore}</strong> / 10</div>
            <input className="debug-slider" type="range" min="0" max="10"
              value={debugScore}
              onChange={e => setDebugScore(Number(e.target.value))}
            />
          </div>

          <button className="debug-jump-btn" onClick={() => {
            setQuizState(p => ({ ...p, group: debugGroup, difficulty: debugDiff, correctCount: debugScore }));
            setDisplayScore(debugScore);
            setScreen('result');
          }}>▶ リザルト画面へジャンプ</button>

          <div className="debug-section" style={{marginTop: '10px', borderTop: '1px solid #333', paddingTop: '8px'}}>
            <div className="debug-label" style={{color:'#81c784'}}>▶ エンドレス専用</div>
            <div className="debug-label" style={{marginTop:'6px'}}>問題番号セット <span style={{color:'#aaa', fontSize:'0.7rem'}}>(現在: {endlessQNum})</span></div>
            <div className="debug-btn-group">
              {[10, 20, 35, 50, 70].map(v => (
                <button key={v}
                  className={`debug-btn ${endlessQNum === v ? 'on' : ''}`}
                  onClick={() => setEndlessQNum(v)}>{v}</button>
              ))}
            </div>
            <div className="debug-label" style={{marginTop:'6px'}}>ライフ <span style={{color:'#aaa', fontSize:'0.7rem'}}>(現在: {endlessLives})</span></div>
            <button className="debug-jump-btn" style={{marginTop:'4px'}} onClick={() => setEndlessLives(v => v + 100)}>♥ +100</button>
            <div className="debug-label" style={{marginTop:'6px'}}>連続正解セット <span style={{color:'#aaa', fontSize:'0.7rem'}}>(現在: {endlessConsecutive})</span></div>
            <div className="debug-btn-group">
              {[4, 9, 14, 19, 24].map(v => (
                <button key={v}
                  className={`debug-btn ${endlessConsecutive === v ? 'on' : ''}`}
                  onClick={() => setEndlessConsecutive(v)}>{v}</button>
              ))}
            </div>
            <div className="debug-label" style={{marginTop:'6px'}}>正解数セット <span style={{color:'#aaa', fontSize:'0.7rem'}}>(現在: {quizState.correctCount})</span></div>
            <div style={{display:'flex', gap:'6px', alignItems:'center'}}>
              <input
                className="debug-id-input"
                type="number" min="0"
                placeholder="正解数"
                style={{width:'80px'}}
                onKeyDown={e => { if (e.key === 'Enter') setQuizState(p => ({...p, correctCount: Number(e.target.value)})); }}
                onChange={e => {}}
              />
              <button className="debug-jump-btn" style={{marginTop:0}} onClick={e => {
                const val = Number(e.currentTarget.previousElementSibling.value);
                setQuizState(p => ({...p, correctCount: val}));
              }}>セット</button>
            </div>
          </div>

          <div className="debug-section" style={{marginTop: '10px'}}>
            <div className="debug-label">クイズID指定</div>
            <input
              className="debug-id-input"
              type="number"
              placeholder="quizzes.id"
              value={debugQuizId}
              onChange={e => { setDebugQuizId(e.target.value); setDebugQuizStatus(''); }}
            />
            <button className="debug-jump-btn" style={{marginTop: '6px'}} onClick={async () => {
              if (!debugQuizId) return;
              setDebugQuizStatus('取得中…');
              const { data: qData, error } = await supabase.from('quiz_full_dev').select('*').eq('id', Number(debugQuizId)).single();
              if (error || !qData) { setDebugQuizStatus('❌ 見つかりません'); return; }
              const { data: mData } = await supabase.from('members').select('*').eq('group_name', qData.group_name).order('sort_order');
              setMembers(mData || []);
              setQuizState(p => ({ ...p, group: qData.group_name, difficulty: debugDiff, quizzes: [addSurrounds(qData)], currentIndex: 0, correctCount: 0 }));
              setSelectedMembers(new Set());
              setAnswered(false);
              setResultMsg({ text: '', type: '' });
              setDebugQuizStatus(`✅ ID:${qData.id} / ${qData.song_name}`);
              if (qData.sounds_id) await fetchSongLyrics(qData.sounds_id);
              setGameMode('normal');
              setShowFullLyrics(false);
              setScrollAnimPhase('scrolling');
              setQuizPhase('announce');
              setScreen('quiz');
            }}>▶ このクイズをテスト</button>
            {debugQuizStatus && <div style={{marginTop: '4px', fontSize: '0.65rem', color: '#aaa', wordBreak: 'break-all'}}>{debugQuizStatus}</div>}
          </div>

          <div className="debug-section" style={{marginTop: '10px', borderTop: '1px solid #333', paddingTop: '8px'}}>
            <div className="debug-label" style={{color:'#f48fb1'}}>▶ エンドレス解放テスト</div>
            <div className="debug-label" style={{marginTop:'6px', fontSize:'0.65rem', color:'#aaa'}}>解放済み: {[...endlessUnlockedGroups].join(', ') || 'なし'}</div>
            <div className="debug-btn-group" style={{marginTop:'6px'}}>
              {['FRUITS ZIPPER','CANDY TUNE','SWEET STEADY','CUTIE STREET','MORE STAR'].map(g => (
                <button key={g} className="debug-btn" onClick={() => {
                  setEndlessUnlockedGroups(prev => {
                    const next = new Set(prev);
                    next.add(g);
                    localStorage.setItem('kawaii_endless_unlocked_groups', JSON.stringify([...next]));
                    const pending = JSON.parse(localStorage.getItem('kawaii_endless_pending_unlocks') || '[]');
                    if (!pending.includes(g)) {
                      pending.push(g);
                      localStorage.setItem('kawaii_endless_pending_unlocks', JSON.stringify(pending));
                    }
                    localStorage.setItem('kawaii_endless_first_unlock', 'true');
                    return next;
                  });
                  setDebugForceHideEndless(false);
                  setScreen('mode');
                }}>{g.split(' ')[0]}</button>
              ))}
            </div>
            <button className="debug-jump-btn" style={{marginTop:'8px'}} onClick={() => {
              setEndlessUnlockedGroups(new Set());
              setDebugForceHideEndless(true);
              setScreen('mode');
            }}>👁 ボタンを隠す（state のみ）</button>
            <button className="debug-jump-btn" style={{marginTop:'6px', background:'#555'}} onClick={() => {
              setEndlessUnlockedGroups(new Set());
              localStorage.removeItem('kawaii_endless_unlocked_groups');
              localStorage.removeItem('kawaii_endless_pending_unlocks');
              localStorage.removeItem('kawaii_endless_first_unlock');
            }}>🗑 解放リセット（localStorage も）</button>
          </div>

          <div className="debug-section" style={{marginTop: '10px', borderTop: '1px solid #333', paddingTop: '8px'}}>
            <div className="debug-label" style={{color:'#90caf9'}}>▶ カスタム解放テスト</div>
            <div className="debug-label" style={{marginTop:'6px', fontSize:'0.65rem', color:'#aaa'}}>
              プレイ回数: {localStorage.getItem('kawaii_normal_play_count') || '0'} / 5　解放: {customUnlocked ? '✅' : '❌'}
            </div>
            <button className="debug-jump-btn" style={{marginTop:'6px'}} onClick={() => {
              localStorage.setItem('kawaii_custom_unlocked', 'true');
              localStorage.setItem('kawaii_custom_new_unlock', 'true');
              setCustomUnlocked(true);
              setDebugForceHideCustom(false);
              setPendingCustomReveal(false);
              setScreen('mode');
            }}>🎵 カスタム解放 + 通知確認</button>
            <button className="debug-jump-btn" style={{marginTop:'6px'}} onClick={() => {
              setCustomUnlocked(false);
              setDebugForceHideCustom(true);
              setScreen('mode');
            }}>👁 ボタンを隠す（state のみ）</button>
            <button className="debug-jump-btn" style={{marginTop:'6px', background:'#555'}} onClick={() => {
              setCustomUnlocked(false);
              localStorage.removeItem('kawaii_custom_unlocked');
              localStorage.removeItem('kawaii_custom_new_unlock');
              localStorage.removeItem('kawaii_normal_play_count');
            }}>🗑 解放リセット（localStorage も）</button>
          </div>
          </>}
          <button className="debug-toggle-btn" onClick={() => setDebugPanelOpen(p => !p)}>
            {debugPanelOpen ? '▼ パネルを隠す' : '▲ デバッグパネル'}
          </button>
        </div>
      )}
    </div>
  );
}

export default App;