#include "heap.h"
#include <string.h>

size_t growth_rate(const size_t size)
{
	return size << 1;
}
size_t cmp(const void * a, const void * b)
{
	return *(size_t *)a < *(size_t *)b;
}
size_t heap_print(struct heap * heap)
{
	for(size_t index = 0; index < heap->size; index++)
		printf("index:%lu value:%lu size:%lu\n", index,
			*(size_t *) heap->array[index],  heap->size);
	printf("\n");

	return 0;
}
/* checks the heap property */
size_t check(struct heap * heap)
{
	size_t size = heap->size;
	size_t  err = 0;
	for(register size_t i = 0; i < size; i++) {
		if(lc(i) < size && *(size_t*)heap->array[i] > *(size_t*)heap->array[lc(i)]) err++;
		if(rc(i) < size && *(size_t*)heap->array[i] > *(size_t*)heap->array[rc(i)]) err++;
	}
	return err;
}
int main(int argc, char **argv)
{
	struct heap * heap = new_heap(1000, &cmp, &growth_rate);
	if(NULL == heap) {
		fprintf(stderr, "schlecht gelaufen, Null heap");
		exit(2);
	}
	if(2 != argc) {
		fprintf(stderr, "pls give test count and input file as args\n");
		return -1;
	}
	char * file_name = argv[1];
	char buff[20], command[20];
	size_t  val = 0;

	FILE * fp = fopen(file_name, "r");
	if(NULL == fp)
	{
		fprintf(stderr, "Could not open file %s\n", file_name);
		heap_vdelete(heap);
		exit(2);
	}
	size_t i = 0;
	size_t err = 0, test_count = 0, remove_count = 0;
	size_t average_size = 0;
	void * rem;
	for( ; NULL != fgets(buff, 20, fp); i++)
	{
		average_size += heap->size;

		sscanf(buff, "%s", command);
		sscanf(buff, "%lu", &val);

			// function call (RM)
			if(0 == strncmp(command, "RM", 3)) {
				// NULL is returned when there is an empty heap
				if(NULL != (rem = heap_remove(heap))) {
					free(rem);
					remove_count++;
				}
				continue;
			// checks heap
			} else if(0 == strncmp(command, "CK", 3) ) {
			//	err += check(heap);
				test_count++;
				continue;
			}
			// heap insert
			size_t * n=malloc(sizeof(*n));
			*n = val;
			heap_insert(heap, n);
	}
	fclose(fp);
	printf("%lu:%lu:%lu:%lu", err, test_count, remove_count, average_size/i);
	
	heap_vdelete(heap);
	return 0;
}
