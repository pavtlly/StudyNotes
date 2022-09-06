// 经典题目 https://www.luogu.com.cn/problem/P1605
#include <bits/stdc++.h>
using namespace std;

// 四个方向
int dx[4] = {-1, 1, 0, 0};
int dy[4] = {0, 0, -1, 1};
int n, m, t, sx, sy, fx, fy, ans = 0;
bool mp[105][105];
bool vis[105][105]; // 标记处理 避免来回走 导致死循环

void dfs(int x, int y) {
    if (x == fx && y == fy) {
        ans++;
        return ;
    }
    for (int i = 0; i < 4; i++) {
        int nx = x + dx[i];
        int ny = y + dy[i];
        // 1.不走出地图边界 2.走的点不是障碍物 3.之前没有走过
        if (nx >= 1 && nx <= n && ny >= 1 && ny <= m
            && !mp[nx][ny] && !vis[nx][ny]) {
            vis[nx][ny] = true;
            dfs(nx, ny);
            vis[nx][ny] = false; // 回溯处理
        }
    }
}

int main() {
    cin >> n >> m >> t;
    cin >> sx >> sy >> fx >> fy;
    for (int i = 1; i <= t; i++) {
        int x, y;
        cin >> x >> y;
        mp[x][y] = true; // 障碍物
    }
    vis[sx][sy] = true;
    dfs(sx, sy);
    cout << ans << endl;
    return 0;
}
