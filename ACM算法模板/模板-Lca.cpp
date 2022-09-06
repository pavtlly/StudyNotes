#include <bits/stdc++.h>
using namespace std;
int n, m, s, ans;
vector<int> e[500005];
int dep[500005];
bool vis[500005];
int fa[500005];

void find(int p, int deep) {
	dep[p] = deep;
	for (int i = 0; i < e[p].size(); i++) {
		if (!vis[e[p][i]]) {
			fa[e[p][i]] = p;
			vis[e[p][i]] = true;
			find(e[p][i], deep + 1);
		}
	}
}

void dfs(int a, int b) {
	if (dep[a] > dep[b]) {
		dfs(fa[a], b);
	} else if (dep[a] < dep[b]) {
		dfs(a, fa[b]);
	} else if (dep[a] == dep[b]) {
		if (a == b) {
			ans = a;
			return;
		}
		else {
			dfs(fa[a], fa[b]);
		}
	}
}

int main() {
	scanf("%d%d%d", &n, &m, &s);
	for (int i = 1; i <= n - 1; i++) {
		int x, y;
		scanf("%d%d", &x, &y);
		e[x].push_back(y);
		e[y].push_back(x);
	}
    vis[s] = true;
	find(s, 1);
	while (m--) {
		int a, b;
		scanf("%d%d", &a,&b);
		dfs(a, b);
		printf("%d\n", ans);
	}
	return 0;
}

