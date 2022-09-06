// 经典题目 https://www.luogu.com.cn/problem/P1873
#include <bits/stdc++.h>
using namespace std;

// 随着高度下降 木材增加
int h[1000005];

int main() {
    int n, m, mx = 0;
    cin >> n >> m;
    for (int i = 1; i <= n; i++) {
        cin >> h[i];
        mx = max(mx, h[i]);
    }
    for (int k = mx; k >= 0; k--) { // 当前选定的高度
        int sum = 0;
        for (int i = 1; i <= n; i++) {
            if (h[i] >= k) sum += (h[i] - k);
        }
        if (sum >= m) {
            cout << k << endl;
            return 0;
        }
    }
    return 0;
}