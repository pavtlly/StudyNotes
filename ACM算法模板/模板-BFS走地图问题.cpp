// 经典题目 https://www.luogu.com.cn/problem/P1746
#include <bits/stdc++.h>
using namespace std;

char mp[1005][1005]; // 地图
bool vis[1005][1005];
int sx, sy, ex, ey, n;
int dx[4] = {0, 1, 0, -1};
int dy[4] = {1, 0, -1, 0};

struct node { // 走到的那个点坐标 和 步数
    int x, y, step;
}cur;
queue<node> q;

void bfs() {
    q.push(node{sx, sy, 0});
    vis[sx][sy] = true;
    while (!q.empty()) {
        cur = q.front();
        q.pop();
        if (cur.x == ex && cur.y == ey) {
            cout << cur.step << endl;
            return ;
        }
        for (int i = 0; i < 4; i++) {
            int nx = cur.x + dx[i];
            int ny = cur.y + dy[i];
            if (vis[nx][ny] || mp[nx][ny] == '1' || nx < 1 || ny < 1 || nx > n || ny > n) {
                continue;
            }
            vis[nx][ny] = true;
            q.push(node{nx, ny, cur.step + 1});
        }
    }
}

int main() {
    cin >> n;
    for (int i = 1; i <= n; i++)
    for (int j = 1; j <= n; j++)
    cin >> mp[i][j];
    cin >> sx >> sy >> ex >> ey;
    bfs();
    return 0;
}
