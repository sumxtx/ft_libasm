/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   test_write.c                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: gabriel <gabriel@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/11/21 20:11:07 by gabriel           #+#    #+#             */
/*   Updated: 2024/11/21 20:34:43 by gabriel          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>

#include "libft.h"

int main(void)
{
	{
		char	t[] = "Hola mundo!";
		int		len;
		int		ret;

		len = strlen(t);
		ret = write(STDOUT_FILENO, t, len);
		printf("write res: %d\n", ret);
		ret = ft_write(STDOUT_FILENO,t, len);
		printf("ft_write res: %d\n", ret);
	}
	return (0);
}