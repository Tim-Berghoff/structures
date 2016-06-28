[global $new_heap]
[section .text]
[align 16]
#line 3 "heap.c"
[function $new_heap]
$new_heap:
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
[endprolog ..?X$new_heap]
mov rbx,rcx
mov rsi,rdx
mov rdi,r8
#line 6 "heap.c"
#line 7 "heap.c"
test rsi,rsi
je ..?L31
test rdi,rdi
je ..?L31
test rbx,rbx
je ..?L31
#line 11 "heap.c"
mov rcx,40
call $malloc
mov r12,rax
#line 12 "heap.c"
test r12,r12
je ..?L29
#line 16 "heap.c"
mov rdx,8
mov rcx,rbx
call $calloc
mov qword [r12],rax
#line 17 "heap.c"
cmp qword [r12],0
jne ..?L23
..?L31:
#line 18 "heap.c"
#line 19 "heap.c"
xor eax,eax
jmp ..?L16
..?L29:
#line 13 "heap.c"
#line 14 "heap.c"
mov rax,r12
jmp ..?L16
..?L23:
#line 21 "heap.c"
mov qword [r12+(16)],rbx
#line 22 "heap.c"
mov qword [r12+(8)],0
#line 23 "heap.c"
mov qword [r12+(32)],rdi
#line 24 "heap.c"
mov qword [r12+(24)],rsi
#line 26 "heap.c"
mov rax,r12
..?L16:
add rsp,40
pop r12
pop rdi
pop rsi
pop rbx
ret
..?X$new_heap:
[section .text]
[align 16]
	#line 32 "heap.c"
	[function $heap_grow]
