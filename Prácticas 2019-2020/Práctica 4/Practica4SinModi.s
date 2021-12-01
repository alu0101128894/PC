
# Practica 4 SIN MODIFCACION

size = 4 #bytes que ocupa cada elemento


    .data
nrows:      .word   4   # filas
ncols:      .word   3   # columnas


matrix:     .word  11, 12, 13, 21, 22, 23, 31, 32, 33, 41, 42, 43

text0:          .asciiz "Jose Javier Diaz Gonzalez, alu0101128894\n\n"
text1:          .asciiz  "Practica 4. Trabajando con Matrices.\n"
text2:          .asciiz  "Elija opcion <0> Salir, <1> invertir fila, <2> invertir columna: "

textrows:       .asciiz "Seleccione fila ["
textcols:       .asciiz "Seleccione columna ["
coma:           .asciiz ","
corchete:       .asciiz "]: "
salto_linea:    .asciiz  "\n"
espacio:        .asciiz  " "


    .text


main:

    #s0 = numero de filas
    #s1 = numero de columnas

    la $a0,text1    # imprimir mensaje
    li $v0,4
    syscall

	imprimir_matriz:

        li $v0,4
        la $a0,salto_linea
        syscall

        j matriz
	    continuar:

    li $t0,0    # t0 = 0
    li $t1,2    # t1 = 3

    do_main:

        la $a0,text2
        li $v0,4
        syscall

        li $v0,5 #leemos entero
        syscall

        move $t0,$v0            # seleccion (0,1,2)

        blt $t0,$zero,do_main   # seleccion < 0
        bgt $t0,$t1,do_main     # seleccion > 2
        
    beq $t0,0,final            
    beq $t0,1,invertir_rows     # si seleccion = 1 , salta invertir_rows
    beq $t0,2,invertir_cols

    li $v0,4
    la $a0,salto_linea
    syscall


#Imprimimos invertir filas de la matriz original 4*5 

invertir_rows:
   
    li $t2,1    # t2 = 1

    do_rows: 
        lw $s0,nrows

        la	$a0,textrows
        li	$v0,4
        syscall

        move $a0,$t2    #valor t2 = 1
        li $v0,1        # imprimir entero
        syscall

        la	$a0,coma
        li	$v0,4
        syscall

        move $a0,$s0    # valor s0 = nrows
        li	$v0,1       # imprimir entero
        syscall

        la	$a0,corchete
        li	$v0,4
        syscall

        li	$v0,5 #leer entero
        syscall

        move $t3,$v0 #guardo f en t4

        blt $t3,$t2,do_rows # f < 1
        bgt $t3,$s0,do_rows # f > nrows

    addi $t3,$t3,-1  # -> f--

    li $t1,0    # t1 = j
    li $t2,2    # t2 = 2

    la $s6,matrix
    li $s3,0
    li $s4,0
    sub $s3,$s1,1    # $s3 = ncols - 1
    div	$s3,$t2		 # (ncols -1) / 2 
    mflo $s4		 # guarda en LO = s5

    # aux = matrix[f][j];
	# matrix[f][j] = matrix[f][ncols-1-j];
	# matrix[f][ncols-1-j] = aux;
    
    forrows:
        
        bgt $t1,$s4,imprimir_matriz   # j > (ncols -1) / 2, salta imprimir_matriz

        mul $t4,$t3,$s1         # t5 = f * ncols
        add $t4,$t4,$t1         # t5 = (f * ncols) + j
        mul $t4,$t4,size        # t5 = (f * ncols + j ) * size
        add $t4,$t4,$s6         # t5 = sumo + direccion base

        lw $t5,0($t4)           # matrix[f][j]
        
        sub $s5,$s3,$t1         # s5 = (ncols - 1) - j
        mul $t6,$t3,$s1         # t6 = f * ncols
        add $t6,$t6,$s5         # t6 = (f * ncols) + (ncols - 1 - j)
        mul $t6,$t6,size        # t6 = [(f * ncols) + (ncols - 1 - j)] * size
        add $t6,$t6,$s6         # t6 = sumo + direccion base

        lw $t7,0,($t6)          # matrix[f][ncols-1-j]

        sw $t5,0($t6)           # matrix[f][j] = matrix[f][ncols-1-j];
        sw $t7,0($t4)           # matrix[f][ncols-1-j] = aux;

        addi $t1,$t1,1          # j++

    j forrows

