// 经典题目 https://www.luogu.com.cn/problem/P1048
#include <bits/stdc++.h>
using namespace std;

int t[105], v[105];
int dp[1005]; // 滚动数组优化的01背包

int main() {
    int T, M;
    cin >> T >> M;
    for (int i = 1; i <= M; i++) {
        cin >> t[i] >> v[i];
    }
    for (int i = 1; i <= M; i++) {
        for (int j = T; j >= 1; j--) { // 从前面转移的 所以避免一个物品被无限多次用 从后往前跑
            if (t[i] > j) {
                dp[j] = dp[j];
            } else {
                dp[j] = max(dp[j], dp[j - t[i]] + v[i]);
            }
        }
    }
    cout << dp[T] << endl;
    return 0;
}
