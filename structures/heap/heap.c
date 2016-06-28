#include "heap.h"

struct heap * new_heap(size_t initial_size,
	size_t (* cmp)(const void * a, const void * b),
	size_t (* growth_rate)(const size_t size))
{
	if( NULL == cmp || NULL == growth_rate || 0 == initial_size)
	{
		return NULL;
}
	register struct heap * heap = malloc(sizeof( *heap ));
	if(NULL == heap)
	{
		return heap;
	}
	heap->array = calloc(initial_size , sizeof( *heap->array ));
	if(NULL == heap->array)
	{
		return NULL;
	}
	heap->max_size = initial_size;
	heap->size = 0;
	heap->growth_rate = growth_rate;
	heap->cmp = cmp;

	return heap;
}

/* grows the heap according to growth rate
   maybe use static variables in growth_rate
   returns 1 on success and 0 on error */
static size_t heap_grow(struct heap * heap)
{
	register size_t max_size = heap->max_size;
	max_size = max_size * heap->growth_rate(max_size);
	void ** realloc_ret = realloc((void *) heap->array,
		max_size * sizeof( *heap->array ));
	if(NULL != realloc_ret)
	{
		heap->array = realloc_ret;
		heap->max_size = max_size;
	}
	return 1;
}

/* compares two elements in a save way */
static __inline size_t s_cmp(struct heap * heap, size_t a, size_t b)
{
	size_t size = heap->size;
	if(a >= size || b >= size)
	{
		return 0;
	}
	else
	{
		return heap->cmp(heap->array[a], heap->array[b]);
	}
}
/* compares a node's two children
   returns the right one to potentially swap */
static __inline size_t s_child_cmp(struct heap * heap, size_t a)
{
	size_t b = a;
	size_t left = lc(a);
	size_t right = rc(a);
	if(s_cmp(heap, left, b)) b = left;
	if(s_cmp(heap, right, b)) b = right;
	return b;
}
/* swaps two elements */
static __inline size_t swap(size_t a, size_t b, struct heap * heap)
{
	void * tmp = heap->array[a];
	heap->array[a] = heap->array[b];
	heap->array[b] = tmp;

	return 1;
}
/* restores the heap properties
   returns the inserted element's index */
static __inline size_t heapify(size_t ud, size_t index, struct heap * heap)
{
	size_t a = index, b = 0;
	if(ud)
	{
		for(; a != (b = s_child_cmp(heap, a)); a = b)
		{
			swap(a, b, heap); 
		}
	}
	else
	{
		for(; s_cmp(heap, a, b = p(a)); a = b)
		{
			swap(a, b, heap);
		}
	}
	return a;
}

/* returns 0 on failure and 1 on success */
size_t heap_insert(struct heap * heap, void * value)
{
	size_t size = heap->size;
	size_t max_size = heap->max_size;
	if(NULL == heap || NULL == heap->array
			|| NULL == value || size == max_size)
	{
		return 0;
	}
	else if( 0 == size )
	{
		heap->array[0] = value;
		return ++heap->size;
	}
	else if( max_size == size * 2 )
	{
		heap_grow(heap);
	}
	heap->array[size] = value;

	heapify(0, heap->size++, heap);
	return 1;
}
void * heap_remove(struct heap * heap)
{
	size_t size = heap->size;
	if(NULL == heap || NULL == heap->array || 0 == size)
	{
		return NULL;
	}
	void * ret = heap->array[0];
	heap->array[0] = heap->array[--size];
	heap->array[size] = NULL;
	heap->size = size;
	heap->array = heap->array;
	heapify(1, 0, heap);
	
	return ret;
}

void * heap_peek(const struct heap * heap)
{
	return (NULL != heap->array) ? heap->array[0] : NULL;
}

size_t heap_destruction(size_t v, struct heap * heap)
{
	if(NULL == heap)
	{
		return 0;
	}
	size_t size = heap->size;
	if(NULL != heap->array)
	{
		if(v)
		{
			for(size_t i = 0; i < size; i++)
			{
				if(NULL != heap->array[i]) free(heap->array[i]);
			}
		}
		free(heap->array);
	}
	free(heap);

	return 1;
}
