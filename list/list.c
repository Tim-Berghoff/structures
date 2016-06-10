#include "list.h"

struct list * new_list(void)
{
	struct list * new_list = malloc(sizeof( *new_list ));
	new_list->first=NULL;
	new_list->last=NULL;
	new_list->size=0;
	return new_list;
}

unsigned int list_add(unsigned int fl, struct list * list, void * value)
{
	struct list_node * new_node = malloc(sizeof( *new_node ));
	if(NULL == new_node)
	{
		return -1;
	}
	new_node->value = value;
	list->size++;
	struct list_node * old_node = (fl) ? list->first : list->last;
	new_node->next  = (fl) ? old_node : NULL;
	new_node->prev  = (fl) ? NULL : old_node;
	if(NULL == old_node)
	{
		list->first = list->last = new_node;
		return 0;
	}
	if(fl)
	{
		list->first = new_node;
		old_node->prev = new_node;
	}
	else
	{
		list->last = new_node;
		old_node->next = new_node;
	}
	return 0;
}

void * list_get(unsigned int fl, struct list * list)
{
	if(fl) return (list->first) ? list->first->value : NULL;
	else   return (list->last) ? list->last->value : NULL;
}

void * list_rem(unsigned int fl, struct list * list)
{
	struct list_node * rem_node = (fl) ? list->first : list->last;
	if(NULL == rem_node)
	{
		return NULL;
	}
	void * ret = rem_node->value;
	struct list_node **node = (fl) ? &list->first : &list->last;
	*node = (fl) ? rem_node->next : rem_node->prev;
	(1 == list->size) ? list->first = list->last = NULL : NULL;
	(fl && list->first) ? list->first->prev = NULL : NULL;
	(!fl && list->last) ? list->last->next = NULL : NULL;
	list->size--;
	free(rem_node);
	return ret;
}

unsigned int list_destruction(unsigned int v, struct list * list)
{
	struct list_node * i, * tmp;
	for(i = list->first; NULL != i; i=tmp, list->size--)
	{
		tmp = i->next;
		if(v) free(i->value);
		free(i);
	}
	free(list);
	return 0;
}
