// 经典题目 http://www.51nod.com/Challenge/Problem.html#problemId=2911
#include<bits/stdc++.h>
using namespace std;

int n, m;
vector<int> e[1000005];
int col[1000005];

bool dfs(int u, int c) {
    col[u] = c;
    for (int i = 0; i < e[u].size(); i++) {
        int v = e[u][i];
        if (col[v]) {
            if (col[v] == col[u]) return false;
        }
        else {
            if (!dfs(v, -c)) return false;
        }
    }
    return true;
}

int main() {
    while (cin >> n >> m) {
        for (int i = 1; i <= n; i++) {
            e[i].clear();
            col[i] = 0;
        }
        for (int i = 1; i <= m; i++) {
            int u, v;
            cin >> u >> v;
            e[u].push_back(v);
            e[v].push_back(u);
        }
        if (!dfs(1, 1)) cout << "No" << endl;
        else cout << "Yes" << endl;
    }
    return 0;
}
