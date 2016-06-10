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
	char buff[20], command[20];
	int * value = NULL, val = 0;
	list_get_last(l);

	int * test_return = malloc(test_count * sizeof( * test_return));
	if(NULL == test_return)
	{
		fprintf(stderr, "Could not alloc test return memory\n");
	}
	FILE * fp = fopen(file_name, "r");
	if(NULL == fp)
	{
		fprintf(stderr, "Could not open file\n");
	}
	int i = 0;
	for( ; NULL != fgets(buff, 20, fp) && i < test_count; )
	{
		sscanf(buff, "%s %i", command, &val);

		if(0 == strcmp("rl", command))
		{
			value = list_remove_last(l);
			if(NULL != value) {
				test_return[i++] = *value;
				free(value);
			}
		}
		else if(0 == strcmp("rf", command))
		{
			value = list_remove_first(l);
			if(NULL != value) {
				test_return[i++] = *value;
				free(value);
			}
		}
		else if(0 == strcmp("al", command))
		{
			value = malloc(sizeof( * value));
			*value = val;
			list_add_last(l, value);
		}
		else if(0 == strcmp("af", command))
		{
			value = malloc(sizeof( * value));
			*value = val;
			list_add_first(l, value);
		}
	}
	list_get_first(l);
	list_vdelete(l);
	fclose(fp);

	char * test_output = calloc(test_count * 20, sizeof(*test_output));
	char * p = test_output;
	for(int j = 0; j < i; j++) {
		p += sprintf( p, "%i\n", test_return[j]);
	}

	printf("%s", test_output);

	free(test_return);
	free(test_output);

	return 0;
}
	
