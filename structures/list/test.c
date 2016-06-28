#include "list.h"
#include <string.h>

int main(int argc, char **argv)
{
	if(3 != argc) {
		fprintf(stderr, "pls give test count and input file as args\n");
		return -1;
	}
	char * file_name = argv[2];
	int test_count = atoi(argv[1]);
	struct list * l = new_list();
	char buff[30], command[30];
	size_t * value = NULL, val = 0;

	char * test_output = calloc(test_count * 30, sizeof( *test_output));
	char * p = test_output;
	if(NULL == test_output)
	{
		fprintf(stderr, "Could not alloc test return memory\n");
	}
	FILE * fp = fopen(file_name, "r");
	if(NULL == fp)
	{
		fprintf(stderr, "Could not open file\n");
	}
	int i = 0;
	size_t a_ret = 0;
	for( ; NULL != fgets(buff, 30, fp) && i < test_count; value = NULL)
	{
		sscanf(buff, "%s%llu", command, &val);

		if(0 == strcmp("rl", command))
		{
			value = list_remove_last(l);
			if(NULL != value) {
				p += sprintf( p, "rl:%llu\n", *value);
				free(value);
			} else {
				p += sprintf( p, "rl:empty\n");
			}
		}
		else if(0 == strcmp("rf", command))
		{
			value = list_remove_first(l);
			if(NULL != value) {
				p += sprintf( p, "rf:%llu\n", *value);
				free(value);
			} else {
				p += sprintf( p, "rf:empty\n");
			}
		}
		else if(0 == strcmp("al", command))
		{
			value = calloc(1, sizeof( * value));
			*value = val;
			a_ret = list_add_last(l, value);
			if(0 == a_ret) fprintf(stderr, "ERROR add first\n"); 
		}
		else if(0 == strcmp("af", command))
		{
			value = calloc(1, sizeof( * value));
			*value = val;
			a_ret = list_add_first(l, value);
			if(0 == a_ret) fprintf(stderr, "ERROR add last\n"); 
		}
	}
	list_vdelete(l);
	fclose(fp);

	printf("%s", test_output);

	free(test_output);

	return 0;
}
	
