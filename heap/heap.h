#ifndef HEAP
#define HEAP

#include <stdio.h>
#include <stdlib.h>

/* typical heap utils */
#define p(x) ((x - 1) / 2)
#define lc(x) (x * 2 + 1)
#define rc(x) (x * 2 + 2)

/* deletes the heap structure */
#define heap_delete(x) heap_destruction(0, x)
/* deletes the heap structure and also it's values */
#define heap_vdelete(x) heap_destruction(1, x)

struct heap {
	void ** array;
	unsigned int size;
	unsigned int max_size;
	unsigned int (* cmp)(const void * a, const void * b);
	unsigned int (* growth_rate)(const unsigned int size);
};

/* creates a new heap */
struct heap * new_heap(unsigned int initial_size,
	unsigned int (* cmp)(const void * a, const void * b),
	unsigned int (* growth_rate)(const unsigned int size));
/* inserts a new element
   returns the inserted element's index */
unsigned int heap_insert(struct heap * heap, void * value);
/* deletes the first element and returns it's value */
void * heap_remove(struct heap * heap);
/* heap removal util */
unsigned int heap_destruction(unsigned int v, struct heap * heap);

#endif /* HEAP */
