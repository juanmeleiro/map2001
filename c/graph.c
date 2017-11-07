#include "main.h"
#include "bitarray.h"
#include "queue.h"
#include "graph.h"
#include <stdio.h>

// A graph is an array of pointers to bit arrays. Each entry i to the graph is a
// list of the adjacency information of the node i with each node before it.

bool adjacent(bit* P[], int i, int j) {
  // Returns True if i is adjacent to j in P, else False
  if (i > j) {
    return get(P[i], j);
  }
  else if (j > i) {
    return get(P[j], i);
  }
  else {
    return False;
  }
}

void search(int root, bit* graph[], int size, int result[]){
  // In the end, 'result' contains a spanning tree rooted on start, where
  // the unique path from any node to start is the shortest possible
  struct Queue Q;
  Q.start = 0;
  Q.end = 0;
  Q.size = NODE_COUNT;

  int visited[NODE_COUNT];
  for (int i = 0; i < NODE_COUNT; i++) visited[i] = False;

  int node;
  printf("Size: %d\n", size);
  enqueue(&Q, root);
  while(!empty(&Q)) {

    printQueue(&Q);printf(" [");printArray(result, NODE_COUNT);printf("] Node: %d;", node);printf(" ");printArray(visited, NODE_COUNT);printf("\n");

    node = dequeue(&Q);

    printf("Node: %d\n", node);

    visited[node] = True;
    for (int neighbor = 0; neighbor < size; neighbor++) {
      printf("  Pondering about %d. adjacent(graph, %d, %d) = %d. visited[%d] = %d.\n", neighbor, node, neighbor, adjacent(graph, node, neighbor), neighbor, visited[neighbor]);
      if (adjacent(graph, node, neighbor)) {
        printf("    %d is adjacent to %d\n", node, neighbor);
        if (!visited[neighbor]) {
          printf("      %d now references %d\n", neighbor, node);
          result[neighbor] = node;
        }
        if (!in(&Q, neighbor) && !visited[neighbor]) {
          printf("      Adding %d to queue\n", neighbor);
          enqueue(&Q, neighbor);
        }
      }
    }
  }
  printf("End of Search.\n");
}

void printGraph(bit* A[], int size ) {
  // Print half of the (symetric) adjecency matrix
  for (int i = 0; i < size; i++) {
    printf("%2d: ", i);
    for (int j = 0; j < size; j++) {
      if (j < i)
        printf("%d ", get(A[i], j));
      else
        printf(". ");
    }
    printf("\n");
  }
}
