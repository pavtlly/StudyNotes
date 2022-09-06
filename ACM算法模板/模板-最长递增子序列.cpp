// 经典题目 http://ybt.ssoier.cn:8088/problem_show.php?pid=1281
#include <bits/stdc++.h>
using namespace std;

int n, a[1005], ans = 0;
int dp[1005]; //dp[i] 1-i的最长上升子序列长度

int main() {
    cin >> n;
    for (int i = 1; i <= n; i++) {
        cin >> a[i];
        dp[i] = 1;
    }
    for (int i = 1; i <= n; i++) {
        //dp[i] 如何转移
        for (int j = 1; j < i; j++) {
            if (a[i] > a[j]) dp[i] = max(dp[i], dp[j] + 1);
        }
        ans = max(ans, dp[i]);
    }
    cout << ans << endl;
    return 0;
}