// 经典题目 https://www.luogu.com.cn/problem/P2142
#include <bits/stdc++.h>
using namespace std;

string s1, s2;
int num1[20000], num2[20000];

int main() {
    cin >> s1 >> s2;
    if (s1 == s2) {
        cout << 0 << endl;
        return 0;
    }
    int n1 = s1.size();
    int n2 = s2.size();
    bool minus = false;
    // 字符串是按照字典序进行比较
    // 首先比较长度  长度相同字典序比较就可以
    if ((n1 < n2) || (n1 == n2 && s1 < s2)) {
        minus = true;
        swap(s1, s2);
        swap(n1, n2);
    }

    int n = max(n1, n2);
    for (int i = 0; i < n1; i++) {
        num1[i] = s1[n1 - 1 - i] - '0';
    }
    for (int i = 0; i < n2; i++) {
        num2[i] = s2[n2 - 1 - i] - '0';
    }
    for (int i = 0; i < n; i++) {
        if (num1[i] - num2[i] < 0) { // 借位
            num1[i + 1] -= 1;
            num1[i] += 10;
        }
        num1[i] = num1[i] - num2[i];
    }
    if (minus) cout << "-";
    bool f = false; // 处理前导0
    for (int i = n - 1; i >= 0; i--) {
        if (num1[i] > 0) f = true;
        if (f) cout << num1[i];
    }
    return 0;
}
