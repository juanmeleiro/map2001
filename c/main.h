#define NODE_COUNT 11
#define TREE_SIZE NODE_COUNT
#define QUEUE_SIZE NODE_COUNT

#define True 1
#define False 0
typedef int bool;

#define BitArraySize(n) ((n%32 == 0) ? (n/32) : (((int) n / 32) + 1))

void printArray(int array[], int size);
