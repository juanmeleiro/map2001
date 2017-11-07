# Documentação

## `bitarray`

`typedef unsigned int bit;`: Como forma de abreviação, ja que bit-arays na verdade são `unsigned int` arrays.

`void set(bit A[], int k);`: Torna `1` o bit na posição `k` do vetor `A`

`void clear(bit A[], int k);`: Torna `0` o bit na posição `k` do vetor `A`

`int get(bit A[], int k);`: Returna o valor do bit na posição `k` do vetor `A`

`void printBinaryArray(bit A[], int size);`: Manda para `stdout` uma representação gráfica de `A`.

## `queue`

`struct Queue`: A estrutura de dados que age como fila

`int mod(int x, int n );`: Função utilitaria. É o valor absoluto de x%n.

`void enqueue(struct Queue *Q, int value);`: Adiciona à fila `Q` o valor `value`.

`int empty(struct Queue *Q );`: Retorna `True` se a fila esta vazia, `False` caso contrário.
`int dequeue(struct Queue *Q );`: Retorna o próximo valor da fila e o retira dela.
`bool in(struct Queue *Q, int value);`: Returna `True` se `value` está em `Q`, `False` caso contrário.
`void printQueue(struct Queue *Q );` Manda para `stdout` uma representação gráfica de `Q`.

## `graph`

Note que um grafo tempo tipo `bit*`, pois é uma matriz de adjacencia.

`bool adjacent(bit* P[], int i, int j);`: Returna `True` se `i` é adjacente a `j` em `P`

`void search(int start, bit* graph[], int size, int result[]);`: Guarda em `result` uma _spanning-tree_ de `graph` com raiz em `start`, de forma que os caminhos únicos de cada nó à raiz sejam os mais curtos possíveis.

`void printGraph(bit* A[], int size);`: Manda para `stdout` uma representação gráfica de `A`
