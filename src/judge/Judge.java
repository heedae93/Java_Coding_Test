package judge;

import java.util.Arrays;
import java.util.Objects;
import java.util.function.Supplier;

/**
 * 프로그래머스 스타일 로컬 채점기.
 *
 * 사용법 (SolutionTest.java):
 *   Judge judge = new Judge();
 *   judge.test(기대값, () -> new Solution().solution(입력1, 입력2));
 *   judge.summary();
 *
 * 배열(int[], String[], int[][] ...)도 내용으로 비교합니다.
 */
public class Judge {

    private int total = 0;
    private int passed = 0;

    public void test(Object expected, Supplier<Object> run) {
        total++;
        String label = String.format("테스트 %2d 〉", total);

        long start = System.nanoTime();
        Object actual;
        try {
            actual = run.get();
        } catch (Throwable e) {
            System.out.printf("%s\t실패 (런타임 에러: %s)%n", label, e);
            return;
        }
        double ms = (System.nanoTime() - start) / 1_000_000.0;

        if (same(expected, actual)) {
            passed++;
            System.out.printf("%s\t통과 (%.2fms)%n", label, ms);
        } else {
            System.out.printf("%s\t실패 (%.2fms)%n", label, ms);
            System.out.printf("          기댓값 〉 %s%n", show(expected));
            System.out.printf("          실행 결과 〉 %s%n", show(actual));
        }
    }

    public void summary() {
        double score = total == 0 ? 0 : passed * 100.0 / total;
        System.out.println();
        System.out.println("채점 결과");
        System.out.printf("정확성: %.1f%n", score);
        System.out.printf("합계: %.1f / 100.0  (%d / %d 통과)%n", score, passed, total);
    }

    private static boolean same(Object a, Object b) {
        // int와 long 등 숫자 타입이 달라도 값이 같으면 통과
        if (a instanceof Number && b instanceof Number
                && !(a instanceof Double) && !(b instanceof Double)) {
            return ((Number) a).longValue() == ((Number) b).longValue();
        }
        return Objects.deepEquals(a, b);
    }

    private static String show(Object o) {
        if (o == null) return "null";
        if (o.getClass().isArray()) {
            String s = Arrays.deepToString(new Object[]{o});
            return s.substring(1, s.length() - 1);
        }
        if (o instanceof String) return "\"" + o + "\"";
        return String.valueOf(o);
    }
}
