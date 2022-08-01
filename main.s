.global _start spinlock

HELLO:  .asciz "Hello, world!"

_start:
    call init_term
    call init_scsi

    mov r2, HELLO
    call puts

    ;; TODO: Initialize filesystem, initialize keyboard, spin up a shell

    ;; Fallthrough
spinlock:
    hlt
    jmp spinlock