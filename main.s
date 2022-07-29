_start:
    call init_term
    mov r2, 0x41        ; 'A'
    call putc

    ;; TODO: Initialize filesystem, initialize keyboard, spin up a shell

    ;; Fallthrough
spinlock:
    hlt
    jmp spinlock

vga_text_buf:   .long 0
term_x:         .byte 0
term_y:         .byte 0

init_term:
    mov r2, 0x7f000000
    in double
    test r0, 0x00000001   ; I/O Subsystem enabled (likely redundant?)
    jz spinlock
    test r0, 0x00000040   ; VGA flag
    jz spinlock

    mov r2, 0x7f00000f  ; get VGA buffer address
    in double
    add r0, 0x18000        ; offset to text mode area
    mov double [vga_text_buf], r0

    mov byte [term_x], 0
    mov byte [term_y], 0

    ret

putc:
    cmp r2, 0x0a
    jeq putc$L1

    mov r0, byte [term_y]
    mov r3, 80
    mul
    mov r1, byte [term_x]
    add r0, r1
    lsh r0, 1
    mov byte [r0], r2
    add r0, 1
    mov byte [r0], 0x0f

    add r1, 1
    mov byte [term_x], r1
    cmp r1, 80
    jlt putc$L2

putc$L1:
    mov byte [term_x], 0
    mov r0, byte [term_y]
    add r0, 1
    mov byte [term_y], r0

putc$L2:
    ret

puts:
    push r6
    mov r6, r2

puts$L1:
    mov r2, byte [r6]
    cmp r2, 0
    jeq puts$L2
    call putc
    add r6, 1
    jmp puts$L1

puts$L2:
    mov r2, 0x0a
    pop r6
    jmp putc