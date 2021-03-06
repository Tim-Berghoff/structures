#ifndef HEAP
#define HEAP

#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

/* suntactic sugar ... more or less */
#if defined(PRIO_QUEUE)
#define new_prio_queue(x, y, z) new_heap(x, y, z)
#define prio_queue_size(x) heap_size(x)
#define prio_queue_push(x, y) heap_insert(x, y)
#define prio_queue_pop(x) heap_remove(x)
#define prio_queue_peek(x) heap_peek(x)
#define prio_queue_delete(x) heap_destruction(0, x)
#define prio_queue_vdelete(x) heap_destruction(1, x)
#endif

/* typical heap utils */
#define p(x) ((x - 1) / 2)
#define lc(x) (x * 2 + 1)
#define rc(x) (x * 2 + 2)

/* the heap's size */
#define heap_size(x) (x->size)
/* deletes the heap structure */
#define heap_delete(x) heap_destruction(0, x)
/* deletes the heap structure and also it's values */
#define heap_vdelete(x) heap_destruction(1, x)

struct heap {
	void ** array;
	size_t size;
	size_t max_size;
	size_t (* cmp)(const void * a, const void * b);
	size_t (* growth_rate)(const size_t size);
};

/* creates a new heap */
struct heap * new_heap(size_t initial_size,
	size_t (* cmp)(const void * a, const void * b),
	size_t (* growth_rate)(const size_t size));
/* inserts a new element */
/* returns 1 on success 0 on failure */
size_t heap_insert(struct heap * heap, void * value);
/* peek at first element */
void * heap_peek(const struct heap * heap);
/* deletes the first element and returns it's value */
void * heap_remove(struct heap * heap);
/* heap removal util */
/* returns 1 on success 0 on failure */
size_t heap_destruction(size_t v, struct heap * heap);

#endif /* HEAP */
