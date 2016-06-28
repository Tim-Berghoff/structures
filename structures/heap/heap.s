	.file	"heap.c"
	.text
	.p2align 4,,15
	.globl	new_heap
	.type	new_heap, @function
new_heap:
.LFB23:
	.cfi_startproc
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	movq	%rsi, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	subq	$8, %rsp
	.cfi_def_cfa_offset 48
	testq	%rsi, %rsi
	je	.L5
	testq	%rdx, %rdx
	movq	%rdx, %r13
	je	.L5
	testq	%rdi, %rdi
	movq	%rdi, %rbp
	je	.L5
	movl	$40, %edi
	call	malloc
	testq	%rax, %rax
	movq	%rax, %rbx
	je	.L5
	movl	$8, %esi
	movq	%rbp, %rdi
	call	calloc
	testq	%rax, %rax
	movq	%rax, (%rbx)
	je	.L5
	movq	%rbp, 16(%rbx)
	movq	%r13, 32(%rbx)
	movq	%rbx, %rax
	movq	%r12, 24(%rbx)
	movq	$0, 8(%rbx)
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L5:
	.cfi_restore_state
	addq	$8, %rsp
	.cfi_def_cfa_offset 40
	xorl	%eax, %eax
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE23:
	.size	new_heap, .-new_heap
	.p2align 4,,15
	.globl	heap_insert
	.type	heap_insert, @function
heap_insert:
.LFB29:
	.cfi_startproc
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	pushq	%r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	pushq	%rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	movq	(%rdi), %rax
	movq	%rdi, %rbx
	movq	8(%rdi), %rbp
	movq	16(%rdi), %rcx
	testq	%rax, %rax
	je	.L26
	testq	%rsi, %rsi
	movq	%rsi, %r12
	je	.L26
	cmpq	%rcx, %rbp
	je	.L26
	testq	%rbp, %rbp
	je	.L30
	leaq	(%rbp,%rbp), %r13
	movq	%rbp, %rdx
	cmpq	%rcx, %r13
	je	.L31
.L20:
	movq	%r12, (%rax,%rbp,8)
	leaq	-1(%rdx), %rbp
	leaq	1(%rdx), %rax
	shrq	%rbp
	movq	%rax, 8(%rbx)
	cmpq	%rbp, %rax
	ja	.L32
	.p2align 4,,10
	.p2align 3
.L22:
	movl	$1, %eax
	.p2align 4,,10
	.p2align 3
.L34:
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	popq	%rbp
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L26:
	.cfi_restore_state
	xorl	%eax, %eax
.L18:
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	popq	%rbp
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L32:
	.cfi_restore_state
	cmpq	%rdx, %rax
	jbe	.L22
	jmp	.L23
	.p2align 4,,10
	.p2align 3
.L33:
	cmpq	%rbp, %rdx
	jbe	.L22
	movq	%rbp, %rdx
	movq	%rax, %rbp
.L23:
	movq	(%rbx), %rax
	leaq	0(,%rdx,8), %r12
	movq	(%rax,%rbp,8), %rsi
	movq	(%rax,%rdx,8), %rdi
	call	*24(%rbx)
	testq	%rax, %rax
	je	.L22
	movq	(%rbx), %rdx
	leaq	(%rdx,%r12), %rax
	movq	(%rdx,%rbp,8), %rdx
	movq	(%rax), %rcx
	movq	%rdx, (%rax)
	movq	(%rbx), %rax
	movq	8(%rbx), %rdx
	movq	%rcx, (%rax,%rbp,8)
	leaq	-1(%rbp), %rax
	shrq	%rax
	cmpq	%rdx, %rax
	jb	.L33
	movl	$1, %eax
	jmp	.L34
	.p2align 4,,10
	.p2align 3
.L30:
	movq	%rsi, (%rax)
	movq	$1, 8(%rdi)
	movl	$1, %eax
	jmp	.L18
	.p2align 4,,10
	.p2align 3
.L31:
	movq	%r13, %rdi
	call	*32(%rbx)
	movq	%rax, %r14
	movq	(%rbx), %rdi
	imulq	%r13, %r14
	leaq	0(,%r14,8), %rsi
	call	realloc
	testq	%rax, %rax
	je	.L35
	movq	%rax, (%rbx)
	movq	%r14, 16(%rbx)
	movq	8(%rbx), %rdx
	jmp	.L20
.L35:
	movq	(%rbx), %rax
	movq	8(%rbx), %rdx
	jmp	.L20
	.cfi_endproc
