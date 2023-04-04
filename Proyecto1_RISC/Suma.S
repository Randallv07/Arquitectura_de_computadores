lui s0, 0x10000
addi t0, zero, 0
addi t1, zero, 1
addi a1, zero, -1
addi a4, zero, 9
addi a3, zero, 8
slli a2, a1, 2
add a2, a2, s0
sw t0, 0(s0)
sw t1, 0(a2)

NuevoNumero:
addi t2, t1, 1
addi a1, a1, -1
slli a2, a1, 2
add a2, a2, s0
sw t2, 0(a2)
add t1, zero, t2
blt t1, a4 NuevoNumero

addi a1, zero, 0
slli a2, a1, 2
add a2, a2, s0

suma:
addi a1, a1, -1
slli a2, a1, 2
add a2, a2, s0
lw t0, 0(a2)
lw t2, 4(a2)
add t1,zero,t0
slli t0,t0,3
add t0,t0,t1
add t0,t0,t1
add t0, t0, t2
sw t0, 4(s0)

sumap:
addi a1, a1, 1
slli a2, a1, 2
add a2, a2, s0
lw t0, 4(s0)
lw t2, 4(a2)
add t1,zero,t0
slli t0,t0,3
add t0,t0,t1
add t0,t0,t1
add t0, t0, t2
sw t0, 4(s0)
blt a1, a3 sumap

addi x7, x7, 0