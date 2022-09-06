// http://poj.org/problem?id=3061
#include <cstdio>
#include <iostream>
#include <algorithm>
using namespace std;

int a[100005];
int sum, s, n, t, ans;

int main() {
    scanf("%d", &t);
    while (t--) {
        scanf("%d %d", &n, &s);
        for (int i = 0; i < n; i++) scanf("%d", &a[i]);
        int l = 0, r = 0;
        ans = n + 1; sum = 0;
        while (1) {
            while (r < n && sum < s) sum += a[r++];
            if (sum < s) break;
            ans = min(ans, r - l);
            sum -= a[l++];
        }
        if (ans == n + 1) ans = 0;
        printf("%d\n", ans);
    }
    return 0;
}
