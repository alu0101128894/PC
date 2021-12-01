	.data
cadena: 	.asciiz "Practica 5 de Principios de Computadores. Quedate en casa!!"
cadena2:	.asciiz "roma tibi subito m otibus ibit amor"
cadtiene:	.asciiz " tiene "
cadcarac:	.asciiz " caracteres.\n"
cadespal:	.asciiz "Es palindroma.\n\n"
cadnoespal:	.asciiz "No es palindroma.\n\n"
	.text

strlen:  # numero de caracteres que tiene una cadena sin considerar el '\0'
		 # la cadena tiene que estar terminada en '\0'
		 # $a0 tiene la direccion de la cadena
		 # $v0 devuelve el numero de caracteres
		 # INTRODUCE AQUI EL CODIGO DE LA FUNCION strlen SIN CAMBIAR LOS ARGUMENTOS
		
		# for(i = 0; length[i] != '\0'; i++){
		# 	length++
		# }


	addi $sp, $sp, -8	 #Lo guardo en dos valores ($v0, and $ra)
	sw $ra, 0($sp)
	sw $v0, 4($sp)
	li $t0,0       #Contador para la longitud = 0
	jal for

	for:
		lb $t1, 0($a0)		# load byte (cadena)
		beqz $t1, salir 	# t1 == 0 salta con el caracter "null"
		addi $a0, $a0, 1 	#increment character 
		addi $t0, $t0, 1 	#incrementa el contador (contador++)
		j for

	salir:
		move $v0, $t0
		sw $v0, 4($sp) # Vuelve a la posicion original
		lw $ra, 0($sp)
		addi $sp, $sp, 8
		jr $ra
		 
reverse_i:  # funcion que da la vuelta a una cadena
			# $a0 cadena a la que hay que dar la vuelta
			# $a1 numero de caracternes que tiene la cadena
			# $v0 1 Si es palindroma 0 si no lo es
			
			# INTRODUCE AQUI EL CODIGO DE LA FUNCION reverse_i SIN CAMBIAR LOS ARGUMENTOS
				

reverse_r:  # funcion que da la vuelta a una cadena
			# $a0 cadena a la que hay que dar la vuelta
			# $a1 numero de caracternes que tiene la cadena
			# $v0 1 Si es palindroma 0 si no lo es
			
			# INTRODUCE AQUI EL CODIGO DE LA FUNCION reverse_r SIN CAMBIAR LOS ARGUMENTOS
				

main:
			# INTRODUCE AQUI EL CODIGO DE LA FUNCION main QUE REPRODUZCA LA SALIDA COMO EL GUION
			# INVOCANDO A LA FUNCION strlen DESPUES DE CADA MODIFICACION DE LAS CADENAS
			
	la $a0,cadena
	jal strlen

	la $a0,cadena
	li $v0,4 
	syscall

	la $a0, cadtiene
	li $v0,4
	syscall

	li $v0, 1      			 # Moves the length of the string to $a0, to print.
	move $a0, $t0
	syscall
    
	la $a0, cadcarac
	li $v0,4 
	syscall

	li $v0, 10 #Exit
	syscall