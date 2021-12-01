# Suponemos una matriz cuadrada
# imprimir por pantalla los elementos de la diagonal de una matriz cuadrada
N=3 # filas =3 y columnas =3

    .data
matriz: .word 11, 12, 13, 21, 22, 23, 31, 32, 33
endl:   .asciiz "\n"

    .text
main:
    la $s0,matriz
    move $t1,$zero
    move $t2,$zero
    li $t3,1
    li $s3,N
    # $s1 la distancia
    addi $s3,1
    mul $s3,$s3,N
    bucle:
        lw $a0,0($s0)
        li $v0,1
		syscall
        # Sumo 1 al contador de las columnas
		addi $t3,1
        # Si el contador de las columnas es igual al numero de columnas, hace un enter
		bne $t3,N,noenter
			la $a0,endl
			syscall
			move $t3,$zero # vuelve a poner a cero el contador
		noenter:
        # me desplazo una fila +1
        add $s0,$s3,$s0
		addi $t1,1 # Sumo 1 al contador de elementos
		blt $t1,$s3,bucle

    li $v0,10
    syscall