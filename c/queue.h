#include "main.h"
struct Queue {
  int size;
  int body[QUEUE_SIZE];
  int start;
  int end;
};

int         mod(int x,           int n    );
void    enqueue(struct Queue *Q, int value);
int       empty(struct Queue *Q           );
int     dequeue(struct Queue *Q           );
bool         in(struct Queue *Q, int value);
void printQueue(struct Queue *Q           );
