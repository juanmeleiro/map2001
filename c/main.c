#include <stdlib.h>
#include <stdio.h>
#include "main.h"
#include "bitarray.h"
#include "graph.h"

// ============== Print Functions: Debugging ============== //

void printArray(int array[], int size){
  // It does as it says
  for (int i = 0; i < size; i++) if (array[i] < 0) printf(". "); else printf("%d ", array[i]);
}
// :::::::::::::::::::::::::::::::::::::::::::::::::::::::: //

int main() {

  // Vector wich will contain spanning tree.
  // Note that the father node of a node i is path[i].
  // The array starts with -1 everywhere.
  int path[NODE_COUNT];
  for (int i = 0; i < NODE_COUNT; i++) path[i] = -1;

  // Graph, in the form described in 'Graph Stuff'
  bit *graph[NODE_COUNT];
  for (int i = 0; i < NODE_COUNT; i++) {
    graph[i] = malloc(sizeof(int) * BitArraySize(i));
  }

  set(graph[1], 0);
  set(graph[2], 1);
  set(graph[3], 2);
  set(graph[4], 3);
  set(graph[4], 0);
  set(graph[5], 0);
  set(graph[5], 1);
  set(graph[6], 5);
  set(graph[6], 1);
  set(graph[6], 2);
  set(graph[7], 6);
  set(graph[7], 2);
  set(graph[7], 3);
  set(graph[8], 5);
  set(graph[8], 0);
  set(graph[8], 4);
  set(graph[9], 7);
  set(graph[9], 8);
  set(graph[9], 4);
  set(graph[9], 3);
  set(graph[10], 9);
  set(graph[10], 8);
  set(graph[10], 5);
  set(graph[10], 6);
  set(graph[10], 7);

  printGraph(graph, NODE_COUNT);
  printf("Finding shortest path...\n");
  search(0, graph, NODE_COUNT, path);
  printArray(path, NODE_COUNT);
  printf("\n");
}
