
#PRACTICA 5 - JOSE JAVIER DIAZ GONZALEZ

	.data
text:			.asciiz "Jose Javier Diaz Gonzalez, alu0101128894@ull.edu.es\n\n"
practica5: 		.asciiz "Practica 5 de Principios de Computadores\n"
#cadena: 		.asciiz "Practica 5 de Principios de Computadores. Quedate en casa!!"
#cadena2:		.asciiz "roma tibi subito m otibus ibit amor"
cadtiene:		.asciiz " tiene "
cadcarac:		.asciiz " caracteres.\n"
cadespal:		.asciiz "Es palindroma.\n\n"
cadnoespal:		.asciiz "No es palindroma.\n\n"
salto_linea: 	.asciiz "\n"

impr_cadena:	.asciiz "\nIntroduzca una cadena: "
cad_espacio:	.space 1024

text_iterativo:	.asciiz "\n--> MODO ITERATIVO\n"
linea_cerrar:	.asciiz "-------------------------------------------------------\n"
text_recursivo:	.asciiz "\n--> MODO RECURSIVO\n"

	.text

strlen:  # numero de caracteres que tiene una cadena sin considerar el '\0'
		 # la cadena tiene que estar terminada en '\0'
		 # $a0 tiene la direccion de la cadena
		 # $v0 devuelve el numero de caracteres
		
		# for(i = 0; length[i] != '\0'; i++){
		# 	length++
		# }

	move $t0,$a0  	# cargo en a0 un t0
	li $v0,0        # Contador para la longitud = 0

	for:
		lb $s0,0($t0)		# load byte (cadena)
		beqz $s0, finfor 	# t1 == 0 salta con el caracter "null"
		addi $t0, $t0, 1 	# i++
		addi $v0, $v0, 1 	# contador ( lenght++)
		j for

	finfor:
		jr $ra
		 
reverse_i:  # funcion que da la vuelta a una cadena
			# $a0 cadena a la que hay que dar la vuelta
			# $a1 numero de caracteres que tiene la cadena
			# $v0 1 Si es palindroma 0 si no lo es
			
		 	move $t0,$a0 # a0 = direccion de la cadena en t0
		 	move $t1,$a1 # a1 = numero de caracteres en t1

			li $t2,0 	# contador = 0
			li $t3,0    # caracteres en 0
			li $t4,0	# caracteres en a1
			li $t5,2

			li $v0,1 # Decimos que 1 vale palindroma

			div $t1,$t5 	# numero decaracteres / 2
			mflo $t6   		# t6 = LO (numero de caracteres / 2)

			sub $t1,$t1,1 # t1--

			# li $t2,0 	# contador = 0
			# li $t3,0    # caracteres en 0
			# li $t4,0	# caracteres en a1

			for1:
				bne $t3,$t4,comprueba # si t3 != t4, salta comprueba = no es palindroma

				salto:
					bge $t2,$t6,finfor1 # si t2 >= t6, salta a finfor1 -> [si i >= LO (numero de caracteres / 2), salta finfor1
					add $t0,$t0,$t2  	# t0 = t0 + t2		t0 = t0 + i
					lb $t3,0($t0) 		# guarda en t3	

					move $t0,$a0		# movemos en a0 -> t0

					add $t0,$t0,$t1		# t0 = t0 + t1 

					lb $t4,0($t0)		# load byte de t0(0) en t4
					sb $t3,0($t0)		# save bye de t0(0) en t3

					sub $t0,$t0,$t1		# t0 = t0 - t1
					add $t0,$t0,$t2		# t0 = t0 + t2

					sb $t4,0($t0)		# save byte de t0(0) en t4

					move $t0,$a0		# movemos en a0 -> t0 de nuevo

					addi $t2,$t2,1		# t2++ (i++)
					addi $t1,$t1,-1		# t1-- (j++)

			j for1

				comprueba: 
					li $v0,0
					j salto

			finfor1:
				jr $ra		

reverse_r:  # funcion que da la vuelta a una cadena
			# $a0 cadena a la que hay que dar la vuelta
			# $a1 numero de caracternes que tiene la cadena
			# $v0 1 Si es palindroma 0 si no lo es
			
		# PSEUDOCODIGO

		# si $a1 < 2 -> return 1
		# sino reverse_r ( $a0 + 1, $a1 - 2 )
		# 	-> intercambio , si son diferentes -> v0 = 0
		# 	-> bucle
		# sino return ($v0)

		#palabra = aooa

		li $t0,2
		bge $a1,$t0,no_trivial # a1 >= 2, no trivial 
		li $v0,1	# palindroma
		jr $ra		# return

		no_trivial:

			#PUSH
			addi $sp,$sp,-12 	# 8 bytes en la pila (4*3=12)
			sw $ra,8($sp)   	# guardo ra
			sw $a0,4($sp)		# guardo a1
			sw $a1,0($sp) 		# guardo a0

			addi $a0,$a0,1 		# a0 + 1
			addi $a1,$a1,-2 	# a1 - 2 

			jal reverse_r

			#POP
			lw $a1,0($sp)		# recupero a0
			lw $a0,4($sp) 		# recupero a1
			lw $ra,8($sp) 		# recupero ra
			addi $sp,$sp,12 	# dejo el puntero de la pila como estaba
						
			lb $t4,0($a0) 		# principio de la dir mem -> h en un registro
			sub $a1,$a1,1 		# a1 = a1 - 1      hola -> h ola -> 5-1=4 	10100
			add $a0,$a0,$a1 	# a1 = dir + a1		10101

			lb $t5,0($a0) 		# ultima posicion
			sb $t4,0($a0)		# guardo byte

			sub $a0,$a0,$a1  	# a0 = a0 - $a1 
			sb $t5,0($a0)  		# t5 esta guardado
		
			beq $t5,$t4,iguales # si son iguales salta
			li $v0,0

			iguales:
				jr $ra 	# devuelve 1 si palindroma

main:
			# INVOCANDO A LA FUNCION strlen DESPUES DE CADA MODIFICACION DE LAS CADENAS
			
	la $a0,text	
	li $v0,4 
	syscall

	la $a0,practica5
	li $v0,4 
	syscall

	la $a0,text_iterativo
	li $v0,4 
	syscall

# ---------------------------------------------------------------------------

	la $a0,impr_cadena		# cadena a imprimir
	li $v0,4 			
	syscall

	la $a0,cad_espacio		
	li $v0,8				# leer cadena
	li $a1,1024				# a1 = 1024
	syscall	

	la $a0,cad_espacio
	jal strlen

# ---------------------------------------------------------------------------

	la $s0,cad_espacio		# cargo la cadena
	add $s0,$s0,$v0		 	# esa direccion la sumo la cantidad de caracteres
	sub $s0, $s0, 1 		# resto 1
	# Sustituyes el elemento con $zero
	sb $zero,0($s0)			# En $s0 tienes la direccion del ultimo elemento de la cadena	
	
	la $a0,salto_linea		
	li $v0,4 
	syscall
	
	la $a0,cad_espacio		
	li $v0,4 
	syscall

	la $a0, cadtiene 
	li $v0,4
	syscall

	la $a0,cad_espacio     	
	jal strlen
	
    move $a0,$v0 		# v0 = numero de caracteres
	move $a1,$v0
    li $v0, 1
	syscall
    
	la $a0, cadcarac 	# caracteres
	li $v0,4 
	syscall

# ---------------------------------------------------------------------------
# Cadena reverse_i

	la $a0,cad_espacio
	jal reverse_i
	
  	move $t1,$v0

	la $a0,cad_espacio 		# cargo el "espacio"
	li $v0,4 
	syscall

	la $a0, cadtiene 		# tiene
	li $v0,4
	syscall

	la $a0,cad_espacio      # lo cargo
	jal strlen
	
    move $a0,$v0 			# v0 = numero de caracteres
	move $a1,$v0
    li $v0,1
	syscall
    
	la $a0, cadcarac 		# caracteres
	li $v0,4 
	syscall

	la $a0, salto_linea
	li $v0,4 
	syscall

# ---------------------------------------------------------------------------
# Cadena 1 -> comparo

	li $s1,1
	li $s2,0

	beq $t1,$s1,es_palin_i
	beq $t1,$s2,no_palin_i
	palindroma_i:


# ---------------------------------------------------------------------------
# 2º PARTE

	la $a0,impr_cadena		# cadena a imprimir
	li $v0,4 			
	syscall

	la $a0,cad_espacio		
	li $v0,8			# leer cadena
	li $a1,1024			# a1 = 1024
	syscall

	la $a0,cad_espacio
	jal strlen

# ---------------------------------------------------------------------------

	la $s0,cad_espacio		# cargo la cadena
	add $s0,$s0,$v0			# esa direccion la sumo la cantidad de caracteres
	sub $s0, $s0, 1 		# resto 1
	# Sustituyes el elemento con $zero
	sb $zero,0($s0)	# En $s0 tienes la direccion del ultimo elemento de la cadena	
	
	la $a0,salto_linea		
	li $v0,4 
	syscall
	
	la $a0,cad_espacio		
	li $v0,4 
	syscall

	la $a0, cadtiene 
	li $v0,4
	syscall

	la $a0,cad_espacio       # lo cargo
	jal strlen

	move $a0, $v0
	move $a1,$v0 			# v0 = numero de caracteres
    li $v0, 1
	syscall

	la $a0, cadcarac 		# caracteres
	li $v0,4 
	syscall

# ---------------------------------------------------------------------------
# Cadena reverse_r

	la $a0,cad_espacio 		
	jal reverse_r

	move $t5,$v0

	la $a0,cad_espacio 		
	li $v0,4 
	syscall

	la $a0, cadtiene 	# tiene
	li $v0,4
	syscall

	la $a0,cad_espacio   # lo cargo
	jal strlen

	move $a0,$v0
	move $a1,$v0
	 					# v0 = numero de caracteres
    li $v0, 1
	syscall

	la $a0, cadcarac 	# caracteres
	li $v0,4 
	syscall

	la $a0, salto_linea
	li $v0,4 
	syscall

#---------------------------------------------------------------------------

	li $s1,1
	li $s2,0

	beq $t5,$s1,es_palin_r
	beq $t5,$s2,no_palin_r

	salir:
		li $v0,10 #Exit
		syscall

# ---------------------------------------------------------------------------
# Iterativo

es_palin_i:

	la $a0,cadespal 	
	li $v0,4
	syscall

	j palindroma_i

no_palin_i:

	la $a0,cadnoespal	
	li $v0,4
	syscall

	j palindroma_i

	la $a0,linea_cerrar 	
	li $v0,4 
	syscall

	la $a0,text_recursivo 	
	li $v0,4 
	syscall

# ---------------------------------------------------------------------------
# Recursivo

es_palin_r:

	la $a0, cadespal 	
	li $v0,4
	syscall

	j salir

no_palin_r:

	la $a0, cadnoespal	
	li $v0,4
	syscall

	j salir
	