# PRACTICA 4. PRINCIPIO DE COMPUTADORES.
# programa que imprime la traspuesta de la mariz
# La matriz tiene dimension mxn

m = 4		# numero de filas de m1
n = 5		# numero de columnas de  m1
size = 4	# tamano de cada elemento


# HAY QUE PONER UN ESPACIO DETRAS DE CADA COMA EN LA DEF DE VECTORES Y MATRICES
			.data
ml:			.word	1, 2, 3, 4, 5
			.word	6, 7, 8, 9, 0
			.word	0, 2, 4, 6, 8
			.word	1, 3, 5, 7, 9
			
carro:		.asciiz "\n"
M1:		.asciiz "introduzca fila: "
M2:		.asciiz "introduzca columna: "
			.text
main:
		# Para facilidad de correccion incluye el pseudocodigo que has utilizado y 
		# lo que significa cada registro
		# INTRODUCE AQUI TU CODIGO
		
					
		move $s0,$zero
		
		la 		$s1,ml
		move	$t0,$zero
		li		$t2,size
		li		$t3,n
		li		$t4,1
		li		$t5,0
		li		$t6,0
		mul		$t7,$t3,$t2
				
bucle:
		la	$a0,M1
		li	$v0,4
		syscall
        li $v0,5
        syscall
        move $t5,$v0


        la	$a0,M2
		li	$v0,4
		syscall
        li $v0,5
        syscall
        move $t6,$v0


		li		$t4,1			
		mul		$t4,$t4,$t2		#-> por el tamaño
		mul		$t4,$t4,$t3		
		mul		$t4,$t4,$t5		
		addu	$t4,$t4,$t6 	#sumo filas
		addu	$t4,$t4,$s1		# sumo posicion memoria
		lw		$a0,0($t4)		
		
        li   $v0,1
		syscall					
		
	
    li	$v0,10
    syscall
			























