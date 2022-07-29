_start:
    call init_term

    ;; TODO: Initialize filesystem, initialize keyboard, spin up a shell

    jmp spinlock

init_term:
    mov r2, 0x7f000000
    in double
    test0, 0x00000001   ; I/O Subsystem enabled (likely redundant?)
    jz spinlock
    test0, 0x00000040   ; VGA flag
    jz spinlock

    ;; TODO: Load address of VGA buffer, initialize terminal state

    ret

spinlock:
    hlt
    jmp spinlock