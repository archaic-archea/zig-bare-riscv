.globl _entry

_entry:
    csrw sie, zero
    csrci sstatus, 2

    lla gp, __global_pointer$

    lla t0, __bss_start
    lla t1, __bss_end

    bss_zero:
        beq t0, t1, enter_kern
        sd zero, (t0)
        addi t0, t0, 8
        j bss_zero

    enter_kern:
        j kmain

    # Some error occured, and we somehow returned here, just halt loop
    hlt_loop:
        wfi
        j hlt_loop
