
firmware_wish_riscv.elf:     file format elf32-littleriscv


Disassembly of section .text:

00000000 <__start>:
   0:	004000ef          	jal	4 <pre_main>

00000004 <pre_main>:
   4:	00001117          	auipc	sp,0x1
   8:	ff810113          	add	sp,sp,-8 # ffc <_USER_SP_ADDR>
   c:	00000297          	auipc	t0,0x0
  10:	06028293          	add	t0,t0,96 # 6c <_text_end>
  14:	00001317          	auipc	t1,0x1
  18:	bec30313          	add	t1,t1,-1044 # c00 <z>
  1c:	00001397          	auipc	t2,0x1
  20:	be438393          	add	t2,t2,-1052 # c00 <z>

00000024 <dloop>:
  24:	0002ae03          	lw	t3,0(t0)
  28:	01c32023          	sw	t3,0(t1)
  2c:	00428293          	add	t0,t0,4
  30:	00430313          	add	t1,t1,4
  34:	fe7348e3          	blt	t1,t2,24 <dloop>
  38:	00001317          	auipc	t1,0x1
  3c:	bc830313          	add	t1,t1,-1080 # c00 <z>
  40:	00001397          	auipc	t2,0x1
  44:	bc438393          	add	t2,t2,-1084 # c04 <_bss_end>

00000048 <dloop2>:
  48:	00032023          	sw	zero,0(t1)
  4c:	00430313          	add	t1,t1,4
  50:	fe734ce3          	blt	t1,t2,48 <dloop2>
  54:	0040006f          	j	58 <main>

00000058 <main>:
  58:	000017b7          	lui	a5,0x1
  5c:	00500713          	li	a4,5
  60:	c0e7a023          	sw	a4,-1024(a5) # c00 <z>
  64:	00000513          	li	a0,0
  68:	00008067          	ret

Disassembly of section .bss:

00000c00 <z>:
 c00:	0000                	.2byte	0x0
	...

Disassembly of section .riscv.attributes:

00000000 <.riscv.attributes>:
   0:	3241                	.2byte	0x3241
   2:	0000                	.2byte	0x0
   4:	7200                	.2byte	0x7200
   6:	7369                	.2byte	0x7369
   8:	01007663          	bgeu	zero,a6,14 <pre_main+0x10>
   c:	0028                	.2byte	0x28
   e:	0000                	.2byte	0x0
  10:	1004                	.2byte	0x1004
  12:	7205                	.2byte	0x7205
  14:	3376                	.2byte	0x3376
  16:	6932                	.2byte	0x6932
  18:	7032                	.2byte	0x7032
  1a:	5f31                	.2byte	0x5f31
  1c:	326d                	.2byte	0x326d
  1e:	3070                	.2byte	0x3070
  20:	7a5f 6369 7273      	.byte	0x5f, 0x7a, 0x69, 0x63, 0x73, 0x72
  26:	7032                	.2byte	0x7032
  28:	5f30                	.2byte	0x5f30
  2a:	6d7a                	.2byte	0x6d7a
  2c:	756d                	.2byte	0x756d
  2e:	316c                	.2byte	0x316c
  30:	3070                	.2byte	0x3070
	...

Disassembly of section .comment:

00000000 <.comment>:
   0:	3a434347          	.4byte	0x3a434347
   4:	2820                	.2byte	0x2820
   6:	31202967          	.4byte	0x31202967
   a:	2e32                	.2byte	0x2e32
   c:	2e32                	.2byte	0x2e32
   e:	0030                	.2byte	0x30
