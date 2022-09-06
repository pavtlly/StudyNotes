// 经典题目 https://www.luogu.com.cn/problem/P1111
#include <bits/stdc++.h>
using namespace std;

int fa[100005];
struct edge {
    int u, v, w;
}e[200005];

int fi(int x) { // 查询操作
    return fa[x] == x ? x : fa[x] = fi(fa[x]);
}

bool cmp(edge x, edge y) { // 结构体排序
    return x.w < y.w;
}

int main() {
    int n, m, k;
    cin >> n >> m;
    k = n;
    // 初始化
    for (int i = 1; i <= n; i++) fa[i] = i;
    for (int i = 1; i <= m; i++) {
        cin >> e[i].u >> e[i].v >> e[i].w;
    }
    sort(e + 1, e + 1 + m, cmp);
    int sum = 0;
    for (int i = 1; i <= m; i++) {
        int fu = fi(e[i].u);
        int fv = fi(e[i].v);
        if (fu != fv) { // 合并操作
            fa[fu] = fv;
            sum = e[i].w;
            k--;
        }
    }
    if (k == 1) cout << sum << endl;
    else cout << -1 << endl;
    return 0;
}