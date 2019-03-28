
	.global main
	.func main
main:
	SUB SP, SP, #24 @ room for printf
	LDR R1, addr_value1 @ Get addr of values
	VLDR S16, [R1,#0] @ load values into
	VLDR S18, [R1,#4] @ registers
	VLDR S20, [R1,#8]
	VLDR S22, [R1,#12]
	VLDR S24, [R1,#16]
	VLDR S26, [R1,#20]

	LDR R5,addr_value2
	VLDR S17,[R5,#0]
	VLDR S19,[R5,#4]
	VLDR S21,[R5,#8]
	VLDR S23,[R5,#12]
	VLDR S25,[R5,#16]
	VLDR S27,[R5,#20]

@lenstride:
@/* Set LEN=4 0b011 and STRIDE=2 0b11 */
@	VMRS R3, FPSCR @ get current FPSCR
@	MOV R4, #0b110011 @ bit pattern
@	MOV R4, R4, LSL #16 @ move across to b21
@	ORR R3, R3, R4 @ keep all 1's
@	VMSR FPSCR, R3 @ transfer to FPSCR

	VMUL.F32 S1,S16,S17
	VMUL.F32 S2,S18,S21
	VMUL.F32 S3,S20,S25
	VADD.F32 S4,S2,S3
	VADD.F32 S8,S1,S4	@00	
	
	VMUL.F32 S1,S16,S19
	VMUL.F32 S2,S18,S23
	VMUL.F32 S3,S20,S27
	VADD.F32 S4,S2,S3
	VADD.F32 S10,S1,S4	@01

	VMUL.F32 S1,S22,S17
	VMUL.F32 S2,S24,S21
	VMUL.F32 S3,S26,S25
	VADD.F32 S4,S2,S3
	VADD.F32 S12,S1,S4	@10	

	VMUL.F32 S1,S22,S19
	VMUL.F32 S2,S24,S23
	VMUL.F32 S3,S26,S27
	VADD.F32 S4,S2,S3
	VADD.F32 S14,S1,S4	@11
convert:
/* Do conversion for printing, making sure not */
/* to corrupt Sx registers by over writing */
	VCVT.F64.F32 D0, S8
	VCVT.F64.F32 D1, S10
	VCVT.F64.F32 D2, S12
	VCVT.F64.F32 D3, S14
	LDR R0, =string @ set up for printf
	VMOV R2, R3, D0
	VSTR D1, [SP] @ push data on stack
	VSTR D2, [SP, #8]
	VSTR D3, [SP, #16]
	BL printf
	ADD SP, SP, #24 @ restore stack
_exit:
	MOV R0, #0
	MOV R7, #1
	SWI 0

addr_value1: .word matrix1
addr_value2: .word matrix2
	.data
matrix1: .float 1.0, 2.0, 3.0
	.float 4.0, 5.0, 6.0

matrix2: .float 1.0, 1.0
	.float 2.0, 3.0
	.float 5.0, 0.0

@value1: .float 1.0,1.25
	.float 1.5,1.75,2.0
@value2: .float 1.25
@value3: .float 1.50
@value4: .float 1.75
@value5: .float 2.0

string:
.asciz " %.1f     %.1f\n %.1f     %.1f\n"
