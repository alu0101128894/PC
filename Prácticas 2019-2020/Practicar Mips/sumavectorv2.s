

# int i, suma = 0;

# for (i=0; i<n; i++){
# 	suma = suma + vector[i]
# }



n=10 # numero de elementos	
size=4 # bytes que ocupa cada elemento
	.data
vector:	.word 7, 3, 0, 1, 2, 4, 6, 8, 9, 5
	.text
main:
	la $s0,vector  # $s0 es la direccion base de vector
	li $s1, 0      # en $s1 guardaremos la suma de elementos
	li $t0,0	   # $t0 es el iterador 	
	
	bucle:
		# 1º Cargamos el elemento de la direccion base
		lw $t3,0($s0)
		add $s1,$s1,$t3
		addi $s0,$s0,size 	# 4++
		
		addi $t0,1		# i++
		blt $t0,n,bucle # i < 10 repite
		
	li $v0,1
	move $a0,$s1
	syscall

	li $v0,10
	syscall
	