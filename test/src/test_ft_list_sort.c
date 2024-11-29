/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   test_ft_list_sort.c                                :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: greus-ro <greus-ro@student.42barcel>       +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/11/29 13:16:23 by greus-ro          #+#    #+#             */
/*   Updated: 2024/11/29 14:52:51 by greus-ro         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */


//Firma void ft_list_sort(t_list **begin_list, int (*cmp)());

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "libft.h"

static t_list *create_node(const char *msg)
{
	t_list	*node;

	node = (t_list *)malloc(sizeof(t_list));
	if (node == NULL)
		return (NULL);
	node->next = NULL;
	node->content = (char *)msg;
	return (node);
}

static void	debug_list(t_list *lst)
{
	t_list	*node;
	node = lst;
	printf("DEBUG List****************************\n");
	if (node == NULL)
		printf("EMPTY\n");
	while (node != NULL)
	{
		printf("\tAddress: %p, content %p val: _%s_\n", node, node->content, (char *)node->content);
		node = node->next;
	}
	printf("END DEBUG List************************\n\n");
}

static void	clear_list(t_list **lst)
{
	t_list *node;
	t_list	*aux;
	
	node = *lst;
	while (node != NULL)
	{
		aux = node;
		node = node->next;
		free (aux);
	}
	*lst = NULL;
}


int main(void)
{

	{
		t_list	*list;
		
		list = NULL;
		//debug_list(list);
		ft_list_sort(&list, strcmp);
		debug_list(list);
		clear_list(&list);
	}

	{
		t_list	*list;
		t_list	*new;
		
		list = NULL;
		new = create_node("Hola mundo!");
		ft_list_push_front(&list, new);
		ft_list_sort(&list, strcmp);
		debug_list(list);
		clear_list(&list);
	}
		{
		t_list	*list;
		t_list	*new;
		
		list = NULL;
		new = create_node("Hola mundo!");
		ft_list_push_front(&list, new);
		new = create_node("Hola mundo!");
		ft_list_push_front(&list, new);
		ft_list_sort(&list, strcmp);
		debug_list(list);
		clear_list(&list);
	}
/*
	{
		t_list	*list;
		t_list	*new;
		
		list = NULL;
		new = create_node("Adios mundo!");
		ft_list_push_front(&list, new);
		new = create_node("Hola mundo!");
		ft_list_push_front(&list, new);
		ft_list_sort(&list, strcmp);
		debug_list(list);
		clear_list(&list);
	}


	{
		t_list	*list;
		t_list	*new;
		
		list = NULL;
		new = create_node("1");
		ft_list_push_front(&list, new);
		new = create_node("21");
		ft_list_push_front(&list, new);
		new = create_node("213");
		ft_list_push_front(&list, new);
        ft_list_sort(&list, strcmp);
        debug_list(list);
		clear_list(&list);
	}
*/

	return (0);
}