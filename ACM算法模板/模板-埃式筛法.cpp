// 经典题目 https://www.luogu.com.cn/problem/P5736
#include <bits/stdc++.h>
using namespace std;

bool is_p[1000005]; // 是否是质数 (false表示是质数)
int p[100005]; // 存储质数

int main(){
    int n, k, c = 0;
    cin >> n;
    is_p[0] = is_p[1] = true;
    // 预处理 筛选出质数
    for (int i = 2; i <= 1000000; i++) {
        if (!is_p[i]) { // 是质数 把它的倍数筛掉
            p[++c] = i;
            for (int j = 2 * i; j <= 1000000; j += i) {
                is_p[j] = true;
            }
        }
    }

    for (int i = 1; i <= n; i++) {
        cin >> k;
        if (!is_p[k]) cout << k << " ";
    }
    return 0;
}