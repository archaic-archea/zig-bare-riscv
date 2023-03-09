.globl _entry

_entry:
    csrw sie, zero
    csrci sstatus, 2

    lla gp, __global_pointer$

    /*lla t0, __bss_start
    lla t1, __bss_end

    bss_zero:
        beq t0, t1, enter_kern
        sd zero, (t0)
        addi t0, t0, 8
        j bss_zero*/

    lla t0, int
    csrw stvec, t0

    enter_kern:
        j kmain

    # Some error occured, and we somehow returned here, just halt loop
    j hlt_loop

int:
    jal trap_handler

    j hlt_loop

hlt_loop:
    wfi
    j hlt_loop

write_char:
    li t0, 0x10000000
    sb a0, 0(t0)
    ret
