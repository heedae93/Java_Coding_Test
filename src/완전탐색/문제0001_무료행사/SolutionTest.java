package 완전탐색.문제0001_무료행사;

import judge.Judge;

// 문제의 입출력 예시를 테스트 케이스로 옮겨 적고 실행하세요.
public class SolutionTest {
    public static void main(String[] args) {
        Judge judge = new Judge();

        // judge.test(기댓값, () -> new Solution().solution(입력));
        judge.test(12, () -> new Solution().solution(new int[]{8, 3, 6, 1, 9, 4}, 12));
        judge.test(-1, () -> new Solution().solution(new int[]{5, 7, 10}, 11));
        judge.test(9,  () -> new Solution().solution(new int[]{3, 9, 6, 2}, 10));
        judge.test(4,  () -> new Solution().solution(new int[]{2, 2, 2}, 4));

        // 직접 추가한 엣지 케이스
        judge.test(2_000_000, () -> new Solution().solution(new int[]{1_000_000, 1_000_000}, 2_000_000));   // 최댓값
        judge.test(-1, () -> new Solution().solution(new int[]{3, 5}, 6));                                 // 같은 상품 두 번 불가 (3+3 X)

        judge.summary();
    }
}
