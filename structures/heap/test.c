#include "heap.h"
#include <string.h>

unsigned int growth_rate(const unsigned size)
{
	return size << 1;
}
unsigned int cmp(const void * a, const void * b)
{
	return *(unsigned int *)a < *(unsigned int *)b;
}
int heap_print(struct heap * heap)
{
	for(unsigned int index = 0; index < heap->size; index++)
		printf("index:%i value:%i size:%i\n", index,
			*(int *) heap->array[index], (int) heap->size);
	printf("\n");

	return 0;
}
/* checks the heap property */
unsigned int check(struct heap * heap)
{
	unsigned int size = heap->size;
	unsigned int  err = 0;
	for(register unsigned int i = 0; i < size; i++) {
		if(lc(i) < size && *(unsigned int*)heap->array[i] > *(unsigned int*)heap->array[lc(i)]) err++;
		if(rc(i) < size && *(unsigned int*)heap->array[i] > *(unsigned int*)heap->array[rc(i)]) err++;
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
	int  val = 0;

	FILE * fp = fopen(file_name, "r");
	if(NULL == fp)
	{
		fprintf(stderr, "Could not open file %s\n", file_name);
		heap_vdelete(heap);
		exit(2);
	}
	int i = 0;
	int err = 0, test_count = 0, remove_count = 0;
	unsigned long long int average_size = 0;
	void * rem;
	for( ; NULL != fgets(buff, 20, fp); i++)
	{
		average_size += heap->size;

		sscanf(buff, "%s", command);
		sscanf(buff, "%i", &val);

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
			int * n=malloc(sizeof(*n));
			*n = val;
			heap_insert(heap, n);
	}
	fclose(fp);
	printf("%i:%i:%i:%llu", err, test_count, remove_count, average_size/(unsigned long long int)i);
	
	heap_vdelete(heap);
	return 0;
}
