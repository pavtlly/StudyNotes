// 经典题目 https://www.luogu.com.cn/problem/P1551
#include <bits/stdc++.h>
using namespace std;

int fa[5005];
int fi(int x) { // 查询操作
	if (fa[x] == x) return x;
	else return fi(fa[x]);
}

void uni(int x, int y) { // 合并操作
	int fx = fi(x), fy = fi(y);
	if (fx != fy) {
		fa[fx] = fy;
	}
}

int main() {
	int n, m, p;
	cin >> n >> m >> p;
    // 初始化
	for (int i = 1; i <= n; i++) fa[i] = i;
	for (int i = 1; i <= m; i++) {
		int a, b;
		cin >> a >> b;
		uni(a, b);
	}
	for (int i = 1; i <= p; i++) {
		int a, b;
		cin >> a >> b;
		if (fi(a) != fi(b)) cout << "No" << endl;
		else cout << "Yes" << endl;
	}
    return 0;
}