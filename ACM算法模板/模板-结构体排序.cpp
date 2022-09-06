// 经典题目 https://www.luogu.com.cn/problem/P1093
#include <bits/stdc++.h>
using namespace std;

struct student {
    int c, m, e, sum, id;
};
student p[305];

// 自定义排序规则
bool cmp(student x, student y) {
    if (x.sum == y.sum) {
        if (x.c == y.c) return x.id < y.id;
        else return x.c > y.c;
    } else {
        return x.sum > y.sum;
    }
}

int main() {
    int n;
    cin >> n;
    for (int i = 1; i <= n; i++) {
        cin >> p[i].c >> p[i].m >> p[i].e;
        p[i].sum = p[i].c + p[i].m + p[i].e;
        p[i].id = i;
    }
    sort(p + 1, p + 1 + n, cmp);
    for (int i = 1; i <= 5; i++) {
        cout << p[i].id << " " << p[i].sum << endl;
    }
    return 0;
}