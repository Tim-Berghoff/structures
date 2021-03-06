#ifndef LIST
#define LIST

#include <stdio.h>
#include <stdlib.h>

/* Use -D QUEUE / STACK if u want to use some syntactic sugar.
   Use list_vdelete
       stack_vdelete (if defined STACK)
       queue_vdelete (if defined STACK)
   in order to delete the structure as well as the values contained.
   If the values are to be kept use ..._delete instead.
   This is an entirely primitive list structure only meant to be
   used as queue or stack. Don't expect more! */

#if defined(QUEUE)
	#define new_queue() new_list()
	#define queue_size(x) list_size(x)
	#define queue(x,y) list_add_last(x, y)
	#define dequeue(x) list_remove_first(x)
	#define queue_peek(x) list_get_first(x)
	#define queue_delete(x) list_delete(x)
	#define queue_vdelete(x) list_vdelete(x)
#endif
#if defined(STACK)
	#define new_stack() new_list()
	#define stack_size(x) list_size(x)
	#define stack_push(x,y) list_add_first(x, y)
	#define stack_pop(x) list_remove_first(x)
	#define stack_peek(x) list_get_first(x)
	#define stack_delete(x) list_delete(x)
	#define stack_vdelete(x) list_vdelete(x)
#endif

/* return the list's element count */
#define list_size(x) x->size
/* deletes our list */
#define list_delete(x) list_destruction(0, x)
/* deletes our list, values inclusive */
#define list_vdelete(x) list_destruction(1, x)
/* adds a new list_node at the beginning,
returns 1 for success and 0 for failure */
#define list_add_first(x, y) list_add(1, x, y)
/* adds a new list_node at the end,
returns 1 for success and 0 for failure */
#define list_add_last(x, y) list_add(0, x, y)
/* gets the list's head,
returns NULL on error or if list is empty*/
#define list_get_first(x) list_get(1, x)
/* gets the list's tail,
returns NULL on error or if list is empty*/
#define list_get_last(x) list_get(0, x)
/* gets the list's head and removes it,
returns NULL on error or if list is empty*/
#define list_remove_first(x) list_rem(1, x)
/* gets the list's tail and removes it,
returns NULL on error or if list is empty*/
#define list_remove_last(x) list_rem(0, x)

struct list {
	struct list_node * fl[2];
	size_t size;
};

struct list_node {
	struct list_node * np[2];
	void * value;
};

/* creates a new list,
returns a pointer to it */
struct list * new_list(void);

/* add util */
/* returns 0 on error, 1 on success */
size_t list_add(size_t fl, struct list * list, void * value);
/* get util */
void * list_get(size_t fl, struct list * list);
/* remove util */
/* returns value on success and NULL on error or empty list */
void * list_rem(size_t fl, struct list * list);
/* deletion util */
size_t list_destruction(size_t v, struct list * list);

#endif /* LIST */
