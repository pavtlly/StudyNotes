// 经典题目 http://www.51nod.com/Challenge/Problem.html#problemId=1545
#include <bits/stdc++.h>
using namespace std;

int a[1005], b[1005];

int main() {
    int n, m;
    cin >> n >> m;
    for (int i = 1; i <= n; i++) {
        cin >> a[i];
        b[i] = b[i - 1] + a[i]; // 前缀和
    }
    for (int i = 1; i <= m; i++) {
        int l, r;
        cin >> l >> r;
        // 注意细节 要包括a[l]的值 所以拿b[l-1]
        cout << b[r] - b[l - 1] << endl;
    }
    return 0;
}