#include <stdio.h>
#include "bitarray.h"

void set(bit A[], int k) {
  // Set the bit at the k-th position in A[i]
  A[k/32] |= 1 << (k%32);
}

void clear(bit A[], int k) {
  // Clear the bit at the k-th position in A[i]
  A[k/32] &= ~(1 << (k%32));
}

int get(bit A[], int k) {
  // Read the bit at the k-th position in A[i]
  if (A[k/32] & (1 << (k%32)))
    return 1;
  else
    return 0;
}

void printBinaryArray(bit A[], int size) {
  printf("[");
  for (int i = 0; i < size; i++) {
    printf("%d,", get(A, i));
  }
  if (size > 0) printf("\b");
  printf("]");
}
