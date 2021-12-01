#Practica 6 - Ordenar un vector - Jose Javier Diaz Gonzalez

#Dado un vector de entero, implementar una rutina en ensamblador que realice la ordenacion de sus elementos

#CODIGO

#int main(void)
#{
#    int vector[] = {1, 28, 4, 10, 12, 31, 17, 7, 6, 3}; //10 numeros
#    int i, j, aux;
#
#    for (i = 0; i < 10; i++){
#        for (j = 0; j < 10; j++){
#            if (vector[j] > vector[j + 1]){ //numero_actual > numero_siguiente
#                aux = vector[j];            //(intercambio) aux = numero_actual
#                vector[j] = vector[j + 1]; //numero_actual = numero_siguiente
#                vector[j+1] = aux;         //numero_siguiente = aux
#            }
#        }
#    }
#    for (i = 0; i < 10; i++){ //ascendente
#        printf("%d  ", vector[i]); 
#     }
#}

#FIN CODIGO

        .data
vector:            .word  1, 28, 4, 10, 12, 31, 17, 7, 6, 3,-5, 28, 1	# vector de datos 
espacio:	       .asciiz " "			                         # espacios
        .text 	

main:

la $s0, vector

li $t1,0 # i -> t1

bucle1:
    bge $t1,12,fbucle1 # si t1 mayor igual que 10, salta a fbucle 1
    li $t2,0 # j -> t2
    
    bucle2:
        bge $t2,12,fbucle2 # si t2 es mayor igual que 10, salta a fbucle 2
        #cargar vector[j]
        mul $t3,$t2,4 # t3 = t2 * 4 (j * 4)
        add $t3,$t3,$s0 # t3 = (t2 * 4) + vector
        lw $t4,0($t3) # t4 vector[j]
        lw $t5,4($t3) # t5 vector[J+1]
        ble $t4,$t5,ordenados # si t4 menor igual que t5, salta a ordenados
        sw $t4,4($t3)
        sw $t5,0($t3)

        ordenados:
            addi $t2,1 #j++
            j bucle2

    fbucle2:
        addi $t1, 1 # i++
        j bucle1

fbucle1:
    la $s0,vector
    li $t1,0 # i -> t1

  bucle_final:
    bge $t1,13,fuerallave # si t1 es mayor o igual que 10, salta a fuera llave

    #cargar vector[i]
    mul $t6,$t1,4 # t6 = t1 * 4 -> (i * 4)
    add $t7,$t6,$s0 # t7 = (t1 * 4) + vector
    lw $t8,0($t7) # t8 vector[i]
    
    move $a0,$t8 #imprime $a0 en t8
    li $v0,1 # mostar el entero en t8
    syscall

    la $a0,espacio	# carga el espacio
	li $v0,4		# mostrar espacio
	syscall

	addi $t1,1	#i++		
	j bucle_final

fuerallave:
    li $v0,10						
    syscall	# salir	
