lui t0,0x1000
addi s10,zero,0x000000004
sw s10,0(t0)
addi s10,zero,0x000000002
sw s10,4(t0)
addi a5,zero,10

LEDs:
add t1,t0,x0 #Se copia dirección para recorrer la memoria
addi s2,x0,0 #Se inicializa la dirección Y en 0

LEDs_SiguienteNumero:
lw t2,0(t1) #t2->regL Se carga al registro t2 el numero actual a dibujar
addi t1,t1,4 #Se suma 4 para el siguiente dato

addi t3,x0,0 # t3->regX el bit que se va a dibujar en la matrix

LEDs_SiguienteUnidad: #Mueve en X 

beq t2,t3, Pre_SiguienteNumero #Revisa si el valor del numero a la coordenada X
li a0, 0x100 #Valor que indica que se va a dibujar 1 led
add a1,x0,t3
slli a1,a1,16
add a1,a1,s2
li a2, 0x00FF0000 #Indica que se dibuja en ROJO
ecall
addi t3,t3,1 #
beq x0,x0, LEDs_SiguienteUnidad


Pre_SiguienteNumero: #Mueve la matrix en y 
addi s3, x0,10 #Revisa si el contador de regY es mayor a 10
blt s3,s2,Negro_todos
addi s2,s2,1
beq x0,x0, LEDs_SiguienteNumero
 

Negro_todos:
addi a1,x0,0
li a0, 0x101
li a1,0x00000000
li a2, 0x00000000
ecall
#addi a1,a1,1
#blt a1,a5,Negro_todos

Fin: