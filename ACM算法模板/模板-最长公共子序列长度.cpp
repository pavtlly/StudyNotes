// 经典题目 http://ybt.ssoier.cn:8088/problem_show.php?pid=1265
#include <bits/stdc++.h>
using namespace std;

string s1, s2;
int dp[1005][1005];
int main() {
    cin >> s1 >> s2;
    for (int i = 0; i < s1.size(); i++) {
        for (int j = 0; j < s2.size(); j++) {
            if (s1[i] == s2[j]) {
                dp[i+1][j+1] = max(dp[i+1][j+1], dp[i][j] + 1);
            } else {
                dp[i+1][j+1] = max(dp[i+1][j], dp[i][j+1]);
            }
        }
    }
    cout << dp[s1.size()][s2.size()] << endl;
    return 0;
}