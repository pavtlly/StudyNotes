// 经典题目 https://www.luogu.com.cn/problem/P2249
#include <bits/stdc++.h>
using namespace std;

int n, m, q, a[1000005];

int main() {
    cin >> n >> m;
    for (int i = 1; i <= n; i++) cin >> a[i];
    for (int i = 1; i <= m; i++) {
        cin >> q;
        int ans = 2e9;
        int l = 1, r = n;
        while (l <= r) {
            int mid = (l + r) / 2;
            if (a[mid] == q) {
                ans = min(ans, mid);
                r = mid - 1;
            }
            else if (a[mid] > q) {
                r = mid - 1;
            }
            else if (a[mid] < q) {
                l = mid + 1;
            }
        }
        if (ans == 2e9) cout << -1 << " ";
        else cout << ans << " ";
    }
    return 0;
}
