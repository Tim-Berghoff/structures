[global $new_list]
[section .text]
[align 16]
#line 3 "list.c"
[function $new_list]
$new_list:
#line 4 "list.c"
#line 5 "list.c"
mov rdx,24
mov rcx,1
jmp $calloc
..?X$new_list:
[global $list_add]
[section .text]
[align 16]
#line 9 "list.c"
[function $list_add]
$list_add:
push rbx
[pushreg rbx]
push rsi
[pushreg rsi]
push rdi
[pushreg rdi]
sub rsp,32
[allocstack 32]
[endprolog ..?X$list_add]
mov rbx,rcx
mov rsi,rdx
mov rdi,r8
#line 10 "list.c"
#line 11 "list.c"
mov rdx,24
mov rcx,1
call $calloc
#line 12 "list.c"
test rax,rax
je ..?L33
#line 16 "list.c"
mov qword [rax+(16)],rdi
#line 17 "list.c"
lea rdx,[rsi+(16)]
mov rcx,qword [rdx]
lea r8,[rcx+(1)]
mov qword [rdx],r8
test rcx,rcx
jne ..?L24
#line 18 "list.c"
#line 19 "list.c"
mov qword [rsi+(8)],rax
mov qword [rsi],rax
#line 20 "list.c"
jmp ..?L28
..?L24:
#line 22 "list.c"
#line 23 "list.c"
mov rdx,qword [rsi+rbx*8]
#line 24 "list.c"
mov qword [rax+rbx*8],rdx
#line 25 "list.c"
test rbx,rbx
sete r10b
movzx rcx,r10b
movsxd rcx,ecx
mov qword [rdx+rcx*8],rax
#line 26 "list.c"
mov qword [rsi+rbx*8],rax
#line 27 "list.c"
..?L28:
#line 29 "list.c"
mov rax,1
jmp ..?L21
..?L33:
#line 13 "list.c"
#line 14 "list.c"
xor eax,eax
..?L21:
add rsp,32
pop rdi
pop rsi
pop rbx
ret
..?X$list_add:
[global $list_get]
[section .text]
[align 16]
#line 32 "list.c"
[function $list_get]
$list_get:
#line 33 "list.c"
#line 34 "list.c"
mov rax,qword [rdx+rcx*8]
#line 35 "list.c"
test rax,rax
je ..?L43
mov rax,qword [rax+(16)]
ret
..?L43:
xor eax,eax
..?L41:
ret
..?X$list_get:
[global $list_rem]
[section .text]
[align 16]
#line 38 "list.c"
[function $list_rem]
$list_rem:
push rbx
[pushreg rbx]
sub rsp,32
[allocstack 32]
[endprolog ..?X$list_rem]
#line 39 "list.c"
#line 40 "list.c"
mov rax,qword [rdx+rcx*8]
#line 41 "list.c"
test rax,rax
je ..?L61
#line 45 "list.c"
mov rbx,qword [rax+(16)]
#line 46 "list.c"
mov r8,qword [rax+rcx*8]
#line 47 "list.c"
mov qword [rdx+rcx*8],r8
#line 48 "list.c"
lea r9,[rdx+(16)]
mov r10,qword [r9]
sub r10,1
mov qword [r9],r10
test r10,r10
je ..?L63
#line 52 "list.c"
test r8,r8
je ..?L55
#line 53 "list.c"
#line 54 "list.c"
test rcx,rcx
sete r10b
movzx rcx,r10b
movsxd rcx,ecx
mov qword [r8+rcx*8],0
#line 55 "list.c"
jmp ..?L55
..?L63:
#line 49 "list.c"
#line 50 "list.c"
mov qword [rdx],0
mov qword [rdx+(8)],0
#line 51 "list.c"
..?L55:
#line 56 "list.c"
mov rcx,rax
call $free
#line 57 "list.c"
mov rax,rbx
jmp ..?L50
..?L61:
#line 42 "list.c"
#line 43 "list.c"
xor eax,eax
..?L50:
add rsp,32
pop rbx
ret
..?X$list_rem:
[global $list_destruction]
[section .text]
[align 16]
#line 60 "list.c"
[function $list_destruction]
$list_destruction:
push rbx
[pushreg rbx]
push rsi
[pushreg rsi]
push rdi
[pushreg rdi]
push r12
[pushreg r12]
sub rsp,40
[allocstack 40]
[endprolog ..?X$list_destruction]
mov rbx,rcx
mov rsi,rdx
#line 61 "list.c"
#line 63 "list.c"
mov rdi,qword [rsi+(8)]
test rdi,rdi
je ..?L74
..?L72:
#line 64 "list.c"
#line 65 "list.c"
mov r12,qword [rdi+(8)]
#line 66 "list.c"
test rbx,rbx
je ..?L76
mov rcx,qword [rdi+(16)]
call $free
..?L76:
#line 67 "list.c"
mov rcx,rdi
call $free
#line 68 "list.c"
#line 63 "list.c"
mov rdi,r12
sub qword [rsi+(16)],1
test rdi,rdi
jne ..?L72
..?L74:
#line 69 "list.c"
mov rcx,rsi
call $free
#line 70 "list.c"
mov rax,1
add rsp,40
pop r12
pop rdi
pop rsi
pop rbx
ret
..?X$list_destruction:
[extern $free]
[extern $calloc]
[section .drectve]
db " -defaultlib:crt64"
db " -defaultlib:kernel32"
