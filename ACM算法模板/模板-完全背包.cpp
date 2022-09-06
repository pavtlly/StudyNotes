// 经典题目 https://www.luogu.com.cn/problem/P1616
#include <cstdio>
#include <iostream>
using namespace std;

const int N = 1e4 + 5;
const int M = 1e7 + 5;
typedef long long ll;

ll n, m, w[N], v[N], dp[M];

int main(){
    scanf("%lld %lld", &m, &n);
    for (int i = 1; i <= n; i++)
    scanf("%lld %lld", &w[i], &v[i]);
    for (int i = 1; i <= n; i++)
        for (int j = w[i]; j <= m; j++)
            dp[j] = max(dp[j], dp[j - w[i]] + v[i]);
    printf("%lld", dp[m]);
    return 0;
}