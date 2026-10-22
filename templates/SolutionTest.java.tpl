package {{PACKAGE}};

import judge.Judge;

// 문제의 입출력 예시를 테스트 케이스로 옮겨 적고 실행하세요.
public class SolutionTest {
    public static void main(String[] args) {
        Judge judge = new Judge();

        // judge.test(기댓값, () -> new Solution().solution(입력));
        judge.test(0, () -> new Solution().solution(new int[]{1, 2, 3}));

        judge.summary();
    }
}