#Imprimimos invertir columnas de la matriz original 4*5 

invertir_cols:
    
    li $t2,1    # t2 = 1

    do_cols: 

        lw $s1,ncols

        la	$a0,textcols
        li	$v0,4
        syscall

        move $a0,$t2    # valor t2 = 1
        li $v0,1        # imprimir entero
        syscall

        la	$a0,coma
        li	$v0,4
        syscall

        move $a0,$s1 # valor s1 = ncols
        li	$v0,1    # imprimir entero
        syscall

        la	$a0,corchete
        li	$v0,4
        syscall

        li	$v0,5   #leer entero
        syscall

        move $t3,$v0    #guardo c en t3

        blt $t3,$t2,do_cols # c < 1
        bgt $t3,$s1,do_cols # c > ncols

    addi $t3,$t3,-1  # -> c--

    li $t0,0    # t0 = i
    li $t2,2    # t2 = 2

    la $s6,matrix
    sub $s3,$s0,1    # $s3 = nrows - 1
    div	$s3,$t2	     # (nrows -1) / 2 
    mflo $s4		 # guarda en LO = s5

    forcols:
        
        bgt $t0,$s4,imprimir_matriz   # i > (nrows -1) / 2, salta do_main
        
        mul $t4,$t0,$s1        # t4 = i * ncols
        add $t4,$t4,$t3         # t4 = (i * ncols) + c
        mul $t4,$t4,size        # t4 = (i * ncols + c ) * size
        addu $t4,$t4,$s6        # t4 = sumo + direccion base

        lw $t5,0($t4)           # matrix[i][c]

        sub $s5,$s3,$t0         # s5 = (nrows - 1) - i
        mul $t6,$s5,$s1         # t6 = (nrows - 1 - i) * ncols
        add $t6,$t6,$t3         # t6 = (nrows- 1 - i * ncols) + c 
        mul $t6,$t6,size        # t6 = (nrows - 1 - i * ncols + c) * size
        addu $t6,$t6,$s6        # t6 = sumo + direccion base

        lw $t7,0,($t6)          # matrix[nrows-1-i][c]

        sw $t5,0($t6)           # matrix[i][c] = matrix[nrows-1-i][c]
        sw $t7,0($t4)           # matrix[nrows-1-i][c] = aux;

        addi $t0,$t0,1          # i++

    j forcols


#Imprimimos la matriz original 4*5

matriz:
	la $s6,matrix
    li $t0,0     # i = 0, filas

    for_matriz_1:
        lw $s0,nrows
        bge $t0,$s0,end_matriz_1   # i >= filas, salta end1
        addi $t0,$t0,1      # i++
        li $t1,0            # j = 0, columnas
        
        for_matriz_2:
            lw $s1,ncols
            bge $t1,$s1,end_matriz_2    # j >= columnas, salta end2
            lw $a0, 0($s6)      # primer elemento del vector matrix
            li $v0,1            # imprimo entero
            syscall

            li $v0,4
            la $a0,espacio
            syscall

            addi $s6,$s6,size   # matrix + size
            addi $t1,$t1,1      # j++

            j for_matriz_2

        end_matriz_2:
            li $v0,4
            la $a0,salto_linea
            syscall

            j for_matriz_1
        
    end_matriz_1:
        li $v0,4
        la $a0,salto_linea
        syscall

	j continuar

final:
    li $v0,10
    syscall