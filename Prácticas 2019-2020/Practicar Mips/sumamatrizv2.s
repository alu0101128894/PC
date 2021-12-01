m=4 # numnero de filas
n=5 # numero de columnas	
size=4 # bytes que ocupa cada elemento
	.data
	# en realidad es una sola dimension
matriz:	.word 7, 5, 0, 1, 6
		.word 2, 4, 6, 8, 9
		.word 1, 7, 2, 3, 6
		.word 9, 2, 1, 7, 5

	.text
main:
	la $s0,matriz  # $s0 es la direccion base de vector
	li $s1, 0      # en $s1 guardaremos la suma de elementos
	li $t0,0	   # $t0 es el iterador de filas
	bucle1:
		li $t1,0   # $t1 es el iterador de columnass
		bucle2:
			# 1º cargamos el elemento base en un registro
			lw $t6,0($s0)
			# 2º acumulamos el valor en la suma
			add $s1,$s1,$t6
			# 3º desplazamos la base
			addi $s0,size
			
			addi $t1,1
			blt $t1,n,bucle2
			
		addi $t0,1
		blt $t0,m,bucle1
		
	li $v0,1
	move $a0,$s1
	syscall
	li $v0,10
	syscall
	