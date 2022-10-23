#include <stdio.h>

int find_min(int arr[], int n) {
    int minimal = arr[0];
    int i;
    for (i = 1; i < n; i++) {
        if (arr[i] < minimal) {
            minimal = arr[i];
        }
    }
    return minimal;
}

int main(int argc, char** argv) {
    int arr[10000];
    int ans[10000];
    int i, n;
    scanf("%d", &n);
    while (n <= 0 || n > 10000) {
        printf("0 < size of array < 10000");
        scanf("%d", &n);
    }
    for (i = 0; i < n; i++) {
        scanf("%d", &arr[i]);
    }
    int minimal = find_min(arr, n);
    int ans_size = 0;
    for (i = 0; i < n; i++) {
        if (arr[i] != minimal) {
            ans[ans_size] = arr[i];
            printf("%d", arr[i]);
            printf("\n");
            ans_size++;
        }
    }
}
