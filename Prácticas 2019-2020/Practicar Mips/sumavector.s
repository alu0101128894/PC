
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
		mul $t1,$t0,size  # 1º Calculamos el desplazamiento desde el inicio del vector

		add $t2,$s0,$t1 # direccion + (i*size) 2º Sumamos el desplazamiento a la direccion base

		lw $t3,0($t2) 		# 3º Cargamos el elemento de esa direccion

		add $s1,$s1,$t3  # suma + vector[i]
		addi $t0,1		# i++
		blt $t0,n,bucle # i < 10 repite
		
	li $v0,1
	move $a0,$s1
	syscall
	
	li $v0,10
	syscall
	