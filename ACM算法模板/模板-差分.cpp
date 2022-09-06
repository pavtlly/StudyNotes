// 经典题目 http://www.51nod.com/Challenge/Problem.html#problemId=3113
#include <bits/stdc++.h>
using namespace std;

int ball[200005];

int main() {
    int n, m, a, b;
    cin >> n >> m;
    for (int i = 1; i <= m; i++) {
        cin >> a >> b;
        // 差分精髓  不直接for循环加减
        ball[a]++; ball[b + 1]--;
    }
    for (int i = 1; i <= n; i++) {
        ball[i] += ball[i - 1];
        cout << ball[i] << " ";
    }
    return 0;
}
