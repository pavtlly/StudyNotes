// 经典题目 https://www.luogu.com.cn/problem/P1601
#include <bits/stdc++.h>
using namespace std;

// 高精度加法

string s1, s2;
int num1[1000], num2[1000];

int main() {
    cin >> s1 >> s2;
    int n1 = s1.size();
    int n2 = s2.size();
    int n = max(n1, n2);
    // 第一步 将数进行翻转
    reverse(s1.begin(), s1.end()); // 字符串翻转(首地址,尾地址)
    for (int i = 0; i < s1.size(); i++) {
        num1[i] = (s1[i] - '0');
    }
    reverse(s2.begin(), s2.end());
    for (int i = 0; i < s2.size(); i++) {
        num2[i] = (s2[i] - '0');
    }
    for (int i = 0; i < n; i++) {
        if (num1[i] + num2[i] >= 10) {
            num1[i + 1]++;
            num1[i] -= 10;
        }
        num1[i] += num2[i];
    }

    if (num1[n] > 0) cout << num1[n]; // 防止遗漏最高位进位的值
    for (int i = n - 1; i >= 0; i--) {
        cout << num1[i];
    }
    return 0;
}
