// 经典题目 https://www.luogu.com.cn/problem/P1113
#include <bits/stdc++.h>
using namespace std;

const int N = 10005;
queue <int> q;
vector<int> e[N];
int t[N], in[N], mx[N];
int n, ans = 0;

void toposort() {
    for (int i = 1; i <= n; i++) {
        if (in[i] == 0) {
            q.push(i);
            mx[i] = t[i];
        }
    }
    while (!q.empty()) {
        int u = q.front();
        q.pop();
        for (int i = 0; i < e[u].size(); i++) {
            int v = e[u][i];
            in[v]--;
            if (in[v] == 0) q.push(v);
            mx[v] = max(mx[v], mx[u] + t[v]);
        }
    }
    for (int i = 1; i <= n; i++) {
        ans = max(ans, mx[i]);
    }
}

int main() {
    cin >> n;
    for (int i = 1; i <= n; i++) {
        int a, b, c;
        cin >> a >> b >> c;
        t[a] = b;
        while (c != 0) {
            in[a]++;
            e[c].push_back(a);
            cin >> c;
        }
    }
    toposort();
    cout << ans << endl;
    return 0;
}