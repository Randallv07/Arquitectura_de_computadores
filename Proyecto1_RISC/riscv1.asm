lui s0, 0x10000 #t0=>Dividend0 , t1=>Divisor , a0=>Cociente , s0=>TOS , 0x10000000=>TOS
#addi t0,zero,46  #dividendo t0 = 45
#addi t1,zero,8	 #divisor t1 = 8
addi t1, zero, 0 
addi t0, zero, 1
addi t2, zero, 4
addi t3, zero, 3
slli t2, t2, 2
slli t3, t3, 2
add t2, t2, s0  #t2=TOS+10
add t3, t3, s0  #t2=TOS+11
sw t1, 0(t2)
sw t0, 0(t3)

fibonacci:
add t4,s0,zero
addi a5,zero,10  #Se inicializa el contador de decimales
add t2,t0,zero
add t0, t1, t0   #Se cacula el pr�ximo n�mero de la serie
#addi a1, a1, 1   
#slli a1, a1, 2
addi t3, t3, 4
sw t0, 0(t3)
add t1,t2,zero
add a6,t0,zero
bandera:
addi a0,zero,0   #se inicializa regitro
blt t0,t1,menorque # si t0 = t1 salta a menorque
addi a0,zero,1 #si t0 != t1 -> se transforma a0 = 1
add a3,t1,zero # a3=t1 se guarda t1 en a1

division: #Se multiplica para hallar con mas rapidez el cociente
slli t1,t1,1 # t1 = t1*2
slli a0,a0,1 # a0 = a0*2
beq t1,t0,cociente # si t0 = t1 salta a conciente
bge t1,t0,sepaso # si t1 >= t0 salta a sepaso
jal zero,division # vuelve a division

sepaso: #Si se pasa se debe dividir entre 2 para buscar el valor
srli t1,t1,1 # t1 = t1/2 
srli a0,a0,1 # a0 = a0/2

falta: # Se empieza a sumar de uno en uno hasta llegar al valor del cociente
addi a0,a0,1 # a0 = a0 + 1
add t1,t1,a3 # t1 = t1 + a1
beq t1,t0,cociente # si t0 = t1 salta a conciente
bge t1,t0,sobra1 # si t1 >= t0 salta a sepaso
jal zero,falta # brinca a falta

sobra1: #se devuelve si se paso
addi a0,a0,-1 # a0 = a0 - 1
sub t1,t1,a3 # t1 = t1 - a1
jal zero,cociente #salta a cociente

menorque:
sw a0,0(t4) # Se guarda el cociente
addi t4,t4,-4
beq t0,zero,final
jal zero,multiply

cociente: # De aqui se genera el primer cociente
sub t0,t0,t1 # Se resta el dividendo t0 = t0 - t1
sw a0,0(t4) # Se guarda el cociente
addi t4,t4,-4
beq t0,zero,final
#sw t0,0(s1) # Se guarda el residuo

multiply: # se multiplica el residuo por 10
add t2,zero,t0 # t2 = t0 para conservar el valor de residuo
slli t0,t0,3 # se multiplica residuo x8
add t0,t0,t2 # se suma una vez el residuo
add t0,t0,t2 # se suma otro para que sea x10
add t1, zero, a3 # se recupera el divisor 
addi x23, x23, 0 # dummy
addi a5,a5,-1
beq a5,zero,LEDs
#add t0,a6,zero
jal zero,bandera # se inicia la division con el residuo

final:
add a0,zero,zero
sw a0,0(t4) # Se guarda el cociente
addi t4,t4,-4
addi a5,a5,-1
beq a5,zero,LEDs
jal zero,final

LEDs:
add t1,s0,x0 #Se copia dirección para recorrer la memoria
addi s2,x0,0 #Se inicializa la dirección Y en 0
LEDs_SiguienteNumero:
lw t2,0(t1) #t2->regL Se carga al registro t2 el numero actual a dibujar
addi t1,t1,-4 #Se resta 4 para el siguiente dato

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
blt s3,s2,NuevoNumero
addi s2,s2,1
beq x0,x0, LEDs_SiguienteNumero



NuevoNumero:
addi a1,x0,0
li a0, 0x101
li a1,0x00000000
li a2, 0x00000000
ecall
add t0,a6,zero
add t1,a3,zero
jal zero,fibonacci