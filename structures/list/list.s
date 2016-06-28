	.file	"list.c"
	.text
	.p2align 4,,15
	.globl	new_list
	.type	new_list, @function
new_list:
.LFB23:
	.cfi_startproc
	movl	$24, %esi
	movl	$1, %edi
	jmp	calloc
	.cfi_endproc
.LFE23:
	.size	new_list, .-new_list
	.p2align 4,,15
	.globl	list_add
	.type	list_add, @function
list_add:
.LFB24:
	.cfi_startproc
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	movq	%rdx, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	movq	%rdi, %rbp
	movl	$1, %edi
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movq	%rsi, %rbx
	movl	$24, %esi
	call	calloc
	testq	%rax, %rax
	je	.L5
	movq	16(%rbx), %rdx
	movq	%r12, 16(%rax)
	leaq	1(%rdx), %rcx
	testq	%rdx, %rdx
	movq	%rcx, 16(%rbx)
	je	.L8
	leaq	(%rbx,%rbp,8), %rdx
	xorl	%esi, %esi
	testq	%rbp, %rbp
	sete	%sil
	movq	(%rdx), %rcx
	movq	%rcx, (%rax,%rbp,8)
	movq	%rax, (%rcx,%rsi,8)
	movq	%rax, (%rdx)
	movl	$1, %eax
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L8:
	.cfi_restore_state
	movq	%rax, 8(%rbx)
	movq	%rax, (%rbx)
	movl	$1, %eax
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L5:
	.cfi_restore_state
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	xorl	%eax, %eax
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE24:
	.size	list_add, .-list_add
	.p2align 4,,15
	.globl	list_get
	.type	list_get, @function
list_get:
.LFB25:
	.cfi_startproc
	movq	(%rsi,%rdi,8), %rax
	testq	%rax, %rax
	je	.L11
	movq	16(%rax), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L11:
	xorl	%eax, %eax
	ret
	.cfi_endproc
.LFE25:
	.size	list_get, .-list_get
	.p2align 4,,15
	.globl	list_rem
	.type	list_rem, @function
list_rem:
.LFB26:
	.cfi_startproc
	leaq	(%rsi,%rdi,8), %rcx
	movq	(%rcx), %rdx
	testq	%rdx, %rdx
	je	.L16
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movq	(%rdx,%rdi,8), %rax
	movq	16(%rdx), %rbx
	movq	%rax, (%rcx)
	subq	$1, 16(%rsi)
	je	.L22
	testq	%rax, %rax
	je	.L15
	xorl	%ecx, %ecx
	testq	%rdi, %rdi
	sete	%cl
	movq	$0, (%rax,%rcx,8)
.L15:
	movq	%rdx, %rdi
	call	free
	movq	%rbx, %rax
	popq	%rbx
	.cfi_remember_state
	.cfi_restore 3
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L22:
	.cfi_restore_state
	movq	$0, (%rsi)
	movq	$0, 8(%rsi)
	movq	%rdx, %rdi
	call	free
	movq	%rbx, %rax
	popq	%rbx
	.cfi_restore 3
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L16:
	xorl	%eax, %eax
	ret
	.cfi_endproc
.LFE26:
	.size	list_rem, .-list_rem
	.p2align 4,,15
	.globl	list_destruction
	.type	list_destruction, @function
list_destruction:
.LFB27:
	.cfi_startproc
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	movq	%rsi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movq	8(%rsi), %rbx
	testq	%rbx, %rbx
	je	.L26
	testq	%rdi, %rdi
	je	.L27
	jmp	.L28
	.p2align 4,,10
	.p2align 3
.L37:
	movq	%r12, %rbx
.L27:
	movq	8(%rbx), %r12
	movq	%rbx, %rdi
	call	free
	subq	$1, 16(%rbp)
	testq	%r12, %r12
	jne	.L37
.L26:
	movq	%rbp, %rdi
	call	free
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	movl	$1, %eax
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L38:
	.cfi_restore_state
	movq	%r12, %rbx
.L28:
	movq	16(%rbx), %rdi
	movq	8(%rbx), %r12
	call	free
	movq	%rbx, %rdi
	call	free
	subq	$1, 16(%rbp)
	testq	%r12, %r12
	jne	.L38
	jmp	.L26
	.cfi_endproc
.LFE27:
	.size	list_destruction, .-list_destruction
	.ident	"GCC: (Ubuntu 4.8.4-2ubuntu1~14.04) 4.8.4"
	.section	.note.GNU-stack,"",@progbits
