.global init_scsi

init_scsi:
    mov r2, 0x7f000000
    in double
    test r0, 0x00000001     ; I/O Subsystem enabled
    jz spinlock
    test r0, 0x00000020     ; SCSI flag
    jz spinlock

    ret