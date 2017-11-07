#include <stdio.h>
#include "main.h"
#include "queue.h"

int mod(int x, int n) {
  return (x % n + n) % n;
}

void enqueue(struct Queue *Q, int value) {
  Q->start = mod(Q->start - 1, Q->size);
  Q->body[Q->start] = value;
}

int empty(struct Queue *Q) {
  return Q->start == Q->end;
}

int dequeue(struct Queue *Q) {
  Q->end = mod(Q->end - 1, Q->size);
  int value = Q->body[Q->end];
  return value;
}

bool in(struct Queue *Q, int value) {
  for (int i = Q->start; i != Q->end; i = mod(i+1, Q->size))
    if (Q->body[i] == value)
      return True;
  return False;
}

void printQueue(struct Queue *Q) {
  printf("[");
  int count = 0;
  for (int i = Q->start; i != Q->end; i = mod(i+1, Q->size)) {
    printf("%d, ", Q->body[i]);
    count++;
  }
  if (!empty(Q)) printf("\b\b");
  printf("]");
  for (;count < NODE_COUNT; count++) printf("  ");
  printf(" ");
}
