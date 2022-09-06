// 经典题目 https://www.luogu.com.cn/problem/P4779
#include <bits/stdc++.h>
using namespace std;

const int N = 100005;
const int INF = 0x3f3f3f3f;
vector< pair<int, int> > e[N]; // 邻接表存图
int n, m, s, d[N];
bool vis[N];

void dijkstra() {
    // 优先队列 注意和e里面存的东西进行区分
    priority_queue< pair<int, int> > q;
    // 初始化
    for (int i = 0; i <= n; i++) d[i] = INF;
    d[s] = 0;
    q.push(make_pair(0, s));
    while (!q.empty()) {
        int u = q.top().second;
        q.pop();
        if (vis[u]) continue;
        vis[u] = true; // 出来的时候一定是u离起点最近的距离
        for (int i = 0; i < e[u].size(); i++) {
            int v = e[u][i].first;
            int w = e[u][i].second;
            if (d[u] + w < d[v]) {
                d[v] = d[u] + w;
                q.push(make_pair(-d[v], v));
            }
        }
    }
}

int main() {
    cin >> n >> m >> s;
    for (int i = 1; i <= m; i++) {
        int u, v, w;
        cin >> u >> v >> w;
        e[u].push_back(make_pair(v, w));
    }
    dijkstra();
    for (int i = 1; i <= n; i++) cout << d[i] << " ";
    return 0;
}