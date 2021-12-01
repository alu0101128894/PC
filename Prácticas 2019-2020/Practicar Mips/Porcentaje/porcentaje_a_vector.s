# El siguiente programa de ejemplo resuelve el siguiente enunciado:
# 1) Realizar una funcion "porcentaje" que reciba dos argumentos flotantes en doble precision
# el primero es el numero al que hay que aplicar el porcentaje, y el segundo el porcentaje a 
# incrementar.
# La funcion devolvera el primer argumento incrementado en el porcentaje especificado en el segundo.

# 2) REalizar una funcion porc_vect que reciba como argumentos la direccion de un vector de dobules
# y el numero de elementos que tiene el vector de doubles.
# esta funcion pedira por consola el porcentaje que debe aplicarse de incremento a todos los elmentos
# del vector, y posteriormente, haciendo uso de la funcion porcentaje explicada en el punto (1) modificar
# cada uno de los elmentos del vector.

# 3) Realizar una funcion print_vect que imprime un vector de doubles separdos por coma
# recibe como argumentos la direccion de un vector de dobules
# y el numero de elementos que tiene el vector de doubles.

# El cuerpo principal del programa debe imprimir el vector con la funcion print_vect, llamar a porc_vect y 
# volver a imprimir con la funcion print_vect. Usa los datos dados bajo la directiva .data

N=10  # numero de elemento del vector

	.data
vector:	.double	1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0
titulo:	.asciiz "Ejecutando la funcion porc_vect\n"
nl:	.asciiz "\n"
coma:	.asciiz ", "

	.text

# 1) hacer una funcion que dado un numero flotante doble precision
# devuelva ese mismo numero aumentado en un %
# recibe en $f12 = double al que hay que aumentar un porcentaje
# recibe en $f14 = porcentaje a aumentar $f12
# devuelve en $f0 = $f12 + ($f12*$f14/100)
porcentaje: 
    mov.d $f18,$f14
    # hago las operaciones
    # guardo un 100 en un registro
    li.d $f16,100.0
    div.d $f18,$f18,$f16
    mul.d $f18,$f12,$f18
    add.d $f0,$f12,$f18

    jr $ra

porc_vect:  # aplica un porcentaje a un vector de flotantes doble precision
            # que debe pedirse por consola
            # $a0 = se pasa la direccion del vector de doubles
            # $a1 = numero de elementos del vector

            # guardo en la pila $ra
            # reservo el espacio en la pila
		    addi $sp,$sp,-8
            sw $ra,0($sp) # guardo $ra
			sw $a0,4($sp)

			la $a0,titulo
			li $v0,4
			syscall

			
            # pido el porcentaje por consola
            li $v0,7
            syscall
            # en $f0-$f1 tengo el flotante doble que se leyo
            # lo muevo a $f14
            mov.d $f14,$f0
 
            # contador
            move $t1,$zero
			lw $a0,4($sp)
            repetir:
                # cargo el numero en la posicion $a0
                l.d $f12,0($a0)
                # llamo la funcion que calcula el porcentaje
                jal porcentaje

                # retorna con el porcentage en $f0 y lo guardo en $a0
                s.d $f0,0($a0)
                # paso al siguiente elemento
                addi $a0,8
                addi $t1,1
                # si el contador es menor que el numero de elementos repite
                blt $t1,$a1,repetir

            # recupero el valor anterior de $ra
			lw $ra,0($sp)
			addi $sp,8
            jr $ra
	

print_vect:  # imprime un vector de doubles por consola
			 # $a0 = direccion de memoria del vector de doubles a imprimir
			 # $a1 = numero de elementos del vector
			 
			 li $t0,0
			 move $t1,$a0
			 bucle: bge $t0,$a1,fin
			 	l.d $f12,0($t1)
				li $v0,3
				syscall
				
				la $a0,coma
				li $v0,4
				syscall	 
			 	addi $t1,8   # un double ocupa 8 bytes
			 	addi $t0,1
			 	j bucle
			 fin: 				 
				la $a0,nl
				li $v0,4
				syscall
				jr $ra
		

main:	
	
	la $a0,vector
	li $a1,N
	jal print_vect
	
	la $a0,vector
	li $a1,N
	jal porc_vect
	
	la $a0,vector
	li $a1,N
	jal print_vect
	
	li $v0,10
	syscall
	
	
	
	
	