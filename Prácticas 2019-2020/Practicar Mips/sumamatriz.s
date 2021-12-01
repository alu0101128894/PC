
# for(i=0; i<m; i++){
# 	for(j=0; j<n; j++){
# 	suma = suma + matriz[i][j]
# 	}
# }


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
			# 1º calculamos el desplazamiento (i*n+j)*size
			mul $t2,$t0,n
			add $t3,$t2,$t1
			mul $t4,$t3,size # [(i*n) + j ] * size

			add $t5,$s0,$t4  # 2º sumamos este desplazamiento a la base

			lw $t6,0($t5) 	 # 3º cargamos el elemento en un registro

			add $s1,$s1,$t6 	# 4º acumulamos el valor en la suma -> suma + matriz[i][j]

			
			addi $t1,1 # j++
			blt $t1,n,bucle2 #j<n

		addi $t0,1 #i++
		blt $t0,m,bucle1 #i<m salta
		
	li $v0,1
	move $a0,$s1
	syscall
	
	li $v0,10
	syscall
	