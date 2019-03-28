
	.global main
	.func main
main:
	LDR R1, addr_value1 @ Get addr of value1
	VLDR S14, [R1] @ Move value1 into S14
	LDR R1 ,addr_value2
	VLDR S15, [R1]

	VCVT.F64.F32 D5,S14 @ Convert to B64 (double)
	VCVT.F64.F32 D6,S15

	VADD.F32 S13,S14,S15
	VCVT.F64.F32 D7,S13
	
	LDR R0, =string @ point R0 to string
	VMOV R2, R3, D7 @ Load value
	BL printf @ call function	
	
	LDR R1, addr_value1 @ Get addr of value1
	VLDR S14, [R1] @ Move value1 into S14
	LDR R1 ,addr_value2
	VLDR S15, [R1]

	VCVT.F64.F32 D5,S14 @ Convert to B64 (double)
	VCVT.F64.F32 D6,S15
	VSUB.F32 S13,S14,S15
	VCVT.F64.F32 D7,S13

	LDR R0, =string @ point R0 to string
	VMOV R2, R3, D7 @ Load value
	BL printf @ call function

	LDR R1, addr_value1 @ Get addr of value1
	VLDR S14, [R1] @ Move value1 into S14
	LDR R1 ,addr_value2
	VLDR S15, [R1]

	VCVT.F64.F32 D5,S14 @ Convert to B64 (double)
	VCVT.F64.F32 D6,S15
	VMUL.F32 S13,S14,S15
	VCVT.F64.F32 D7,S13

	LDR R0, =string @ point R0 to string
	VMOV R2, R3, D7 @ Load value
	BL printf @ call function
	
	LDR R1, addr_value1 @ Get addr of value1
	VLDR S14, [R1] @ Move value1 into S14
	LDR R1 ,addr_value2
	VLDR S15, [R1]

	VCVT.F64.F32 D5,S14 @ Convert to B64 (double)
	VCVT.F64.F32 D6,S15
	VDIV.F32 S13,S14,S15
	VCVT.F64.F32 D7,S13

	LDR R0, =string @ point R0 to string
	VMOV R2, R3, D7 @ Load value
	BL printf @ call function
	MOV R7, #1 @ Exit Syscall
	SWI 0


	addr_value1: .word value1
	addr_value2: .word value2
	.data
value1: .float 1.54321
value2: .float 2.12345
string: .asciz "Floating point value is: %f\n"
