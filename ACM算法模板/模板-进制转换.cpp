// 经典题目 https://www.luogu.com.cn/problem/P1143
#include <bits/stdc++.h>
using namespace std;

int a[105];
char str[105];

int to_10(int x, char s[]) { // 任意进制转十进制
    int ans = 0;
    for (int i = 0; i < strlen(s); i++) {
        int v = 0;
        if (s[i] >= '0' && s[i] <= '9') {
            v = s[i] - '0';
        } else {
            v = s[i] - 'A' + 10;
        }
        ans = ans * x + v;
    }
    return ans;
}

void to_m(int x, int m) { // 十进制转任意进制
    int k = 0;
    while (x) {
        a[++k] = x % m;
        x /= m;
    }
    for (int i = k; i >= 1; i--) {
        if (a[i] < 10) cout << a[i];
        else cout << char(a[i] + ('A' - 10));
    }
}

int main() {
    int n, m;
    cin >> n >> str >> m;
    int k = to_10(n, str);
    to_m(k, m);
    return 0;
}