// 经典题目 http://ybt.ssoier.cn:8088/problem_show.php?pid=1376
#include <bits/stdc++.h>
using namespace std;

int dp[105][105];
const int INF = 0x3f3f3f3f;

int main() {
    int n, m;
    cin >> n >> m;

    for (int i = 1; i <= n; i++) { // 初始化
        for (int j = 1; j <= n; j++) {
            if (i == j) dp[i][j] = 0;
            else dp[i][j] = INF;
        }
    }

    for (int i = 1; i <= m; i++) {
        int u, v, w;
        cin >> u >> v >> w;
        dp[u][v] = dp[v][u] = w; // 无向图
    }

    for (int k = 1; k <= n; k++) // 中转站
    for (int i = 1; i <= n; i++)
    for (int j = 1; j <= n; j++)
    dp[i][j] = min(dp[i][j], dp[i][k] + dp[k][j]);

    int ans = 0;
    for (int i = 1; i <= n; i++) {
        if (dp[1][i] == INF) {
            cout << -1 << endl;
            return 0;
        } else {
            ans = max(ans, dp[1][i]);
        }
    }
    cout << ans << endl;

    return 0;
}