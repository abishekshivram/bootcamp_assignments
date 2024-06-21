	.global _USER_SP_ADDR

	.equ stack_addr, _USER_SP_ADDR
	.section .text.entrypoint
	.global __start

__start:
	jal ra, pre_main
#__mtvec_init:
#    nop

pre_main:
	la sp, stack_addr
#	la t0, __mtvec_init
#	csrw mtvec, t0
#	li t1, 0xFFFF0800
#	csrw mie, t1

	la t0, _text_end
	la t1, _data_start
	la t2, _data_end

dloop:
	lw t3, (t0)
	sw t3, (t1)
	addi t0, t0, 4
	addi t1, t1, 4
	blt t1, t2, dloop

	la t1, _bss_start
	la t2, _bss_end
dloop2:
	sw x0, (t1)
	addi t1, t1, 4
	blt t1, t2, dloop2

	j main

