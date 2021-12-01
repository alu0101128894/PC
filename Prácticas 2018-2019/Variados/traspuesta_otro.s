# PRACTICA 4. PRINCIPIO DE COMPUTADORES.
# programa que imprime la traspuesta de la mariz
# La matriz tiene dimension mxn

m = 1		# numero de filas de m1
n = 1		# numero de columnas de  m1
size = 4	# tamano de cada elemento


# HAY QUE PONER UN ESPACIO DETRAS DE CADA COMA EN LA DEF DE VECTORES Y MATRICES
			.data
ml:			.word	1, 2, 3, 4, 5
			.word	6, 7, 8, 9, 0
			.word	0, 2, 4, 6, 8
			.word	1, 3, 5, 7, 9
			
carro:		.asciiz "\n"

			.text
main:
		# Para facilidad de correccion incluye el pseudocodigo que has utilizado y 
		# lo que significa cada registro
		# INTRODUCE AQUI TU CODIGO
		
					
		move $s0,$zero
		
		la 		$s1,ml
		move		$t0,$zero
		li		$t2,size
		li		$t3,n
		li		$t4,1
		li		$t5,0
		li		$t6,0
		mul		$t7,$t3,$t2
				
bucle:
		li		$t4,1			
		mul		$t4,$t4,$t2		
		mul		$t4,$t4,$t3		
		mul		$t4,$t4,$t5		
		addu	$t4,$t4,$t6 	
		addu	$t4,$t4,$s1		
		lw		$a0,0($t4)		
		li $v0,1
		syscall					
		
		addi	$t5,$t5,1		
		blt		$t5,m,bucle1	
		
		la		$a0,carro
		syscall					
		
		li		$t5,0			
		addu	$t6,$t6,$t2	
		blt		$t6,$t7,bucle1
			
		
		# responde a las cuestiones planteadas
	    # salida del sistema
        li	$v0,10
        syscall
			


