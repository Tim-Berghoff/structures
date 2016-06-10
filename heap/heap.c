#include "heap.h"

struct heap * new_heap(unsigned int initial_size,
	unsigned int (* cmp)(const void * a, const void * b),
	unsigned int (* growth_rate)(const unsigned int size))
{
	if( NULL == cmp || NULL == growth_rate || 0 >= initial_size)
	{
		return NULL;
	}
	struct heap * heap = malloc(sizeof( *heap ));
	if(NULL == heap)
	{
		return NULL;
	}
	heap->array = malloc(initial_size * sizeof( *heap->array ));
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
   returns pointer to the freshly allocated mem*/
static unsigned int heap_grow(struct heap * heap)
{
	unsigned int max_size = heap->max_size;
	max_size = max_size * heap->growth_rate(max_size);
	void ** realloc_ret = realloc((void *) heap->array,
		max_size * sizeof( *heap->array ));
	if(NULL != realloc_ret)
	{
		heap->array = realloc_ret;
		heap->max_size = max_size;
	}
	return 0;
}

/* compares two elements in a save way */
static __inline unsigned int s_cmp(struct heap * heap, unsigned int a, unsigned int b)
{
	unsigned int size = heap->size;
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
static __inline unsigned int s_child_cmp(struct heap * heap, unsigned int a)
{
	unsigned int b = a;
	unsigned int left = lc(a);
	unsigned int right = rc(a);
	if(s_cmp(heap, left, b)) b = left;
	if(s_cmp(heap, right, b)) b = right;
	return b;
}
/* swaps two elements */
static __inline unsigned int swap(unsigned int a, unsigned int b, struct heap * heap)
{
	void * tmp = heap->array[a];
	heap->array[a] = heap->array[b];
	heap->array[b] = tmp;

	return 0;
}
/* restores the heap properties
   returns the inserted element's index */
static unsigned int heapify(unsigned int ud, unsigned int index, struct heap * heap)
{
	unsigned int a = index, b = 0;
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

unsigned int heap_insert(struct heap * heap, void * value)
{
	unsigned int size = heap->size;
	unsigned int max_size = heap->max_size;
	if(NULL == heap || NULL == heap->array || NULL == value || size == max_size)
	{
		return -1;
	}
	if( 0 == size )
	{
		heap->array[0] = value;
		return heap->size++;
	}
	if( max_size == size * 2 )
	{
		heap_grow(heap);
	}
	heap->array[size] = value;

	return heapify(0, heap->size++, heap);
}
void * heap_remove(struct heap * heap)
{
	unsigned int size = heap->size;
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

unsigned int heap_destruction(unsigned int v, struct heap * heap)
{
	if(NULL == heap)
	{
		return -1;
	}
	unsigned int size = heap->size;
	if(NULL != heap->array)
	{
		if(v)
		{
			for(unsigned int i = 0; i < size; i++)
			{
				if(NULL != heap->array[i]) free(heap->array[i]);
			}
		}
		free(heap->array);
	}
	free(heap);

	return 0;
}
