.intel_syntax noprefix    #syntax
    .text    # start the section
    .globl    find_min
    .type    find_min, @function
find_min:
    endbr64 #we came here from some branch (that was said by our assistant)
    push    rbp #save rbp on stack
    mov    rbp, rsp #rbp:=rsp
    mov    QWORD PTR -24[rbp], rdi #-24[rbp]:= first arg (arr)
    mov    DWORD PTR -28[rbp], esi # -28[rbp] = second arg (n)
    mov    rax, QWORD PTR -24[rbp] #arr
    mov    eax, DWORD PTR [rax] # arr[0]
    mov    DWORD PTR -4[rbp], eax # minimal: = arr[0]
    mov    DWORD PTR -8[rbp], 1 # i = 1
    jmp    .L2 #go to loop condition
.L4:
    mov    eax, DWORD PTR -8[rbp] #eax:=i
    cdqe
    lea    rdx, 0[0+rax*4] 
    mov    rax, QWORD PTR -24[rbp] #arr
    add    rax, rdx
    mov    eax, DWORD PTR [rax]
    cmp    DWORD PTR -4[rbp], eax #compare minimal and arr[i]
    jle    .L3  #if minimal <= arr[i] don't go to the if body, just next loop
    mov    eax, DWORD PTR -8[rbp]
    cdqe
    lea    rdx, 0[0+rax*4] 
    mov    rax, QWORD PTR -24[rbp] #arr
    add    rax, rdx
    mov    eax, DWORD PTR [rax] #arr[i]
    mov    DWORD PTR -4[rbp], eax #minimal = arr[i]
.L3:
    add    DWORD PTR -8[rbp], 1 #i++
.L2:
    mov    eax, DWORD PTR -8[rbp] # eax:= i
    cmp    eax, DWORD PTR -28[rbp] # compare i and n
    jl    .L4 #jump to body if i < n
    mov    eax, DWORD PTR -4[rbp] #eax:= minimal
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
    lea    rax, .LC1[rip] #rax=: string about mistake
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
    mov    DWORD PTR -4[rbp], 0 #int i = 0
    jmp    .L9 #go the the while loop condition
.L10:
    lea    rdx, -40016[rbp] #arr
    mov    eax, DWORD PTR -4[rbp] #i
    cdqe
    sal    rax, 2 #rotate bits
    add    rax, rdx
    mov    rsi, rax 
    lea    rax, .LC0[rip] # string %d
    mov    rdi, rax
    mov    eax, 0
    call    __isoc99_scanf@PLT
    add    DWORD PTR -4[rbp], 1 #i++
.L9:
    mov    eax, DWORD PTR -80020[rbp] #eax := n
    cmp    DWORD PTR -4[rbp], eax #compare i and n
    jl    .L10 # if less than n go to l10
    mov    edx, DWORD PTR -80020[rbp] #n
    lea    rax, -40016[rbp] #arr
    mov    esi, edx #n
    mov    rdi, rax #arr
    call    find_min #find_min(arr, n)
    mov    DWORD PTR -16[rbp], eax #minimal = find_min(arr, n)
    mov    DWORD PTR -8[rbp], 0 #int ans_size = 0
    mov    DWORD PTR -12[rbp], 0 #i = 0
    jmp    .L11
.L13:
    mov    eax, DWORD PTR -12[rbp] #i = 0
    cdqe
    mov    eax, DWORD PTR -40016[rbp+rax*4] #arr[i]
    cmp    DWORD PTR -16[rbp], eax #compare minimal and arr[i]
    je    .L12 #if arr[i] == minimal jump to the loop condition
    mov    eax, DWORD PTR -12[rbp] #i
    cdqe
    mov    edx, DWORD PTR -40016[rbp+rax*4] #arr[i]
    mov    eax, DWORD PTR -8[rbp] #ans_size
    cdqe
    mov    DWORD PTR -80016[rbp+rax*4], edx #ans[ans_size]=
    mov    eax, DWORD PTR -12[rbp]
    cdqe
    mov    eax, DWORD PTR -40016[rbp+rax*4] #=arr[i]
    mov    esi, eax
    lea    rax, .LC0[rip] #string %d
    mov    rdi, rax
    mov    eax, 0
    call    printf@PLT #print arr[i]
    add    DWORD PTR -8[rbp], 1 # ans_size++
.L12:
    add    DWORD PTR -12[rbp], 1 #i++
.L11:
    mov    eax, DWORD PTR -80020[rbp] #eax:=n
    cmp    DWORD PTR -12[rbp], eax #compare i and n
    jl    .L13 #if less than jump to the loop body (l13)
    mov    eax, 0
    leave # end
    ret