$heap_grow:
push rbx
[pushreg rbx]
push rsi
[pushreg rsi]
sub rsp,40
[allocstack 40]
[endprolog ..?X$heap_grow]
mov rbx,rcx
#line 33 "heap.c"
#line 34 "heap.c"
mov rsi,qword [rbx+(16)]
#line 35 "heap.c"
mov rcx,rsi
call qword [rbx+(32)]
imul rsi,rax
#line 36 "heap.c"
lea rdx,[rsi*8]
mov rcx,qword [rbx]
call $realloc
#line 38 "heap.c"
test rax,rax
je ..?L44
#line 39 "heap.c"
#line 40 "heap.c"
mov qword [rbx],rax
#line 41 "heap.c"
mov qword [rbx+(16)],rsi
#line 42 "heap.c"
..?L44:
#line 43 "heap.c"
mov rax,1
add rsp,40
pop rsi
pop rbx
ret
..?X$heap_grow:
[global $heap_insert]
[section .text]
[align 16]
#line 102 "heap.c"
[function $heap_insert]
$heap_insert:
push rbx
[pushreg rbx]
push rsi
[pushreg rsi]
push rdi
[pushreg rdi]
push r12
[pushreg r12]
push r13
[pushreg r13]
sub rsp,32
[allocstack 32]
[endprolog ..?X$heap_insert]
mov rbx,rcx
mov rsi,rdx
#line 103 "heap.c"
#line 104 "heap.c"
mov rdi,qword [rbx+(8)]
#line 105 "heap.c"
mov rax,qword [rbx+(16)]
#line 106 "heap.c"
test rbx,rbx
je ..?L83
cmp qword [rbx],0
je ..?L83
test rsi,rsi
je ..?L83
cmp rdi,rax
je ..?L83
#line 110 "heap.c"
test rdi,rdi
je ..?L133
#line 115 "heap.c"
lea rdx,[rdi+rdi]
cmp rdx,rax
jne ..?L86
#line 116 "heap.c"
#line 117 "heap.c"
mov rcx,rbx
call $heap_grow
#line 118 "heap.c"
..?L86:
#line 119 "heap.c"
mov rax,qword [rbx]
mov qword [rax+rdi*8],rsi
#line 121 "heap.c"
lea rax,[rbx+(8)]
mov rdx,qword [rax]
lea rcx,[rdx+(1)]
mov qword [rax],rcx
mov rdi,rdx
jmp ..?L99
..?L100:
mov rax,qword [rbx]
mov rax,qword [rax+rdi*8]
mov rdx,qword [rbx]
mov rcx,qword [rdx+r12*8]
mov qword [rdx+rdi*8],rcx
mov rdx,qword [rbx]
mov qword [rdx+r12*8],rax
mov rdi,r12
..?L99:
lea rax,[rdi-(1)]
shr rax,1
mov r12,rax
mov rdx,qword [rbx+(8)]
cmp rdi,rdx
jae ..?L122
cmp rax,rdx
jb ..?L123
..?L122:
xor r13,r13
jmp ..?L124
..?L123:
mov rdx,qword [rbx]
mov rdx,qword [rdx+rax*8]
mov rax,qword [rbx]
mov rcx,qword [rax+rdi*8]
call qword [rbx+(24)]
mov r13,rax
..?L124:
test r13,r13
jne ..?L100
#line 122 "heap.c"
mov rax,1
jmp ..?L81
..?L83:
#line 107 "heap.c"
#line 108 "heap.c"
xor eax,eax
jmp ..?L81
..?L133:
#line 111 "heap.c"
#line 112 "heap.c"
mov rax,qword [rbx]
mov qword [rax],rsi
#line 113 "heap.c"
add rbx,8
mov rax,qword [rbx]
add rax,1
mov qword [rbx],rax
..?L81:
add rsp,32
pop r13
pop r12
pop rdi
pop rsi
pop rbx
ret
..?X$heap_insert:
[global $heap_remove]
[section .text]
[align 16]
#line 124 "heap.c"
[function $heap_remove]
$heap_remove:
push rbx
[pushreg rbx]
push rsi
[pushreg rsi]
push rdi
[pushreg rdi]
push r12
[pushreg r12]
push r13
[pushreg r13]
push r14
[pushreg r14]
push r15
[pushreg r15]
sub rsp,48
[allocstack 48]
[endprolog ..?X$heap_remove]
mov rbx,rcx
#line 125 "heap.c"
#line 126 "heap.c"
mov rax,qword [rbx+(8)]
#line 127 "heap.c"
test rbx,rbx
je ..?L176
cmp qword [rbx],0
je ..?L176
test rax,rax
je ..?L176
#line 131 "heap.c"
mov rdx,qword [rbx]
mov rdx,qword [rdx]
mov qword [rsp+(32)],rdx
#line 132 "heap.c"
sub rax,1
mov rdx,qword [rbx]
mov rcx,qword [rdx+rax*8]
mov qword [rdx],rcx
#line 133 "heap.c"
mov rdx,qword [rbx]
mov qword [rdx+rax*8],0
#line 134 "heap.c"
mov qword [rbx+(8)],rax
#line 135 "heap.c"
#line 136 "heap.c"
xor esi,esi
jmp ..?L181
..?L182:
mov rax,qword [rbx]
mov rax,qword [rax+rsi*8]
mov rdx,qword [rbx]
mov rcx,qword [rdx+rdi*8]
mov qword [rdx+rsi*8],rcx
mov rdx,qword [rbx]
mov qword [rdx+rdi*8],rax
mov rsi,rdi
..?L181:
mov r12,rsi
lea r13,[1+rsi*2]
lea r14,[2+rsi*2]
mov rax,qword [rbx+(8)]
cmp r13,rax
jae ..?L194
cmp r12,rax
jb ..?L195
..?L194:
xor r15,r15
jmp ..?L196
..?L195:
mov rax,qword [rbx]
mov rdx,qword [rax+r12*8]
mov rax,qword [rbx]
mov rcx,qword [rax+r13*8]
call qword [rbx+(24)]
mov r15,rax
..?L196:
test r15,r15
cmovne r12,r13
..?L190:
mov rax,qword [rbx+(8)]
cmp r14,rax
jae ..?L199
cmp r12,rax
jb ..?L200
..?L199:
xor r13,r13
jmp ..?L201
..?L200:
mov rax,qword [rbx]
mov rdx,qword [rax+r12*8]
mov rax,qword [rbx]
mov rcx,qword [rax+r14*8]
call qword [rbx+(24)]
mov r13,rax
..?L201:
test r13,r13
cmovne r12,r14
..?L191:
mov rdi,r12
cmp rsi,r12
jne ..?L182
#line 138 "heap.c"
mov rax,qword [rsp+(32)]
jmp ..?L174
..?L176:
#line 128 "heap.c"
#line 129 "heap.c"
xor eax,eax
..?L174:
add rsp,48
pop r15
pop r14
pop r13
pop r12
pop rdi
pop rsi
pop rbx
ret
..?X$heap_remove:
[global $heap_peek]
[section .text]
[align 16]
#line 141 "heap.c"
[function $heap_peek]
$heap_peek:
#line 142 "heap.c"
#line 143 "heap.c"
cmp qword [rcx],0
je ..?L258
mov rax,qword [rcx]
mov rax,qword [rax]
ret
..?L258:
xor eax,eax
..?L256:
ret
..?X$heap_peek:
[global $heap_destruction]
[section .text]
[align 16]
#line 146 "heap.c"
[function $heap_destruction]
$heap_destruction:
push rbx
[pushreg rbx]
push rsi
[pushreg rsi]
push rdi
[pushreg rdi]
sub rsp,32
[allocstack 32]
[endprolog ..?X$heap_destruction]
mov rbx,rdx
#line 147 "heap.c"
#line 148 "heap.c"
test rbx,rbx
je ..?L277
#line 152 "heap.c"
mov rsi,qword [rbx+(8)]
#line 153 "heap.c"
cmp qword [rbx],0
je ..?L267
#line 154 "heap.c"
#line 155 "heap.c"
test rcx,rcx
je ..?L268
#line 156 "heap.c"
#line 157 "heap.c"
test rsi,rsi
jbe ..?L268
xor edi,edi
..?L269:
#line 158 "heap.c"
#line 159 "heap.c"
mov rax,qword [rbx]
cmp qword [rax+rdi*8],0
je ..?L273
mov rax,qword [rbx]
mov rcx,qword [rax+rdi*8]
call $free
..?L273:
#line 160 "heap.c"
#line 157 "heap.c"
add rdi,1
cmp rdi,rsi
jb ..?L269
#line 161 "heap.c"
..?L268:
#line 162 "heap.c"
mov rcx,qword [rbx]
call $free
#line 163 "heap.c"
..?L267:
#line 164 "heap.c"
mov rcx,rbx
call $free
#line 166 "heap.c"
mov rax,1
jmp ..?L265
..?L277:
#line 149 "heap.c"
#line 150 "heap.c"
xor eax,eax
..?L265:
add rsp,32
pop rdi
pop rsi
pop rbx
ret
..?X$heap_destruction:
[extern $realloc]
[extern $malloc]
[extern $free]
[extern $calloc]
[section .drectve]
db " -defaultlib:crt64"
db " -defaultlib:kernel32"
