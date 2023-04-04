addi s1,s1,0x108
addi t0,zero,3
add s0,zero,zero
multiply:
add t1,zero,t0
slli t0,t0,3
add t0,t0,t1
add t0,t0,t1
sw t0,(s1)