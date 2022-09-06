// 经典题目 https://www.luogu.com.cn/problem/P1451
#include <bits/stdc++.h>
using namespace std;

int n, m;
char s[105][105];
bool vis[105][105];
int dx[4] = {-1, 1, 0, 0};
int dy[4] = {0, 0, -1, 1};

void dfs(int x, int y) {
    for (int i = 0; i < 4; i++) {
        int nx = x + dx[i];
        int ny = y + dy[i];
        // 1.不走出地图边界 2.不等于字符‘0’ 3.之前没有走过
        if (!vis[nx][ny] && s[nx][ny] != '0'
            && nx >= 1 && nx <= n && ny >= 1 && ny <= m) {
            vis[nx][ny] = true;
            dfs(nx, ny);
        }
    }

}

int main() {
    int ans = 0;
    cin >> n >> m;
    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= m; j++) {
            cin >> s[i][j];
        }
    }
    // 整张地图遍历一遍
    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= m; j++) {
            // 是数字细胞 并且还没归纳到某个数字细胞里面
            if (s[i][j] != '0' && !vis[i][j]) {
                ans++;
                vis[i][j] = true;
                dfs(i, j);
            }
        }
    }
    cout << ans << endl;
    return 0;
}