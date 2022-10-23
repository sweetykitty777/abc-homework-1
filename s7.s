#r12d = -4[rbp]
#r13d = -8[rbp]
#r14d = -28[rbp]
.intel_syntax noprefix
    .text
    .globl    find_min
    .type    find_min, @function
find_min:
        endbr64 #we came here from some branch (that was said by our assistant)
        push    rbp #save rbp on stack
        mov     rbp, rsp #rbp:=rsp
        mov     QWORD PTR -24[rbp], rdi #-24[rbp]:= first arg (arr)
        mov     r14d, esi # -28[rbp]:= second arg (n)
        mov     rax, QWORD PTR -24[rbp] #arr
        mov     eax, DWORD PTR [rax] # arr[0]
        mov     r12d, eax # minimal: = arr[0]
        mov     r13d, 1 # i = 1
        jmp    .L2 #go to loop condition

.L4:
    mov    eax, r13d #eax:=i
    cdqe
    lea    rdx, 0[0+rax*4]
    mov    rax, QWORD PTR -24[rbp] #arr
    add    rax, rdx
    mov    eax, DWORD PTR [rax]
    cmp    r12d, eax #compare minimal and arr[i]
    jle    .L3  #if minimal <= arr[i] don't go to the if body, just next loop
    mov    eax, r13d
    cdqe
    lea    rdx, 0[0+rax*4]
    mov    rax, QWORD PTR -24[rbp] #arr
    add    rax, rdx
    mov    eax, DWORD PTR [rax] #arr[i]
    mov    r12d, eax #minimal = arr[i]

.L3:
    add       r13d, 1 #i++
.L2:
    mov    eax, r13d # eax:= i
    cmp    eax, r14d # compare i and n
    jl    .L4 #jump to body if i < n
    mov    eax, r12d #eax:= minimal
    pop    rbp
    ret #return minimal
    .size    find_min, .-find_min
    .section    .rodata #read only data
.LC0:
    .string    "%d"
.LC1:
    .string    "0 < size of array < 10000"
    .text
    .globl    main
    .type    main, @function

main:
    endbr64 #start of new branch
    push    rbp #save rbp on stack
    mov    rbp, rsp #rbp:=rsp
    lea    r11, -77824[rsp] #r11 := &-77824[rsp]

.LPSRL0:
    sub    rsp, 4096 #rsp -= 4096
    or    DWORD PTR [rsp], 0 #logical or
    cmp    rsp, r11 #compare rsp and r11
    jne    .LPSRL0 #restart if not equsl
    sub    rsp, 2224 #rsp-=2224
    mov    DWORD PTR -80036[rbp], edi #int argc
    mov    QWORD PTR -80048[rbp], rsi #char** argv
    lea    rax, -80020[rbp] #int n;
    mov    rsi, rax
    lea    rax, .LC0[rip] #rax :=&(string "%d")
    mov    rdi, rax #rdi := rax - first arg
    mov    eax, 0
    call    __isoc99_scanf@PLT #scan n
    jmp    .L7 #jump to while loop condition
.L8:
    lea    rax, .LC1[rip] #rax =: string about mistake
    mov    rdi, rax # rdi:=rax
    mov    eax, 0
    call    printf@PLT #print string about mistake
    lea    rax, -80020[rbp] #rax:=n
    mov    rsi, rax #rsi = rax
    lea    rax, .LC0[rip] #rax:=&(string "%d")
    mov    rdi, rax  #rdi:=rax
    mov    eax, 0 #eax:=0
    call    __isoc99_scanf@PLT #scan to n

.L7:
    mov    eax, DWORD PTR -80020[rbp] #eax: = n
    test    eax, eax
    jle    .L8  #if less or equal go to the loop body
    mov    eax, DWORD PTR -80020[rbp] #eax: = n
    cmp    eax, 10000 #compare n and 10000
    jg    .L8 #if more than go to the loop body
    mov    r12d, 0 #int i = 0
    jmp    .L9 #go the the while loop condition

.L10:
    lea    rdx, -40016[rbp] #arr
    mov    eax, r12d #i
    cdqe
    sal    rax, 2 #rotate bits
    add    rax, rdx
    mov    rsi, rax
    lea    rax, .LC0[rip] # string %d
    mov    rdi, rax
    mov    eax, 0
    call    __isoc99_scanf@PLT
    add    r12d, 1 #i++

.L9:
    mov    eax, DWORD PTR -80020[rbp] #eax := n
    cmp    r12d, eax #compare i and n
    jl    .L10 # if less than n go to l10
    mov    edx, DWORD PTR -80020[rbp] #n
    lea    rax, -40016[rbp] #arr
    mov    esi, edx #n
    mov    rdi, rax #arr
    call    find_min #find_min(arr, n)
    mov    DWORD PTR -12[rbp], eax #minimal = find_min(arr, n)
    mov    r13d, 0 #int ans_size = 0
    mov    r12d, 0 #i = 0
    jmp    .L11

.L13:
    mov    eax, r12d #i = 0
    cdqe
    mov    eax, DWORD PTR -40016[rbp+rax*4] #arr[i]
    cmp    DWORD PTR -12[rbp], eax #compare minimal and arr[i]
    je    .L12 #if arr[i] == minimal jump to the loop condition
      mov    esi, eax
      lea    rax, .LC0[rip] #string %d
      mov    rdi, rax
      mov    eax, 0
      call    printf@PLT #print arr[i]
      mov    edi, 10
      call    putchar@PLT #print "\n"
      add    r13d, 1  #ans_size++
.L12:
      add    r12d, 1 #i++
.L11:
    mov    eax, DWORD PTR -80020[rbp] #n
    cmp    r12d, eax #compare i and n
    jl    .L13 #if i < n go to the loop body
    mov    eax, 0
    leave
    ret
