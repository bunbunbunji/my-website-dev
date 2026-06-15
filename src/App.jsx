import { useState, useEffect, useLayoutEffect, useRef } from 'react'
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

const renderLyricsWithOccurrence = (lyrics, occurrence) => {
  if (!lyrics) return null;
  const lines = lyrics.split('\n');
  if (!occurrence || !Array.isArray(occurrence) || occurrence.every(o => o == null)) {
    return lyrics;
  }
  const result = [];
  lines.forEach((line, i) => {
    if (i > 0) result.push('\n');
    result.push(line);
    const occ = occurrence[i];
    if (occ != null) result.push(<span key={i} className="occurrence-badge">（{occ}回目）</span>);
  });
  return result;
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
  const [endlessLifeBonus, setEndlessLifeBonus] = useState({ type: 'none', amount: 0, key: 0 });
  const [endlessDiffNotif, setEndlessDiffNotif] = useState({ text: '', tier: '', key: 0 });
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
  const [customShowSurround, setCustomShowSurround] = useState(false);
  const [customShowSongName, setCustomShowSongName] = useState(false);

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

  const openSongModal = async (title, groupName) => {
    setSongModal({ title, groupName });
    setSongModalData([]);
    setSongModalMembers([]);
    setIsLoadingSongModal(true);
    const { data } = await supabase
      .from('quiz_full')
      .select('lyrics, correct_members, seq, section_name, easy, normal, hard, expert')
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
  const hintPrevRef = useRef(null);
  const hintNextRef = useRef(null);
  const commentRef = useRef(null);
  const rankRef = useRef(null);
  const descTextRef = useRef(null);
  const catchText1Ref = useRef(null);
  const catchText2Ref = useRef(null);
  const listBtnRef = useRef(null);


  const debugMode = new URLSearchParams(window.location.search).has('debug');
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
      return try_(q => (q.normal > 0 || q.hard > 0) && !/回目/.test(q.lyrics)) || try_(q => q.normal > 0 || q.hard > 0) || try_(q => q.expert > 0) || pool;
    if (qNum <= 70)
      return try_(q => q.hard > 0) || try_(q => q.normal > 0) || try_(q => q.expert > 0) || pool;
    return try_(q => q.hard > 0 || q.expert > 0) || try_(q => q.normal > 0) || pool;
  };

  const selectEndlessWeighted = (eligible) => {
    return eligible[Math.floor(Math.random() * eligible.length)];
  };

  const prefetchEndlessNext = (pool, nextQNum) => {
    const eligible = getEndlessEligiblePool(pool, nextQNum);
    if (!eligible || eligible.length === 0) { setEndlessNextQ(null); setEndlessNextQLoading(false); return; }
    const selected = selectEndlessWeighted(eligible, nextQNum);
    const newPool = pool.filter(q => q.id !== selected.id);
    endlessPoolRef.current = newPool;
    setEndlessNextQLoading(true);
    fetchSurrounds([selected]).then(([q]) => { setEndlessNextQ(q); setEndlessNextQLoading(false); });
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
      const { data } = await supabase.from('quiz_full').select('group_name, song_name').in('group_name', groups).range(from, from + 999);
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
    let from = 0;
    let hasMore = true;
    while (hasMore) {
      const { data } = await supabase.from('quiz_full').select('*').in('group_name', groups).range(from, from + 999);
      if (!data || data.length === 0) { hasMore = false; }
      else { qData = [...qData, ...data]; from += 1000; if (data.length < 1000) hasMore = false; }
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
    const shuffled = shuffle(filtered);
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
    setScreen('quiz');
  };

  const nextCustomQuestion = (isSkip = false) => {
    const queue = customQueueRef.current;
    const newQueue = isSkip ? [...queue.slice(1), queue[0]] : queue.slice(1);
    customQueueRef.current = newQueue;
    if (newQueue.length === 0) { customResultReadyRef.current = false; setCustomAnsweredTotal(customTotalQ); setScreen('result'); return; }
    setCustomRemaining(newQueue.length);
    setQuizState(prev => ({ ...prev, quizzes: [newQueue[0]], currentIndex: 0 }));
    setSelectedMembers(new Set());
    setAnswered(false);
    setResultMsg({ text: '', type: '' });
    setCustomShowSurround(false);
    setCustomShowSongName(false);
    window.scrollTo({ top: 0, behavior: 'smooth' });
  };

  const restartCustomMode = () => {
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
    setScreen('quiz');
  };


  const descriptions = {
    easy:   ["有名な曲の特徴的な歌詞が選出されます","1人で歌う歌詞が選出されます", "ヒントとして曲名と前後の歌詞が表示されます"],
    normal: ["MVがある曲の歌詞が選出されます","1人で歌う歌詞が選出されます", "ヒントとして前後の歌詞が表示されます"],
    hard:   ["すべての曲の歌詞から選出されます","1人または全員で歌う歌詞が選出されます", "曲中で繰り返し使われる歌詞も登場します", "ヒントはありません"],
    expert: ["すべての曲の歌詞から選出されます","2人以上で歌う歌詞が選出されます", "曲中で繰り返し使われる歌詞も登場します","ヒントはありません"],
  };

  const resultMessages = {
    easy: { zero: "え…？やる気ある...？<br>1つも当たらないのはある意味すごいかも。w", low: "本当にちゃんと聴いてるの…？<br>まずは曲をしっかり聴き込みましょう。", mid: "こんなんじゃまだまだ聴いたとは言えない！<br>「やさしい」なら全問正解を目指したいところ！", high: "初心者なら及第点！<br>次は全問正解に挑戦だ！", perfect: "全問正解！ナイスです！<br>「やさしい」はもう余裕かな？次の難易度にレッツゴー！" },
    normal: { zero: "全滅…だと…！？<br>泣きたい気持ちを抑えて、もう1回チャレンジ！", low: "まだまだ聴き込み不足！<br>曲をたくさん聴いて耳を鍛えよう。", mid: "まずまずの結果です。<br>さらに聴き込めばもっと正解できるはず！", high: "素晴らしい！<br>そろそろファンを名乗ってもいいかもね？", perfect: "全問正解！よくできました！<br>素晴らしい結果です！次は「むずかしい」に挑戦だ！" },
    hard: { zero: "全問不正解…。<br>「むずかしい」の壁はかなり高かったようだ。", low: "この難易度はまだ早かったかも…？<br>でも挑戦する姿勢は最高にかっこいいぜ。", mid: "大健闘！<br>「むずかしい」でこれだけ解ければ相当なもの。", high: "すごい！よくここまで正解できましたね！<br>全問正解までもうちょっと。もう一回チャレンジだ！", perfect: "全問正解！コングラッチュレーション！！<br>この難易度で満点はもはや職人の域ですな！" },
    expert: { zero: "へんじがない。ただのしかばねのようだ。<br>0点でも泣かないで。当てる方がおかしいレベルですから。", low: "相手が悪すぎた…。<br>一筋縄ではいかないね。ドンマイドンマイ！", mid: "素晴らしい！<br>この難問揃いで半分解けるとは、なかなかやるな？", high: "素晴らしすぎて鳥肌ものです。<br>もしかしたら本人よりも詳しいかも…！？", perfect: "👼⛩️✨神、降臨✨⛩️👼。<br>あなたは一体何者…？まさか本人？？" }
  };

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
      setScreen('quiz');
      return;
    }
    // 検定モード・カスタムモード: セッション不要
    setSelectedMembers(new Set());
    setPendingResume(null);
    setScreen('quiz');
  };

  // --- エンドレスセッション復元 ---
  const resumeQuiz = async () => {
    setIsResumingSession(true);
    const s = pendingResume;
    const saved = s.quiz_ids; // { current, pool, lives, consecutive }

    // 現在の問題と残プールを取得
    const { data: qData } = await supabase.from('quiz_full').select('*').eq('id', saved.current).single();
    const { data: mData } = await supabase.from('members').select('*').eq('group_name', s.group_name).order('sort_order');
    let poolData = [];
    if (saved.pool?.length > 0) {
      const { data: pData } = await supabase.from('quiz_full').select('*').in('id', saved.pool);
      poolData = pData || [];
    }
    const [q1] = await fetchSurrounds([qData]);

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
    setEndlessDiffNotif({ text: '', tier: '', key: 0 });
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
    setScreen('quiz');
    prefetchEndlessNext(poolData, qNum + 1);
  };

  // --- セッション破棄 ---
  const discardSession = () => {
    supabase.from('sessions').delete().eq('session_id', pendingResume.session_id).then(() => {});
    localStorage.removeItem('quiz_session_id');
    setPendingResume(null);
  };

  // --- 前後歌詞をクイズオブジェクトに埋め込む ---
  const fetchSurrounds = async (quizzes) => {
    return Promise.all(quizzes.map(async (quiz) => {
      const [prevRes, nextRes] = await Promise.all([
        supabase.from('lyrics').select('lyric')
          .eq('sounds_id', quiz.sounds_id)
          .lt('seq', quiz.seq).order('seq', { ascending: false }).limit(2),
        supabase.from('lyrics').select('lyric')
          .eq('sounds_id', quiz.sounds_id)
          .gt('seq', quiz.seq).order('seq', { ascending: true }).limit(2)
      ]);
      return {
        ...quiz,
        surroundPrev: ((prevRes.data || []).reverse()).map(r => r.lyric),
        surroundNext: (nextRes.data || []).map(r => r.lyric)
      };
    }));
  };

  // --- カスタムモード: 現在の問題の前後歌詞をオンデマンドでフェッチ ---
  const fetchCurrentCustomSurrounds = async () => {
    const curr = quizState.quizzes[quizState.currentIndex];
    if (!curr || curr.surroundPrev !== undefined) return;
    const [withSurrounds] = await fetchSurrounds([curr]);
    setQuizState(prev => {
      const quizzes = [...prev.quizzes];
      quizzes[prev.currentIndex] = withSurrounds;
      return { ...prev, quizzes };
    });
  };

  // --- クイズ準備 ---
  const prepareQuiz = async (selectedGroup, selectedDiff) => {
    setIsPreparing(true);
    setStatusMsg("問題を準備しています…");
    const { data: qData } = await supabase.from("quiz_full").select("*").eq("group_name", selectedGroup).gt(selectedDiff, 0);
    const { data: mData } = await supabase.from("members").select("*").eq("group_name", selectedGroup).order("sort_order");

    if (!qData || qData.length === 0) {
      setStatusMsg("問題が見つかりませんでした");
      setIsPreparing(false);
      return;
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
    const quizzesWithSurrounds = await fetchSurrounds(selectedQuizzes);
    setQuizState(prev => ({ ...prev, quizzes: quizzesWithSurrounds, currentIndex: 0, correctCount: 0 }));
    setMembers(mData || []);
    setStatusMsg(`${quizzesWithSurrounds.length}問のクイズを用意しました！`);
    setIsPreparing(false);
  };

  // --- エンドレスモード準備（全問メタデータ取得 + Q1先読み） ---
  const prepareEndlessMode = async (selectedGroup) => {
    setIsPreparing(true);
    setEndlessNextQ(null);
    setEndlessNextQLoading(false);
    setStatusMsg("問題を準備しています…");
    const { data: mData } = await supabase.from("members").select("*").eq("group_name", selectedGroup).order("sort_order");
    let qData = [];
    let from = 0;
    let hasMore = true;
    while (hasMore) {
      const { data } = await supabase.from("quiz_full").select("*").eq("group_name", selectedGroup).range(from, from + 999);
      if (!data || data.length === 0) { hasMore = false; }
      else { qData = [...qData, ...data]; from += 1000; if (data.length < 1000) hasMore = false; }
    }
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
    const q1Meta = selectEndlessWeighted(eligible1, 1);
    pool = pool.filter(q => q.id !== q1Meta.id);
    const [q1] = await fetchSurrounds([q1Meta]);
    // 状態を初期化
    endlessPoolRef.current = pool;
    endlessPendingNotifRef.current = null;
    setEndlessQNum(1);
    setEndlessLives(3);
    setEndlessConsecutive(0);
    setEndlessIsOver(false);
    setEndlessLifeBonus({ type: 'none', amount: 0, key: 0 });
    setEndlessDiffNotif({ text: '', tier: '', key: 0 });
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
          .from('quiz_full')
          .select('group_name, song_name, easy, normal')
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
      const easySongsSet = new Set();
      const normalSongsSet = new Set();

      allQuizData.forEach(q => {
        if (q.song_name) {
          const norm = superNormalize(q.song_name);
          activeSongsSet.add(norm);
          if (Number(q.easy) >= 0.1) easySongsSet.add(norm);
          if (Number(q.normal) >= 0.1) normalSongsSet.add(norm);
        }
      });

      const finalData = [];
      for (const group of groups) {
        const { data: songs } = await supabase
          .from('sounds')
          .select('song_name')
          .eq('group_name', group.name)
          .order('song_name', { ascending: true });
        if (songs) {
          const processedSongs = songs.map(s => {
            const norm = superNormalize(s.song_name);
            return {
              title: s.song_name,
              hasQuiz: activeSongsSet.has(norm),
              isEasy: easySongsSet.has(norm),
              isNormal: normalSongsSet.has(norm)
            };
          });
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

    const formatCorrectLabel = (members, allFlag) => {
      if (String(allFlag) === '1') return '全員';
      if (members.length < 3) return members.join('・');
      const pairs = [];
      for (let i = 0; i < members.length; i += 2) {
        pairs.push(members.slice(i, i + 2).join('・'));
      }
      return pairs.join('<br>');
    };
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
        setCustomWrongAnswers(prev => [...prev, { lyrics: current.lyrics, song_name: current.song_name, correct_members: current.correct_members, group_name: current.group_name }]);
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

  const nextQuestion = () => {
    if (gameMode === 'endless') { advanceEndlessQuestion(); return; }
    if (gameMode === 'custom') { nextCustomQuestion(); return; }
    setQuestionTimer(60);
    setQuizState(prev => {
      if (prev.currentIndex + 1 < prev.quizzes.length) {
        return { ...prev, currentIndex: prev.currentIndex + 1 };
      }
      setScreen('result');
      return prev;
    });
    setSelectedMembers(new Set());
    setAnswered(false);
    setResultMsg({ text: "", type: "" });
    window.scrollTo({ top: 0, behavior: "smooth" });
  };

  const advanceEndlessQuestion = () => {
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
    const DIFF_THRESHOLDS = {
      11: { text: '難易度UP！',   desc: '問題が難しくなります！' },
      21: { text: '難易度UP！',   desc: '曲名が隠れます！' },
      36: { text: '難易度UP！',   desc: '問題が難しくなります！' },
      51: { text: '難易度UP！',   desc: '前後の歌詞が隠れます！' },
      71: { text: '難易度MAX！！', desc: '問題が難しくなります！' },
    };
    if (DIFF_THRESHOLDS[newQNum]) setEndlessDiffNotif({ ...DIFF_THRESHOLDS[newQNum], key: Date.now() });
    else setEndlessDiffNotif({ text: '', desc: '', key: 0 });
    setEndlessQNum(newQNum);
    setQuizState(prev => ({ ...prev, quizzes: [endlessNextQ], currentIndex: 0 }));
    setEndlessNextQ(null);
    setAnswered(false);
    setSelectedMembers(new Set());
    setResultMsg({ text: "", type: "" });
    window.scrollTo({ top: 0, behavior: "smooth" });
    // セッション更新（次の問題・残プール・ライフ等を保存）
    if (sessionId) {
      supabase.from('sessions').update({
        current_step: newQNum,
        correct_count: quizState.correctCount,
        quiz_ids: {
          current: endlessNextQ.id,
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
    if (screen !== 'quiz' || gameMode !== 'normal') return;
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
  }, [quizState.currentIndex, screen, gameMode]);

  // --- タブ復帰時にタイマーを即時補正 ---
  useEffect(() => {
    if (screen !== 'quiz' || gameMode !== 'normal' || answered) return;
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
  }, [screen, gameMode, answered]);

  // --- 検定モード：タイムアップ → 強制不正解 ---
  useEffect(() => {
    if (gameMode !== 'normal' || screen !== 'quiz' || answered) return;
    if (questionTimer === 0) {
      clearInterval(questionTimerIntervalRef.current);
      const curr = quizState.quizzes[quizState.currentIndex];
      const correctArr = (curr?.correct_members || '').split(',').map(s => s.trim()).filter(Boolean);
      setResultMsg({
        text: `<span style="font-size:1.15em">⏱️ 時間切れ！😢</span><br><span style="font-size:0.8em">( 正解：${correctArr.join('・')} )</span>`,
        type: "incorrect"
      });
      setAnswered(true);
      setTimeout(() => window.scrollTo({ top: document.body.scrollHeight, behavior: "smooth" }), 100);
    }
  }, [questionTimer, gameMode, screen, answered]);

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
    const NO_SCROLL_SCREENS = ['top', 'lyrics', 'mode', 'group', 'difficulty', 'confirm', 'custom-select-group', 'custom-select-song'];
    const html = document.documentElement;
    if (NO_SCROLL_SCREENS.includes(screen)) {
      html.classList.add('no-scroll');
    } else {
      html.classList.remove('no-scroll');
    }
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
      fitText(hintPrevRef.current, 0.62, 3);
      fitText(hintNextRef.current, 0.62, 3);
    };
    fitAll();
    document.fonts.ready.then(fitAll);
  }, [screen, quizState.currentIndex, quizState.quizzes]);

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

  const toggleMember = (name) => {
    if (answered) return;
    const newSet = new Set(selectedMembers);
    newSet.has(name) ? newSet.delete(name) : newSet.add(name);
    setSelectedMembers(newSet);
  };

  const quizCurr = quizState.quizzes[quizState.currentIndex];
  const sp = quizCurr?.surroundPrev || [];
  const sn = quizCurr?.surroundNext || [];
  const showSongName = gameMode === 'custom'
    ? customShowSongName
    : gameMode === 'endless' ? endlessQNum <= 20 : quizState.difficulty === 'easy';
  const showSurroundHint = gameMode === 'custom'
    ? customShowSurround
    : gameMode === 'endless' ? endlessQNum <= 50 : (quizState.difficulty === 'easy' || quizState.difficulty === 'normal' || answered);
  const quizPrevLines = showSurroundHint ? sp.slice(-1) : [];
  const quizNextLines = showSurroundHint ? sn.slice(0, 1) : [];
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
            掲載している歌詞と歌割りは、KAWAII LAB公式から正式に歌詞・歌割りが発表されている曲を除き、運営者が独自調査したものです。実際と異なる可能性は往々にしてございますので、ご了承ください。</p>
            <p><strong>難易度設定について</strong><br />
            主に運営者の<strong>匙加減</strong>で決めています。価値観が異なる場合もあると思いますがこれもご了承ください。</p>
            <p><strong>楽曲構成の定義について</strong><br />
            回答の際に公開される、いわゆる「Aメロ」「サビ」のことですが、運営者の<strong>匙加減</strong>で決めています。作曲者様の意図しない構成になっている可能性がありますのでご理解ください。</p>
            <p><strong>匙加減について</strong><br />
            そんな感じでこのサイトの全てが私の<strong>匙加減</strong>で設計されていますので、とりあえず全部ご了承ください。</p>
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
        {(screen === 'top' || screen === 'result' || screen === 'custom-review') && (
          <a href="https://forms.gle/EguRX6uWZYmJJLZx5" target="_blank" rel="noreferrer" className="survey-corner-link">アンケートにご協力ください</a>
        )}
      </div>
      <div className="legal-links">
        <span onClick={() => setShowPolicy(true)}>プライバシーポリシー</span>
        <span onClick={() => setShowProfile(true)}>運営者情報</span>
      </div>

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
                    if (tooltipLevel) return;
                    setQuizState(prev => ({...prev, difficulty: level}));
                    setScreen('confirm');
                    prepareQuiz(quizState.group, level);
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
          <button className="start-btn" disabled={isPreparing || quizState.quizzes.length === 0} onClick={startQuiz}>クイズを始める！</button>
          <button className="back-btn" onClick={() => setScreen(gameMode === 'endless' ? 'group' : 'difficulty')}>
            {gameMode === 'endless' ? 'グループ選択に戻る' : '難易度選択に戻る'}
          </button>
        </div>
      )}

      {/* --- クイズ画面 --- */}
      {screen === 'quiz' && (
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
          <h2 className="title quiz-title">だれが歌ってる？</h2>

          {showSongName && quizCurr?.song_name && (
            <div className="song-name-hint">
              <span className="song-name-hint-label">ヒント：</span>
              <span className="song-name-hint-badge">{quizCurr.song_name}</span>
            </div>
          )}

          {quizPrevLines.length > 0 && (
            <div className="hint-lyrics">
              <span className="hint-label">直前の歌詞：</span>
              <div className="hint-text" ref={hintPrevRef}>{quizPrevLines.join('\n')}</div>
            </div>
          )}

          <p id="lyrics" ref={lyricsRef}>{renderLyricsWithOccurrence(quizCurr?.lyrics, quizCurr?.occurrence)}</p>

          {quizNextLines.length > 0 && (
            <div className="hint-lyrics">
              <span className="hint-label">直後の歌詞：</span>
              <div className="hint-text" ref={hintNextRef}>{quizNextLines.join('\n')}</div>
            </div>
          )}

          {gameMode === 'custom' && !answered && (
            <div className="custom-hint-buttons">
              <button className={`custom-hint-btn${customShowSurround ? ' active' : ''}`} onClick={async () => {
                if (!customShowSurround) await fetchCurrentCustomSurrounds();
                setCustomShowSurround(v => !v);
              }}>
                {customShowSurround ? '前後の歌詞を隠す' : '前後の歌詞をみる'}
              </button>
              <button className={`custom-hint-btn${customShowSongName ? ' active' : ''}`} onClick={() => setCustomShowSongName(v => !v)}>
                {customShowSongName ? '曲名を隠す' : '曲名をみる'}
              </button>
            </div>
          )}

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
              disabled={gameMode === 'endless' && endlessNextQLoading}
            >
              {gameMode === 'endless' && endlessNextQLoading ? '読み込み中…' : '次の問題へ'}
            </button>
          )}
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

      {/* --- 難易度UPオーバーレイ --- */}
      {screen === 'quiz' && gameMode === 'endless' && endlessDiffNotif.text && (
        <div key={endlessDiffNotif.key} className="endless-diffup-overlay">
          <div className={`endless-diffup-card${endlessDiffNotif.text === '難易度MAX！！' ? ' endless-diffup-max' : ''}`}>
            <div className="endless-diffup-label">{endlessDiffNotif.text}</div>
            {endlessDiffNotif.desc && <div className="endless-diffup-desc">{endlessDiffNotif.desc}</div>}
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
            <p style={{color: '#888', fontSize: '0.85rem', marginBottom: '20px'}}>現在の正解数でリザルトを表示します</p>
            <button className="resume-continue-btn" onClick={() => { setCustomQuitModal(false); customResultReadyRef.current = false; setCustomAnsweredTotal(customTotalQ - customRemaining); setScreen('result'); }}>はい</button>
            <br />
            <button className="resume-discard-btn" style={{marginTop: '12px'}} onClick={() => setCustomQuitModal(false)}>いいえ</button>
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
                    <div className="custom-review-lyrics">{w.lyrics}</div>
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
              <button className="retry-btn" onClick={() => { setScreen('confirm'); prepareQuiz(quizState.group, quizState.difficulty); setAnswered(false); setQuizState(p=>({...p, correctCount:0, currentIndex:0})); setSelectedMembers(new Set()); }}>もう一回！</button>
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
        return (
          <div className={`modal-overlay${closingSongModal ? ' closing' : ''}`} onClick={closeSongModal}>
            <div className="modal-content song-lyrics-modal" onClick={e => e.stopPropagation()}>
              <h2>{songModal?.title}</h2>
              <div className="song-modal-group-badge">{songModal?.groupName}</div>
              {isLoadingSongModal ? (
                <div className="song-modal-loading">データを取得中...</div>
              ) : songModalData.length === 0 ? (
                <div className="song-modal-loading">データがありません</div>
              ) : (
                <div className="song-modal-list">
                  {songModalData.map((row, i) => {
                    const correctArr = row.correct_members.split(',').map(s => s.trim()).filter(Boolean);
                    const isAll = correctArr.length === songModalMembers.length && songModalMembers.length > 0;
                    const isSolo = correctArr.length === 1;
                    const lyricsColor = isSolo
                      ? (memberLookup[correctArr[0]]?.color || '#333')
                      : '#000';
                    const memberNameNodes = isAll
                      ? <span>全員</span>
                      : correctArr.map((n, ni) => (
                          <span key={ni} style={{ color: memberLookup[n]?.color || '#333' }}>
                            {ni > 0 && <span style={{ color: '#333' }}>・</span>}
                            {memberLookup[n]?.lastName || n}
                          </span>
                        ));
                    return (
                      <div key={i} className="song-modal-row">
                        <div className="song-modal-lyrics" style={{ color: lyricsColor, whiteSpace: 'pre-wrap' }}>{row.lyrics}</div>
                        <div className="song-modal-members">🎤 {memberNameNodes}</div>
                        <div className="diff-dots">
                          {Number(row.easy)   > 0 && <span className="diff-dot diff-dot-easy"   title="やさしい" />}
                          {Number(row.normal) > 0 && <span className="diff-dot diff-dot-normal" title="ふつう" />}
                          {Number(row.hard)   > 0 && <span className="diff-dot diff-dot-hard"   title="むずかしい" />}
                          {Number(row.expert) > 0 && <span className="diff-dot diff-dot-expert" title="げきむず" />}
                        </div>
                      </div>
                    );
                  })}
                </div>
              )}
              <button className="modal-close-btn" onClick={closeSongModal}>とじる</button>
            </div>
          </div>
        );
      })()}

      {/* --- 検定モード トップ戻り確認モーダル --- */}
      {showBackConfirm && (
        <div className="modal-overlay" onClick={() => setShowBackConfirm(false)}>
          <div className="modal-content" onClick={e => e.stopPropagation()} style={{textAlign: 'center'}}>
            <h2>⚠️ トップに戻りますか？</h2>
            <p style={{marginBottom: '20px'}}>検定モードはセッションが残りません！<br />本当に戻りますか？</p>
            <button className="resume-continue-btn" onClick={() => {
              setShowBackConfirm(false);
              clearInterval(questionTimerIntervalRef.current);
              setScreen('top');
            }}>トップに戻る</button>
            <br />
            <button className="resume-discard-btn" style={{marginTop: '12px'}} onClick={() => setShowBackConfirm(false)}>
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
            <p style={{marginBottom: '20px'}}>{pendingResume.current_step}問目から再開できます</p>
            <button className="resume-continue-btn" onClick={() => { closeResumeModal(); resumeQuiz(); }} disabled={isResumingSession}>
              {isResumingSession ? '読み込み中…' : '▶ 続きから始める'}
            </button>
            <br />
            <button className="resume-discard-btn" style={{marginTop: '12px'}} onClick={() => { closeResumeModal(); discardSession(); if (resumeModalSource === 'songlist') fetchSongList(); else setScreen('group'); }}>
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
            <h3>広告の配信について</h3>
            <p>当サイトでは、第三者配信の広告サービス「Google アドセンス」を利用しています。</p>
            <p>広告配信事業者は、ユーザーの興味に応じた広告を表示するためにCookie（クッキー）を使用することがあります。これにより、当サイトや他サイトへの過去のアクセス情報に基づいた広告が配信されます。</p>
            <p>ユーザーは、Googleの<a href="https://adssettings.google.com/authenticated" target="_blank" style={{color: '#ff69b2'}}>広告設定</a>で、パーソナライズ広告を無効にすることができます。</p>
            <h3>アクセス解析ツールについて</h3>
            <p>当サイトでは、サイトの利用状況を把握するために「Google アナリティクス」を利用する可能性があります。Google アナリティクスはデータの収集のためにCookieを使用しますが、このデータは匿名で収集されており、個人を特定するものではありません。</p>
            <h3>免責事項</h3>
            <p>当サイトのクイズ内容や歌割り情報は、可能な限り正確を期しておりますが、その正確性や安全性を保証するものではありません。当サイトの利用により生じた損害等の一切の責任を負いかねますのでご了承ください。</p>
            <h3>著作権・肖像権</h3>
            <p>当サイトはファン活動の一環として運営されており、使用している歌詞やグループに関する権利は各権利所有者に帰属します。著作権の侵害を目的としたものではありません。万が一問題がある場合は、お手数ですがアンケートフォーム等よりご連絡ください。速やかに対応いたします。</p>
            <button className="modal-close-btn" onClick={closePolicy}>とじる</button>
          </div>
        </div>
      )}
      {showProfile && (
        <div className={`modal-overlay${closingProfile ? ' closing' : ''}`} onClick={closeProfile}>
          <div className="modal-content" onClick={e => e.stopPropagation()}>
            <h2>運営者情報</h2>
            <h3>運営者</h3>
            <p>むちゅむちゅおゆい</p>
            <h3>サイトの目的</h3>
            <p>KAWAII LAB.のグループの楽曲や歌割りをより深く楽しむためのファンサイトです。</p>
            <h3>お問い合わせ</h3>
            <p>ご意見・ご感想、掲載情報の誤り等は、以下のアンケートフォームよりご連絡ください。</p>
            <p><a href="https://forms.gle/EguRX6uWZYmJJLZx5" target="_blank" style={{color: '#ff69b2'}}>アンケートフォーム</a></p>
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
              const { data: qData, error } = await supabase.from('quiz_full').select('*').eq('id', Number(debugQuizId)).single();
              if (error || !qData) { setDebugQuizStatus('❌ 見つかりません'); return; }
              const { data: mData } = await supabase.from('members').select('*').eq('group_name', qData.group_name).order('sort_order');
              const quizzesWithSurrounds = await fetchSurrounds([qData]);
              setMembers(mData || []);
              setQuizState(p => ({ ...p, group: qData.group_name, difficulty: debugDiff, quizzes: quizzesWithSurrounds, currentIndex: 0, correctCount: 0 }));
              setSelectedMembers(new Set());
              setAnswered(false);
              setResultMsg({ text: '', type: '' });
              setDebugQuizStatus(`✅ ID:${qData.id} / ${qData.song_name}`);
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