#include "list.h"

struct list * new_list(void)
{
	struct list * new_list = calloc(1, sizeof( *new_list ));
	return new_list;
}

unsigned int list_add(unsigned int fl, struct list * list, void * value)
{
	struct list_node * new_node = calloc(1, sizeof( *new_node ));
	if(NULL == new_node)
	{
		return 0;
	}
	new_node->value = value;
	if(0 == list->size++)
	{
		list->fl[0] = list->fl[1] = new_node;
	}
	else
	{
		struct list_node * old_node = list->fl[fl];
		new_node->np[fl] = old_node;
		list->fl[fl] = new_node;
		old_node->np[!fl] = new_node;
	}

	return 1;
}

void * list_get(unsigned int fl, struct list * list)
{
	struct list_node * node = list->fl[fl];
	return ( NULL != node ) ? node->value : NULL;
}

void * list_rem(unsigned int fl, struct list * list)
{
	struct list_node * rem_node = list->fl[fl];
	if(NULL == rem_node)
	{
		return NULL;
	}
	void * ret = rem_node->value;
	struct list_node * new = rem_node->np[fl];
	list->fl[fl] = new;
	if(0 == --list->size)
	{
		list->fl[1] = list->fl[0] = NULL;
	}
	else if(NULL != new)
	{
		new->np[!fl] = NULL;
	}
	free(rem_node);
	return ret;
}

unsigned int list_destruction(unsigned int v, struct list * list)
{
	struct list_node * i, * tmp;
	for(i = list->fl[1]; NULL != i; i=tmp, list->size--)
	{
		tmp = i->np[1];
		if(v) free(i->value);
		free(i);
	}
	free(list);
	return 1;
}
