// 经典题目 https://www.luogu.com.cn/problem/P5318
#include <bits/stdc++.h>
using namespace std;

int n, m;
bool vis[100010];
vector<int> g[100010];

void dfs(int x, int cnt) {
    vis[x] = true;
    cout << x << " ";
    if (cnt == n) return ;
    for (int i = 0; i< g[x].size(); i++)
        if (!vis[g[x][i]]) dfs(g[x][i], cnt + 1);
}

void bfs(int x) {
    memset(vis, 0, sizeof(vis));
    vis[x] = true;
    queue<int> q;
    q.push(x);
    while (!q.empty()) {
        int v = q.front();
        q.pop();
        cout << v << " ";
        for (int i = 0; i < g[v].size(); i++) {
            if (!vis[g[v][i]]) {
                vis[g[v][i]] = true;
                q.push(g[v][i]);
            }
        }
    }
}

int main() {
    cin >> n >> m;
    for (int i = 1; i <= m; i++) {
        int u, v;
        cin >> u >> v;
        g[u].push_back(v);
    }
    for (int i = 1; i <= n; i++) sort(g[i].begin(), g[i].end());
    dfs(1, 0);
    cout << endl;
    bfs(1);
    return 0;
}