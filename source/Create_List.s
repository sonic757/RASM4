@ Create_List function
@ Outputs:      r0 = Address of the first node in linked list
@ Purpose:      creates an empty linked list head 

	.data
						
	.global			Create_List		
																											
	.text

Create_List:
    
    push {r4-r8, r10, r11}      @ push preserved registers for aapcs
    push {sp}                   @ push stack pointer
    
    mov	r0, #8			@ move 8 into r0 
    bl 	malloc			@ allocate memory for the first node, the head with a null prev and null next
    
    pop	{sp}                    @ pop stack pointer
    pop	{r4-r8, r10, r11}       @ pop the preserved regiesters for aapcs
    bx      lr    	            @ back to the main where it is called

    .end