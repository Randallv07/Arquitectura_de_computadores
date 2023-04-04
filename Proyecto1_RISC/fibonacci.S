lui s0, 0x10000
addi t0, zero, 0
addi t1, zero, 1
addi a0, zero, 10
addi a1, zero, 11
slli a3, a0, 2
slli a4, a1, 2
add a4, a4, s0
add a3, a3, s0
sw t0, 0(a3)
sw t1, 0(a4)



NuevoNumero:
add t2, t1, t0
addi a1, a1, 1
slli a4, a1, 2
add a4, a4, s0
sw t2, 0(a4)
add t0, zero, t1
add t1, zero, t2
jal zero, NuevoNumero

addi x7, x7, 0