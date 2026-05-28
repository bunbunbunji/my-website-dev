import { useState, useEffect, useLayoutEffect, useRef } from 'react'
import { createClient } from '@supabase/supabase-js'
import confetti from 'canvas-confetti'
import './App.css'
import logo from './assets/logo.png'

// ===== Supabase 設定 =====
const supabaseUrl = "https://atinpqtedmrfrtdlkpkd.supabase.co";
const supabaseKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImF0aW5wcXRlZG1yZnJ0ZGxrcGtkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjkwOTU0NjcsImV4cCI6MjA4NDY3MTQ2N30.Oor6oUuuIxa0pSxIRuwEw7ZzGYM4hOGfywHqv2FaBHg";
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

function App() {
  const [accessGranted, setAccessGranted] = useState(() =>
    localStorage.getItem('kawaii_access') === import.meta.env.VITE_ACCESS_CODE
  );
  const [accessInput, setAccessInput] = useState('');
  const [accessError, setAccessError] = useState(false);

  const handleAccessSubmit = () => {
    if (accessInput === import.meta.env.VITE_ACCESS_CODE) {
      localStorage.setItem('kawaii_access', import.meta.env.VITE_ACCESS_CODE);
      setAccessGranted(true);
    } else {
      setAccessError(true);
      setAccessInput('');
      setTimeout(() => setAccessError(false), 1800);
    }
  };

  const [screen, setScreen] = useState('top');
  const [showPolicy, setShowPolicy] = useState(false);
  const [showProfile, setShowProfile] = useState(false);
  const [closingPolicy, setClosingPolicy] = useState(false);
  const [closingProfile, setClosingProfile] = useState(false);

  const closePolicy = () => { setClosingPolicy(true); setTimeout(() => { setShowPolicy(false); setClosingPolicy(false); }, 220); };
  const closeProfile = () => { setClosingProfile(true); setTimeout(() => { setShowProfile(false); setClosingProfile(false); }, 220); };
  const [infoLevel, setInfoLevel] = useState(null);
  const [closingInfo, setClosingInfo] = useState(false);
  const [closingResumeModal, setClosingResumeModal] = useState(false);
  const [closingSongModal, setClosingSongModal] = useState(false);

  const closeInfo = () => { setClosingInfo(true); setTimeout(() => { setInfoLevel(null); setClosingInfo(false); }, 220); };
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
  const [endlessUnlocked, setEndlessUnlocked] = useState(localStorage.getItem('kawaii_endless_unlocked') === 'true');
  const [konamiFlash, setKonamiFlash] = useState(false);

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
      return try_(q => q.normal > 0 || q.hard > 0) || try_(q => q.expert > 0) || pool;
    if (qNum <= 70)
      return try_(q => q.hard > 0) || try_(q => q.normal > 0) || try_(q => q.expert > 0) || pool;
    return try_(q => q.hard > 0 || q.expert > 0) || try_(q => q.normal > 0) || pool;
  };

  const selectEndlessWeighted = (eligible, qNum) => {
    const w = (q) => {
      if (qNum <= 10) return q.easy || 0;
      if (qNum <= 20) return (q.easy || 0) + (q.normal || 0);
      if (qNum <= 35) return q.normal || 0;
      if (qNum <= 50) return (q.normal || 0) + (q.hard || 0);
      if (qNum <= 70) return q.hard || 0;
      return (q.hard || 0) + (q.expert || 0);
    };
    const total = eligible.reduce((s, q) => s + w(q), 0);
    if (total === 0) return eligible[Math.floor(Math.random() * eligible.length)];
    let r = Math.random() * total;
    for (const q of eligible) { r -= w(q); if (r <= 0) return q; }
    return eligible[eligible.length - 1];
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

  // --- コナミコマンドでエンドレスモード解放 ---
  useEffect(() => {
    const KONAMI = ['ArrowUp','ArrowUp','ArrowDown','ArrowDown','ArrowLeft','ArrowRight','ArrowLeft','ArrowRight'];
    let pos = 0;
    const onKey = (e) => {
      if (e.key === KONAMI[pos]) {
        pos++;
        if (pos === KONAMI.length) {
          pos = 0;
          localStorage.setItem('kawaii_endless_unlocked', 'true');
          setEndlessUnlocked(true);
          setKonamiFlash(true);
          setTimeout(() => setKonamiFlash(false), 2000);
        }
      } else {
        pos = e.key === KONAMI[0] ? 1 : 0;
      }
    };
    window.addEventListener('keydown', onKey);
    return () => window.removeEventListener('keydown', onKey);
  }, []);

  const descriptions = {
    easy:   ["有名な曲から、1人で歌う特徴的な歌詞が選出されます", "ヒントとして曲名と前後の歌詞が表示されます"],
    normal: ["MVが存在する曲から、1人で歌う歌詞が選出されます", "ヒントとして前後の歌詞が表示されます"],
    hard:   ["すべての曲から、1人または全員で歌う歌詞が選出されます", "繰り返し使われる歌詞", "ヒントはありません"],
    expert: ["すべての曲から、2人以上で歌う歌詞が選出されます", "ヒントはありません"],
  };

  const resultMessages = {
    easy: { zero: "え…？やる気ある...？<br>1つも当たらないのはある意味すごいかも。w", low: "本当にちゃんと聴いてるの…？<br>まずは曲をしっかり聴き込みましょう。", mid: "こんなんじゃまだまだ聴いたとは言えない！<br>「やさしい」なら全問正解を目指したいところ！", high: "初心者なら及第点！<br>次は全問正解に挑戦だ！", perfect: "全問正解！ナイスです！<br>「やさしい」はもう余裕かな？次の難易度にレッツゴー！" },
    normal: { zero: "全滅…だと…！？<br>泣きたい気持ちを抑えて、もう1回チャレンジ！", low: "まだまだ聴き込み不足！<br>曲をたくさん聴いて耳を鍛えよう。", mid: "まずまずの結果です。<br>さらに聴き込めばもっと正解できるはず！", high: "素晴らしい！<br>そろそろファンを名乗ってもいいかもね？", perfect: "全問正解！よくできました！<br>素晴らしい結果です！次は「むずかしい」に挑戦だ！" },
    hard: { zero: "全問不正解…。<br>「むずかしい」の壁はかなり高かったようだ。", low: "この難易度はまだ早かったかも…？<br>でも挑戦する姿勢は最高にかっこいいぜ。", mid: "大健闘！<br>「むずかしい」でこれだけ解ければ相当なもの。", high: "すごい！よくここまで正解できましたね！<br>全問正解までもうちょっと。もう一回チャレンジだ！", perfect: "全問正解！コングラッチュレーション！！<br>この難易度で満点はもはや職人の域ですな！" },
    expert: { zero: "へんじがない。ただのしかばねのようだ。<br>0点でも泣かないで。当てる方がおかしいレベルですから。", low: "相手が悪すぎた…。<br>一筋縄ではいかないね。ドンマイドンマイ！", mid: "素晴らしい！<br>この難問揃いで半分解けるとは、なかなかやるな？", high: "素晴らしすぎて鳥肌ものです。<br>もしかしたら本人よりも詳しいかも…！？", perfect: "👼⛩️✨神、降臨✨⛩️👼。<br>あなたは一体何者…？まさか本人？？" }
  };

  // --- セッション復元チェック（マウント時） ---
  useEffect(() => {
    const sid = localStorage.getItem('quiz_session_id');
    if (!sid) return;
    supabase.from('sessions').select('*').eq('session_id', sid).maybeSingle()
      .then(({ data }) => {
        if (data) setPendingResume(data);
        else localStorage.removeItem('quiz_session_id');
      });
  }, []);

  // --- クイズ開始（セッション作成） ---
  const startQuiz = async () => {
    // エンドレスはセッション不要
    if (gameMode === 'endless') {
      setScreen('quiz');
      return;
    }
    const oldId = sessionId || pendingResume?.session_id;
    if (oldId) {
      await supabase.from('sessions').delete().eq('session_id', oldId);
      localStorage.removeItem('quiz_session_id');
    }
    setSessionId(null);
    setPendingResume(null);
    setSelectedMembers(new Set());
    const ids = quizState.quizzes.map(q => q.id);
    const { data } = await supabase.from('sessions').insert({
      group_name: quizState.group,
      difficulty: quizState.difficulty,
      current_step: 1,
      quiz_ids: ids,
      correct_count: 0
    }).select('session_id').single();
    if (data?.session_id) {
      localStorage.setItem('quiz_session_id', data.session_id);
      setSessionId(data.session_id);
    }
    setScreen('quiz');
  };

  // --- セッション復元 ---
  const resumeQuiz = async () => {
    setIsResumingSession(true);
    const s = pendingResume;
    const ids = s.quiz_ids;
    const { data: qData } = await supabase.from('quiz_full').select('*').in('id', ids);
    const sorted = ids.map(id => (qData || []).find(q => q.id === id)).filter(Boolean);
    const { data: mData } = await supabase.from('members').select('*').eq('group_name', s.group_name).order('sort_order');
    const quizzesWithSurrounds = await fetchSurrounds(sorted);
    setMembers(mData || []);
    setQuizState({
      group: s.group_name,
      difficulty: s.difficulty,
      currentIndex: s.current_step - 1,
      correctCount: s.correct_count,
      quizzes: quizzesWithSurrounds
    });
    setSessionId(s.session_id);
    setPendingResume(null);
    setIsResumingSession(false);
    setSelectedMembers(new Set());
    setAnswered(false);
    setResultMsg({ text: '', type: '' });
    setScreen('quiz');
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
    const [{ data: qData }, { data: mData }] = await Promise.all([
      supabase.from("quiz_full").select("*").eq("group_name", selectedGroup),
      supabase.from("members").select("*").eq("group_name", selectedGroup).order("sort_order")
    ]);
    if (!qData || qData.length === 0) {
      setStatusMsg("問題が見つかりませんでした");
      setIsPreparing(false);
      return;
    }
    setMembers(mData || []);
    // Q1を選択してfullデータ取得
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
    const newCorrectCount = isCorrect ? quizState.correctCount + 1 : quizState.correctCount;

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

    // --- 通常モード ---
    if (isCorrect) {
      setQuizState(prev => ({ ...prev, correctCount: prev.correctCount + 1 }));
      setResultMsg({ text: `<span style="font-size:1.15em">⭕ 正解！😄</span><br><span style="font-size:0.8em">( 正解：${correctLabel} )</span>`, type: "correct" });
    } else {
      setResultMsg({ text: `<span style="font-size:1.15em">❌ 不正解！😫</span><br><span style="font-size:0.8em">( 正解：${correctLabel} )</span>`, type: "incorrect" });
    }
    setAnswered(true);
    if (sessionId) {
      const isLast = quizState.currentIndex + 1 === quizState.quizzes.length;
      if (isLast) {
        supabase.from('sessions').delete().eq('session_id', sessionId).then(() => {});
        localStorage.removeItem('quiz_session_id');
        setSessionId(null);
      } else {
        supabase.from('sessions').update({
          correct_count: newCorrectCount,
          current_step: quizState.currentIndex + 2
        }).eq('session_id', sessionId).then(() => {});
      }
    }
    setTimeout(() => window.scrollTo({ top: document.body.scrollHeight, behavior: "smooth" }), 100);
  };

  const nextQuestion = () => {
    if (gameMode === 'endless') { advanceEndlessQuestion(); return; }
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
    // プール枯渇 or ゲームオーバー → リザルトへ
    if (!endlessNextQ && !endlessNextQLoading) { setScreen('result'); return; }
    if (!endlessNextQ) return; // まだ先読み中（ボタンはdisabledのため通常ここには来ない）
    // 予約済みの通知とライフ増減を次の問題画面で適用
    const pending = endlessPendingNotifRef.current;
    endlessPendingNotifRef.current = null;
    if (pending) {
      if (pending.lifeDelta) setEndlessLives(prev => prev + pending.lifeDelta);
      setEndlessLifeBonus({ type: pending.type, amount: pending.amount, key: Date.now() });
    } else {
      setEndlessLifeBonus({ type: 'none', amount: 0, key: 0 });
    }
    const newQNum = endlessQNum + 1;
    const DIFF_THRESHOLDS = {
      11: { text: '難易度UP！',   tier: 'やさしい × ふつう' },
      21: { text: '難易度UP！',   tier: 'ふつうのみ' },
      36: { text: '難易度UP！',   tier: 'ふつう × むずかしい' },
      51: { text: '難易度UP！',   tier: 'むずかしいのみ' },
      71: { text: '難易度MAX！！', tier: 'むずかしい × げきむず' },
    };
    if (DIFF_THRESHOLDS[newQNum]) setEndlessDiffNotif({ ...DIFF_THRESHOLDS[newQNum], key: Date.now() });
    else setEndlessDiffNotif({ text: '', tier: '', key: 0 });
    setEndlessQNum(newQNum);
    setQuizState(prev => ({ ...prev, quizzes: [endlessNextQ], currentIndex: 0 }));
    setEndlessNextQ(null);
    setAnswered(false);
    setSelectedMembers(new Set());
    setResultMsg({ text: "", type: "" });
    window.scrollTo({ top: 0, behavior: "smooth" });
    // 次の次を先読み
    prefetchEndlessNext(endlessPoolRef.current, newQNum + 1);
  };

  // --- 検定モード：問題タイマー（60秒・問題が変わるたびリセット） ---
  useEffect(() => {
    if (screen !== 'quiz' || gameMode !== 'normal') return;
    setQuestionTimer(60);
    const id = setInterval(() => {
      setQuestionTimer(prev => {
        if (prev <= 1) { clearInterval(id); return 0; }
        return prev - 1;
      });
    }, 1000);
    questionTimerIntervalRef.current = id;
    return () => clearInterval(id);
  }, [quizState.currentIndex, screen, gameMode]);

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
      if (sessionId) {
        const isLast = quizState.currentIndex + 1 === quizState.quizzes.length;
        if (isLast) {
          supabase.from('sessions').delete().eq('session_id', sessionId).then(() => {});
          localStorage.removeItem('quiz_session_id');
          setSessionId(null);
        } else {
          supabase.from('sessions').update({
            correct_count: quizState.correctCount,
            current_step: quizState.currentIndex + 2
          }).eq('session_id', sessionId).then(() => {});
        }
      }
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
          setTimeout(() => { setResultPhase('reveal'); fireConfetti(); }, elapsed + 300);
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
      fitText(hintPrevRef.current, 0.62, 7);
      fitText(hintNextRef.current, 0.62, 7);
    };
    fitAll();
    document.fonts.ready.then(fitAll);
  }, [screen, quizState.currentIndex, quizState.quizzes]);


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
  const showSongName = gameMode === 'endless'
    ? endlessQNum <= 20
    : quizState.difficulty === 'easy';
  const showSurroundHint = gameMode === 'endless'
    ? endlessQNum <= 50
    : (quizState.difficulty === 'easy' || quizState.difficulty === 'normal' || answered);
  const quizPrevLines = showSurroundHint ? sp.slice(-1) : [];
  const quizNextLines = showSurroundHint ? sn.slice(0, 1) : [];
  const quizExplanation = (quizCurr?.song_name && quizCurr?.section_name)
    ? `この歌詞は「${quizCurr.song_name}」の\n${quizCurr.section_name}部分でした！` : "";

  if (!accessGranted) {
    return (
      <div className="app-root">
        <div className="box access-gate-box fade-in">
          <img src={logo} alt="KAWAII LAB検定" className="site-logo" style={{marginBottom: '16px'}} />
          <p className="access-gate-title">アクセスコードを入力してください</p>
          <input
            className="access-gate-input"
            type="password"
            value={accessInput}
            onChange={e => setAccessInput(e.target.value)}
            onKeyDown={e => e.key === 'Enter' && handleAccessSubmit()}
            placeholder="アクセスコード"
            autoFocus
          />
          <button className="access-gate-btn" onClick={handleAccessSubmit}>確認</button>
          {accessError && <p className="access-gate-error">コードが違います</p>}
        </div>
      </div>
    );
  }

  return (
    <div className="app-root" onClick={() => setInfoLevel(null)}>
      <div className="global-footer-link">
        {screen !== 'top' && screen !== 'result' && (
          <span onClick={async () => {
            clearInterval(questionTimerIntervalRef.current);
            if (sessionId) {
              const { data } = await supabase.from('sessions').select('*').eq('session_id', sessionId).maybeSingle();
              if (data) setPendingResume(data);
            }
            setScreen('top');
          }}>🏠 トップにもどる</span>
        )}
        {(screen === 'top' || screen === 'result') && (
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
            <button className="start-btn-list" onClick={() => pendingResume ? (setResumeModalSource('songlist'), setShowResumeModal(true)) : fetchSongList()}>
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
            if (pendingResume) { setResumeModalSource('group'); setShowResumeModal(true); }
            else { setScreen('group'); }
          }}>
            <span className="mode-btn-icon">📝</span>
            <span className="mode-btn-name">検定モード</span>
            <span className="mode-btn-desc">10問制・1問60秒！じっくり挑戦！</span>
          </button>
          {(debugMode || endlessUnlocked) && (
            <button className="mode-btn mode-btn-endless" onClick={() => { setGameMode('endless'); setScreen('group'); }}>
              <span className="mode-btn-icon">🎯</span>
              <span className="mode-btn-name">エンドレスモード</span>
              <span className="mode-btn-desc">問題が尽きるまで挑戦！</span>
            </button>
          )}
          <button className="back-btn-group back-btn-top" onClick={() => setScreen('top')}>トップに戻る</button>
        </div>
      )}

      {/* --- グループ選択 --- */}
      {screen === 'group' && (
        <div className="box group-card zoom-in">
          <h2 className="title">グループを選択しましょう！</h2>
          {[
            { name: 'FRUITS ZIPPER', label: '🍎FRUITS ZIPPER🍎', cls: 'fz' },
            { name: 'CANDY TUNE',    label: '🍬CANDY TUNE🍬',    cls: 'cd' },
            { name: 'SWEET STEADY',  label: '💐SWEET STEADY💐',  cls: 'ss' },
            { name: 'CUTIE STREET',  label: '💎CUTIE STREET💎',  cls: 'cs' },
            { name: 'MORE STAR',     label: '🌟MORE STAR🌟',     cls: 'ms' },
          ].map(g => (
            <button key={g.name} className={`group-choice-btn group-btn-${g.cls}`} onClick={() => {
              setQuizState(prev => ({ ...prev, group: g.name }));
              if (gameMode === 'endless') { setScreen('confirm'); prepareEndlessMode(g.name); }
              else setScreen('difficulty');
            }}>{g.label}</button>
          ))}
          <button className="back-btn-group back-btn-top" onClick={() => setScreen('mode')}>モード選択に戻る</button>
        </div>
      )}

      {/* --- 難易度選択 --- */}
      {screen === 'difficulty' && (
        <div className="box difficulty-card zoom-in">
          <div className={`selected-group-badge selected-group-badge--${{ 'FRUITS ZIPPER': 'fz', 'CANDY TUNE': 'cd', 'SWEET STEADY': 'ss', 'CUTIE STREET': 'cs', 'MORE STAR': 'ms' }[quizState.group] || 'fz'}`}>{quizState.group}</div>
          <h2 className="title">難易度を選択しましょう！</h2>
          <div className="button-row">
            {['easy', 'normal', 'hard', 'expert'].map(level => (
              <div key={level} className="difficulty-item">
                <button className={`diff-btn diff-btn-${level}`} onClick={() => {
                  if (infoLevel) return;
                  setQuizState(prev => ({...prev, difficulty: level}));
                  setScreen('confirm');
                  prepareQuiz(quizState.group, level);
                }}>
                  {difficultyLabel[level]}
                </button>
                <img src="/info.png" className="info-icon" onClick={(e) => { 
                  e.stopPropagation(); 
                  if (infoLevel === level) {
                    closeInfo();
                  } else {
                    // infoLevel と同時に difficulty もセットして、閉じるときのテキストを確保する
                    setQuizState(prev => ({ ...prev, difficulty: level }));
                    setInfoLevel(level);
                  }
                }} alt="info" />
              </div>
            ))}
          </div>
          {/* infoLevel または closingInfo のどちらかが true なら表示を維持 */}
          {(infoLevel || closingInfo) && (
            <div className={`info-modal-overlay${closingInfo ? ' closing' : ''}`} onClick={closeInfo}>
              <div className={`info-pop${closingInfo ? ' closing' : ''}`} onClick={e => e.stopPropagation()}>
                {/* infoLevel が null になった瞬間のために、quizState.difficulty を予備として表示 */}
                {(descriptions[infoLevel] || descriptions[quizState.difficulty]).map((item, i) => (
                  <div key={i} className="info-pop-item">
                    <span className="info-pop-bullet-char">・</span>
                    <span>{item}</span>
                  </div>
                ))}
              </div>
            </div>
          )}
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
            {quizState.group}の{gameMode === 'endless' ? 'エンドレス' : difficultyLabel[quizState.difficulty]}に挑戦中
          </p>
          {gameMode === 'endless' ? (
            <p className="quiz-counter">{endlessQNum} 問目</p>
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
              <span className="hint-label">-直前の歌詞-</span>
              <div className="hint-text" ref={hintPrevRef}>{quizPrevLines.join('\n')}</div>
            </div>
          )}

          <p id="lyrics" ref={lyricsRef}>{quizCurr?.lyrics}</p>

          {quizNextLines.length > 0 && (
            <div className="hint-lyrics">
              <span className="hint-label">-直後の歌詞-</span>
              <div className="hint-text" ref={hintNextRef}>{quizNextLines.join('\n')}</div>
            </div>
          )}

          <div className="members">
            {members.map(m => (
              <button key={m.id}
                className={`member-btn${selectedMembers.has(m.name) ? ' on' : ''}`}
                onClick={() => toggleMember(m.name)}
                disabled={answered}
              >{m.name}</button>
            ))}
            <button
              className={`member-btn all-btn${selectedMembers.size === members.length && members.length > 0 ? ' on' : ''}`}
              onClick={() => {
                if (selectedMembers.size === members.length) setSelectedMembers(new Set());
                else setSelectedMembers(new Set(members.map(m => m.name)));
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
            <button className="endless-go-btn" onClick={() => setScreen('result')}>
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
          </div>
        </div>
      )}

      {/* --- コナミコマンド解放フラッシュ --- */}
      {konamiFlash && (
        <div className="konami-flash-overlay">
          <div className="konami-flash-text">🎮 エンドレスモード解放！</div>
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
                setScreen('confirm');
                prepareEndlessMode(quizState.group);
              }}>もう一回</button>
              <button className="group-btn" onClick={() => setScreen('group')}>グループ選択</button>
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
              <button className="retry-btn" onClick={() => { setScreen('confirm'); prepareQuiz(quizState.group, quizState.difficulty); setAnswered(false); setQuizState(p=>({...p, correctCount:0, currentIndex:0})); setSelectedMembers(new Set()); }}>もう一回やる</button>
              <button className="group-btn" onClick={() => setScreen('group')}>グループ選択</button>
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

      {/* --- セッション再開モーダル --- */}
      {(showResumeModal || closingResumeModal) && pendingResume && (
        <div className={`modal-overlay${closingResumeModal ? ' closing' : ''}`} onClick={closeResumeModal}>
          <div className="modal-content" onClick={e => e.stopPropagation()} style={{textAlign: 'center'}}>
            <h2>📖 途中のクイズが見つかりました</h2>
            <p style={{marginBottom: '6px'}}>{pendingResume.group_name}・{difficultyLabel[pendingResume.difficulty]}</p>
            <p style={{marginBottom: '20px'}}>{pendingResume.current_step}問目から再開できます</p>
            <button className="resume-continue-btn" onClick={() => { closeResumeModal(); resumeQuiz(); }} disabled={isResumingSession}>
              {isResumingSession ? '読み込み中…' : '▶ 続きから始める'}
            </button>
            <br />
            <button className="resume-discard-btn" style={{marginTop: '12px'}} onClick={() => { closeResumeModal(); discardSession(); if (resumeModalSource === 'songlist') { fetchSongList(); } else { setScreen('group'); } }}>
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
          <button className="debug-toggle-btn" onClick={() => setDebugPanelOpen(p => !p)}>
            {debugPanelOpen ? '▲ パネルを隠す' : '▼ デバッグパネル'}
          </button>

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
          </>}
        </div>
      )}
    </div>
  );
}

export default App;