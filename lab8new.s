	.text
	.global _start
_start:
push {r4, lr}
select:
/* Show select String */
	mov r0, #1 @ stdout  1 = monitor
	ldr r1, =selectfunc @ input string
	mov r2, #52 @ len
	mov r7, #4
	svc 0
// enter choice
	mov r0, #0 @ stdin  0 = keyboard
	ldr r1, =choice @ address of input buffer
	mov r2, #2 @ max. len. of input
	mov r7, #3 @ read
	svc 0
//compare
	ldr r9,=choice
	ldrb r9,[r9,#0]
	cmp r9,#49
	beq inname
	cmp r9,#50
	beq search
	cmp r9,#51
	beq exit

inname:
/* Open (Create) File */
	ldr r0, =newfile
	mov r1, #0x42 @ create R/W
	mov r2, #384 @ = 600 (octal)
	mov r7, #5 @ open (create)
	svc 0
	cmp r0, #-1 @ open error?
	beq err
	mov r4, r0 @ save file descriptor
/* Show Input String */
	mov r0, #1 @ stdout  1 = monitor
	ldr r1, =input @ input string
	mov r2, #(ip_end-input) @ len
	mov r7, #4
	svc 0
/* Read Input String */
	mov r0, #0 @ stdin  0 = keyboard
	ldr r1, =buffer @ address of input buffer
	mov r2, #91 @ max. len. of input
	mov r7, #3 @ read
	svc 0
	mov r5, r0 @ save no. of character
//delete \n 
	ldr r1,=buffer
	mov r9,#32
	sub r5,r5,#1
	strb r9,[r1,r5]
/* lseek */
	mov r0, r4 @ file descriptor
	mov r1, #0 @ position
	mov r2, #2 @ seek_set
	mov r7, #19
	svc 0
/* Write to File */
	mov r0, r4 @ file descriptor
	ldr r1, =buffer @ address of buffer to write
	mov r2, #91 @ length of data to write
	mov r7, #4
	svc 0
/* Close File */
	mov r7, #6 @ close
	svc 0
	mov r0, r4 @ return file descriptor
	b select
search:
	//print
	mov r0, #1 @ stdout  1 = monitor
	ldr r1, =txtselect 
	mov r2, #13 @ len
	mov r7, #4
	svc 0
	//input
	mov r0, #0 @ stdin  0 = keyboard
	ldr r1, =num @ address of num
	mov r2, #8 @ max. len. of input
	mov r7, #3 @ read
	svc 0
	mov r5, r0 @ save no. of character
/* open to read File */
	mov r0, r4 @ file descriptor
	ldr r1, #0 @ address of buffer to write
//	mov r2, # @ length of data to write
	mov r7, #4
	svc 0

	mov r0, r4 @ stdin  0 = keyboard
	ldr r1, =fileread @ address of num
	mov r2, #8 @ max. len. of input
	mov r7, #3 @ read
	svc 0
	mov r5, r0 @ save no. of character



exit: 
	pop {r4, lr}
	mov r7, #1 @ exit
	svc 0
err: 
	mov r4, r0
	mov r0, #1
	ldr r1, =errmsg
	mov r2, #(errmsgend-errmsg)
	mov r7, #4
	svc 0
	mov r0, r4
	b exit
	.data
errmsg: .asciz "create failed"
errmsgend:

newfile: .asciz "/home/pi/Krow/comorg/name"
input: .asciz "Input a name: "
ip_end:
selectfunc: .asciz "Select Function (1):Input name (2):Search (3):Exit\n:"
txtselect: .asciz "Enter number:"
buffer: .asciz "                                                                                          \n"
choice: .ascii ""
num: .asciz ""
fileread: .asciz ""
filereadend:
