@ Add_String_keyboard function
@ Inputs:	r0 = Address of the string to add
@		r1 = Address of last node
@ Outputs:      r0 = Address of the new node in linked list
@ Purpose:      creates an empty linked list head 

	.data
						
	.global			Add_String_keyboard		
																											
	.text

Add_String_keyboard:
    
	push	{r4-r8, r10, r11}      @ push preserved registers for aapcs
	push 	{sp}                   @ push stack pointer
	push	{lr}			@preserve the link register for recursion
    
	mov	r6, r0			@ move address of string into r6
	
	push	{r1-r8, r10, r11}       @ preserved registers
	bl	String_Length		@ call string length
	pop	{r1-r8, r10, r11}       @ pop registers
	mov	r5, r0		@moving length into r5
	
	add	r0, r0, #8	@adding 8 to string length

	add	r0, r0, #4	@increse memory alocation by 4 more bytes

	push	{r1-r8, r10, r11}       @ preserved registers
	bl 	malloc			@ allocate memory to store string and next/prev addresses
	pop	{r1-r8, r10, r11}       @ pop registers

	mov	r4, #0		@setting temp count to 0
	mov	r7, #0x00000000	@setting r7 to 0
				
	mov	r3, r1		@ load address of last node
	str	r3, [r0]	@storing prev address to our new node
	
	str	r0, [r1, #4]	@store our current node address to prev node next
	str	r7, [r0, #4]	@store next of our current to be null
	
	mov		r2, #0		@setting count to 0
	mov 	r4, #8		@setting offset for copy

copy:
	ldrb	r3, [r6, r2]	@loading string byte offset by r4
	strb	r3, [r0, r4]	@storing string byte in new node offset by r2

	add	r2, #1		@increment counter by 1
	add 	r4, #1		@increment offset of node by 1

	cmp	r2, r5		@compare count to total length
	blt	copy		@if less then jump to copy

	mov	r3, #10		@newline character
	strb	r3, [r0, r4]	@store newline

	add	r4, #1		@add for newline
	ldrb	r3, [r6, r2]	@loading null ptr into r3
	strb	r3, [r0, r4]	@storing null ptr

	pop	{lr}					@preservs the link register for recursion
	pop	{sp}                    @ pop stack pointer
	pop	{r4-r8, r10, r11}       @ pop the preserved regiesters for aapcs

	bx      lr    	            @ back to the main where it is called

    .end