.LFE29:
	.size	heap_insert, .-heap_insert
	.p2align 4,,15
	.globl	heap_remove
	.type	heap_remove, @function
heap_remove:
.LFB30:
	.cfi_startproc
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	xorl	%eax, %eax
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	pushq	%r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	movq	%rdi, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	movq	(%rdi), %rcx
	movq	8(%rdi), %rdx
	testq	%rcx, %rcx
	je	.L37
	testq	%rdx, %rdx
	je	.L37
	subq	$1, %rdx
	movq	(%rcx), %r13
	xorl	%ebp, %ebp
	movq	(%rcx,%rdx,8), %rax
	movq	%rax, (%rcx)
	movq	(%rdi), %rax
	movq	$0, (%rax,%rdx,8)
	movq	%rdx, 8(%rdi)
	jmp	.L38
	.p2align 4,,10
	.p2align 3
.L45:
	movq	%rbp, %rbx
.L39:
	cmpq	%r14, %rdx
	ja	.L49
.L41:
	cmpq	%rbx, %rbp
	je	.L50
.L42:
	movq	(%r12), %rdx
	leaq	(%rdx,%rbp,8), %rax
	movq	(%rdx,%rbx,8), %rdx
	movq	%rbx, %rbp
	movq	(%rax), %rcx
	movq	%rdx, (%rax)
	movq	(%r12), %rax
	movq	8(%r12), %rdx
	movq	%rcx, (%rax,%rbx,8)
.L38:
	leaq	(%rbp,%rbp), %rcx
	cmpq	%rdx, %rbp
	setnb	%al
	leaq	1(%rcx), %rbx
	leaq	2(%rcx), %r14
	cmpq	%rbx, %rdx
	jbe	.L45
	testb	%al, %al
	jne	.L45
	movq	(%r12), %rax
	movq	(%rax,%rbp,8), %rsi
	movq	(%rax,%rbx,8), %rdi
	call	*24(%r12)
	testq	%rax, %rax
	movq	8(%r12), %rdx
	je	.L51
	cmpq	%rbx, %rdx
	setbe	%al
	cmpq	%r14, %rdx
	jbe	.L41
.L49:
	testb	%al, %al
	jne	.L41
	movq	(%r12), %rax
	movq	(%rax,%rbx,8), %rsi
	movq	(%rax,%r14,8), %rdi
	call	*24(%r12)
	testq	%rax, %rax
	cmovne	%r14, %rbx
	cmpq	%rbx, %rbp
	jne	.L42
.L50:
	movq	%r13, %rax
.L37:
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	popq	%rbp
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	ret
.L51:
	.cfi_restore_state
	cmpq	%rdx, %rbp
	movq	%rbp, %rbx
	setnb	%al
	jmp	.L39
	.cfi_endproc
.LFE30:
	.size	heap_remove, .-heap_remove
	.p2align 4,,15
	.globl	heap_peek
	.type	heap_peek, @function
heap_peek:
.LFB31:
	.cfi_startproc
	movq	(%rdi), %rax
	testq	%rax, %rax
	je	.L54
	movq	(%rax), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L54:
	xorl	%eax, %eax
	ret
	.cfi_endproc
.LFE31:
	.size	heap_peek, .-heap_peek
	.p2align 4,,15
	.globl	heap_destruction
	.type	heap_destruction, @function
heap_destruction:
.LFB32:
	.cfi_startproc
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	testq	%rsi, %rsi
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	movq	%rsi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	je	.L61
	movq	(%rsi), %rax
	movq	8(%rsi), %r12
	testq	%rax, %rax
	je	.L57
	testq	%rdi, %rdi
	je	.L58
	testq	%r12, %r12
	je	.L58
	xorl	%ebx, %ebx
	.p2align 4,,10
	.p2align 3
.L60:
	movq	(%rax,%rbx,8), %rdi
	testq	%rdi, %rdi
	je	.L59
	call	free
	movq	0(%rbp), %rax
.L59:
	addq	$1, %rbx
	cmpq	%r12, %rbx
	jne	.L60
.L58:
	movq	%rax, %rdi
	call	free
.L57:
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
.L61:
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
.LFE32:
	.size	heap_destruction, .-heap_destruction
	.ident	"GCC: (Ubuntu 4.8.4-2ubuntu1~14.04) 4.8.4"
	.section	.note.GNU-stack,"",@progbits
