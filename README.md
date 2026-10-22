# ☕ 자바 코딩테스트 저장소

프로그래머스처럼 **문제 붙여넣기 → `Solution` 풀기 → 실행하면 채점**되는 로컬 환경입니다.
문제 하나 = 폴더 하나 (`문제 + 풀이 코드 + 테스트 + 회고`)로 쌓아 갑니다.

---

## 📁 폴더 구조

```
coding-test/
├── README.md               ← 지금 보는 사용 설명서
├── 문제목록.md              ← 푼 문제 전체 목록 (자동 추가)
├── new.ps1 / new.sh        ← 새 문제 폴더 만들기
├── run.ps1 / run.sh        ← 채점 실행
├── templates/              ← 새 문제를 만들 때 복사되는 틀
├── notes/                  ← 개념 정리 노트 (자료구조, 시간복잡도 …)
└── src/
    ├── judge/
    │   └── Judge.java       ← 프로그래머스 스타일 채점기 (건드리지 않음)
    ├── 완전탐색/
    ├── 스택/
    │   └── 문제0012_점진적과부하/
    │       ├── README.md          ← 📄 문제 원문 + 💭 접근 + 🔁 회고
    │       ├── Solution.java      ← 💻 내 풀이 (프로그래머스에 그대로 제출)
    │       └── SolutionTest.java  ← ✅ 입출력 예 = 테스트 케이스
    ├── 해시/
    └── …
```

### 분류(카테고리) 이름

폴더 이름이 그대로 자바 패키지 이름이 되므로 **띄어쓰기·기호 없이** 한글로 씁니다. 처음 쓰는 분류는 자동으로 만들어집니다.
문제 폴더는 `문제0001_제목` 형식이고, 번호는 자동으로 붙습니다. (자바 패키지는 숫자로 시작할 수 없어서 앞에 `문제`를 붙임)

| 분류 | 내용 |
| --- | --- |
| `완전탐색` | 모든 경우 다 해보기 |
| `배열` | 배열, ArrayList, 누적합 |
| `연결리스트` | 연결 리스트 |
| `큐` | 큐, 덱 |
| `스택` | 스택, 괄호, 단조 스택 |
| `해시` | 해시맵, 해시셋 |
| `투포인터` | 투 포인터, 슬라이딩 윈도우 |
| `정렬` | 정렬 |
| `이분탐색` | 이분 탐색 |
| `힙` | 우선순위 큐 |
| `DFS_BFS` | DFS, BFS |
| `백트래킹` | 백트래킹 |
| `그리디` | 그리디 |
| `동적계획법` | 동적 계획법 |
| `그래프` | 최단경로, 유니온 파인드, 위상 정렬 |
| `문자열` | 문자열 |
| `구현` | 구현, 시뮬레이션 |

---

## 🚀 한 문제 푸는 흐름

### 1) 새 문제 만들기

```powershell
# Windows (PowerShell)
.\new.ps1 스택 점진적과부하
```

```bash
# Mac / Linux / Git Bash
./new.sh 스택 점진적과부하
```

→ `src/스택/문제0001_점진적과부하/` 폴더가 생기고 `문제목록.md`에 한 줄 추가됩니다.
번호는 자동으로 1씩 증가합니다.

### 2) `README.md`에 문제 붙여넣기

문제 설명, 제한사항, 입출력 예를 그대로 붙여넣습니다.

### 3) `Solution.java` 풀기

프로그래머스의 `class Solution`과 똑같이 메서드 시그니처를 맞추고 풉니다.
제출할 때는 `class Solution { … }` 부분만 복사해 붙여넣으면 됩니다. (맨 위 `package` 줄은 빼기)

### 4) `SolutionTest.java`에 입출력 예 적기

```java
judge.test(기댓값, () -> new Solution().solution(입력1, 입력2));

// 예
judge.test(new int[]{2, 1, 2, 1, 0}, () -> new Solution().solution(new int[]{3, 1, 4, 2, 5}));
judge.test(true, () -> new Solution().solution("()()"));
```

배열·2차원 배열도 내용으로 비교합니다. 엣지 케이스도 직접 추가해 보세요.

### 5) 채점

```powershell
.\run.ps1 1        # 번호로 실행
```

```bash
./run.sh 1
```

IntelliJ / VS Code에서는 `SolutionTest.java`를 열고 ▶ 실행 버튼을 눌러도 됩니다.

```
▶ 스택/문제0001_점진적과부하

테스트  1 〉	통과 (0.05ms)
테스트  2 〉	실패 (0.02ms)
          기댓값 〉 [1, 1, 0]
          실행 결과 〉 [0, 0, 0]

채점 결과
정확성: 50.0
합계: 50.0 / 100.0  (1 / 2 통과)
```

### 6) 회고 쓰고 목록 체크

`README.md`의 💭 접근 방법, ⏱️ 복잡도, 🔁 회고를 채우고
`문제목록.md`의 ⬜를 ✅ 또는 🔁로 바꿉니다.

---

## 🛠️ 처음 한 번만 하는 설정

### Java 확인

```bash
java -version    # 17 이상 권장
```

### IntelliJ

1. `File → Open` → `coding-test` 폴더 열기
2. `src` 폴더 우클릭 → `Mark Directory as → Sources Root`
3. `SolutionTest.java` 열고 ▶ 실행

### VS Code

1. `Extension Pack for Java` 설치
2. `coding-test` 폴더 열기 → `src`가 자동으로 소스 폴더로 잡힘
3. `SolutionTest.java`의 `main` 위 `Run` 클릭

### PowerShell 스크립트가 실행되지 않을 때

"이 시스템에서 스크립트를 실행할 수 없으므로…" 오류가 나면 한 번만 실행:

```powershell
Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
```

### Git으로 관리 (선택)

```bash
git init
git add .
git commit -m "init: 코테 저장소"
```

GitHub에 올려 두면 잔디도 쌓이고 다른 PC에서도 이어서 풀 수 있습니다.
