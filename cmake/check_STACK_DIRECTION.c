#include <stdio.h>

void check_direction(int* caller_var_ptr)
{
	int callee_var;
	if (caller_var_ptr < &callee_var)
	{
		printf("STACK_GROWS_UPWARD\n");
	}
	else
	{
		printf("STACK_GROWS_DOWNWARD\n");
	}
}

int main()
{
	int main_var;
	check_direction(&main_var);
	return 0;
}
