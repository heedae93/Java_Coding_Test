package 완전탐색.문제0001_무료행사;

import java.util.*;

// 이 class Solution 부분만 프로그래머스에 그대로 붙여넣어 제출하면 됩니다.
class Solution {
    public int solution(int[] prices, int k) {
        int answer = -1;                                 // 조합이 없으면 그대로 -1
        for (int i = 0; i < prices.length; i++) {
            for (int j = i + 1; j < prices.length; j++) {   // i < j → 같은 상품·중복 조합 제외
                int sum = prices[i] + prices[j];
                if (sum <= k) answer = Math.max(answer, sum);
            }
        }
        return answer;
    }
}
