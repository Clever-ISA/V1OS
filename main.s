_start:
    call init_term
    mov r2, 0x41        ; 'A'
    call putc

    ;; TODO: Initialize filesystem, initialize keyboard, spin up a shell

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
    mov [vga_text_buf], r0

    ret

putc:
    mov r0, [term_y]
    mov r3, 80
    mul
    mov r1, [term_x]
    add r0, r1
    lsh r0, 1
    mov [r0], r2
    add r0, 1
    mov [r0], 0x0f

    add r1, 1
    cmp r1, 80
    jlt putc$L1
    mov [term_x], 0
    mov r0, [term_y]
    add r0, 1
    mov [term_y], r0

putc$L1:
    ret

spinlock:
    hlt
    jmp spinlock
