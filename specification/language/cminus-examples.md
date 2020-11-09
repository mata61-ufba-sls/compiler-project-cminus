# CMinus Examples

### Programa 1

O programa a seguir recebe dois valores inteiros, calcula o máximo divisor comum entre eles e imprime o resultado na saída.

```
// A program to perform Euclid's
// Algorithm to compute gcd. 

int gcd (int u, int v) {
    if (v == 0) 
      return u ;
    else 
      return gcd(v,u-u/v*v);

    // u-u/v*v == u mod v 
}

void main(void) { 
   int x; int y;
   x = input(); 
   y = input();

   output(gcd(x, y)) ;
}
```

### Programa 2
O programa abaixo recebe como entrada uma lista de 10 valores inteiros, ordena usando _selection sort_, e imprime a lista ordenada na saída.

```
// A program to perform selection sort on a 10 element array.

int x[10];

int minloc(int a[], int low, int high) {
    int i; int x; int k;
    k = low;
    x = a[low];
    i = low + 1;

    while (i < high) {
        if (a[i] < x) {
            x = a[i];
            k = i;
        }
        i = i + 1;
    }
    return k;

}

void sort(int a[], int low, int high) {
    int i;
    int k;
    i = low;

    while (i < high - 1) {
        int t;
        k = minloc(a, i, high);
        t = a[k];
        a[k] = a[i];
        a[i] = t;
        i = i + 1;
    }
}


void main(void) {
    int i;
    i = 0;

    while (i < 10) {
        x[i] = input();
        i = i + 1;
    }

    sort(x, 0, 10);
    
    i = 0;
    while (i < 10) {
        output(x[i]);
        i = i + 1;
    }
}
```
