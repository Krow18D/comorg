        .data
        .balign 4
message1: .asciz "Please enter a number : "
        .balign 4
message2: .asciz "I read the number %d\n"
        .balign 4
scan_pattern: .asciz "%d"
        .balign 4
yes: .asciz "Leap\n"
        .balign 4
no: .asciz "Not Leap\n"
        .balign 4
number_read: .word 0
        .balign 4
return: .word 0
        .text
        .global main
        .global printf
        .global scanf
main:
        LDR r1, =return @ r1=&return
        STR lr, [r1] @ *r1=lr
        LDR r0, =message1 @ print message1
        BL printf
        LDR r0, =scan_pattern @ input via scanf
        LDR r1, =number_read
        BL scanf
        LDR r0, =message2
        LDR r1, =number_read
        LDR r1, [r1] @ r1 <- *r1
        BL printf
        ldr r1, =number_read
        ldr r4,[r1]
        ldr r5,[r1]
        ldr r6,[r1]

loop4:
       CMP r4,#4
       BLT check4
        SUB r4,r4,#4
        B loop4
check4:
        cmp r4,#0
        BEQ loop100
        B printno

loop100:
        cmp r5,#100
        BLT check100
        sub r5,r5,#100
        b loop100

check100:
        cmp r5,r4
        bne printyes
        mov r7,#0
        b loop400

loop400:
        cmp r6,#400
        blt check400
        sub r6,r6,#400
        b loop400

check400:
        cmp r7,r6
        beq printyes
        b printno

printyes:
        LDR r0,=yes
        BL printf
        B exit

printno:
       LDR r0,=no
       BL printf
        B exit
exit:
        mov r0,r5
        LDR lr,=return
        LDR lr, [lr]
        BX LR @ swap lr,pc
