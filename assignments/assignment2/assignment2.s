    .section  .rodata
    .align    3 # 2^3=8
error_msg:
    .string   "pow(%ld, %ld) got %ld expected %ld\n"

    .text
    .align 1
    .globl pow
    .type  pow, @function
pow:
    # long pow(long base, long exponent)
    # Here, you should implement the PROLOGUE for calling pow()
    # reference lines of code: 4
    ### YOUR CODE HERE
    
    # Here, you are recommended to store two variables (base & exponent) 
    # in proper place of the stack
    # reference lines of code: 2
    ### YOUR CODE HERE
    
    bne   a1,zero,pow_nonzero_exp
pow_zero_exp:
    # Here corresponds to the branch condition that current exponent is zero.
    # You can refer to the Line 5 of C code example.
    # Note: Here is the end of recursion and should return a value.
    # reference lines of code: 1
    ### YOUR CODE HERE

    j     pow_return
pow_nonzero_exp:
    # Here corresponds to the branch condition that current exponent is not zero.
    # Calculate pow(base, exponent / 2)
    # And then branch to pow_even or pow_odd according to the value of (exponent/2)
    # reference lines of code: 5
    ### YOUR CODE HERE
    
    beq   a1,zero,pow_even
pow_odd:
    # Here corresponds to the Line 9 of C code example.
    # reference lines of code: 3
    ### YOUR CODE HERE
    
    j     pow_return
pow_even:
    # Here corresponds to the Line 11 of C code example.
    # reference lines of code: 1
    ### YOUR CODE HERE

pow_return:
    # Here, you should implement the EPILOGUE for calling pow()
    # reference lines of code: 4
    ### YOUR CODE HERE

    .size pow, .-pow


    .align 1
    .globl check
    .type  check, @function
check:
    # void check(long base, long exponent, long expected);
    addi  sp,sp,-64
    sd    ra,56(sp)
    sd    s0,48(sp)
    addi  s0,sp,64
    sd    a0,-40(s0) # base
    sd    a1,-48(s0) # exponent
    sd    a2,-56(s0) # expected
    call  pow
    sd    a0,-24(s0)
    lui   a5,%hi(stderr)
    ld    a0,%lo(stderr)(a5)
    ld    a5,-56(s0) # expected
    ld    a4,-24(s0) # pow result
    ld    a3,-48(s0) # exponent
    ld    a2,-40(s0) # base
    lui   a1,%hi(error_msg)
    addi  a1,a1,%lo(error_msg)
    call  fprintf
    ld    a0,-24(s0)
    ld    a5,-56(s0)
    beq   a0,a5,check_ok
check_fail:
    li    a0,-1
    call  exit # will not return
check_ok:
    ld    ra,56(sp)
    ld    s0,48(sp)
    addi  sp,sp,64
    jr    ra
    .size check, .-check


    .align 1
    .globl main
    .type  main, @function
main:
    addi  sp,sp,-16
    sd    ra,8(sp)
    sd    s0,0(sp)
    addi  s0,sp,16

    # check whether pow(2, 5) gives 32
    li    a2,32
    li    a1,5
    li    a0,2
    call  check
    # more test cases ...
    li    a2,27
    li    a1,3
    li    a0,3
    call  check

    li    a2,387420489
    li    a1,18
    li    a0,3
    call  check

    li    a5,0
    mv    a0,a5
    ld    ra,8(sp)
    ld    s0,0(sp)
    addi  sp,sp,16
    jr    ra
    .size    main, .-main
