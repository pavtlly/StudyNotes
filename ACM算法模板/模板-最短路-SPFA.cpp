// 经典题目 https://www.luogu.com.cn/problem/P3371
#include <bits/stdc++.h>
using namespace std;

const int INF = 0x3f3f3f3f;
struct edge {
    int v, w;
}p;

int n, m, s, u;
int d[10005]; // d[i]:从起点到i顶点的最短距离
vector<edge> e[10005];
bool inque[10005]; // 优化 用数组去保持队列没有相同的点

void SPFA() {
    queue<int> q;
    q.push(s);
    inque[s] = true;
    d[s] = 0;
    while (!q.empty()) {
        u = q.front();
        q.pop();
        inque[u] = false;
        for (int i = 0; i < e[u].size(); i++) {
            p = e[u][i];
            if (d[p.v] > d[u] + p.w) {
                d[p.v] = d[u] + p.w;
                if (!inque[p.v]) q.push(p.v);
            }
        }
    }
}

int main() {
    cin >> n >> m >> s;
    for (int i = 1; i <= n; i++) d[i] = INF; // 初始化
    for (int i = 1; i <= m; i++) {
        cin >> u >> p.v >> p.w;
        e[u].push_back(p); // 有向图
    }
    SPFA();
    for (int i = 1; i <= n; i++) cout << d[i] << " ";
    return 0;
}