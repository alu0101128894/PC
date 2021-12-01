
#MODIFICACION FILAS Y COLUMNAS

size = 4 #bytes que ocupa cada elemento
maxdim = 400

    .data
#nrows:      .word   4   # filas
#ncols:      .word   3   # columnas


#matrix:     .word  11, 12, 13, 21, 22, 23, 31, 32, 33, 41, 42, 43

matrix2:       .space maxdim

text0:           .asciiz "Jose Javier Diaz Gonzalez, alu0101128894\n\n"
text1:          .asciiz  "Practica 4. Trabajando con Matrices.\n"
text2:          .asciiz  "Elija opcion <0> Salir, <1> invertir fila, <2> invertir columna: "

textrows:       .asciiz "Seleccione fila ["
textcols:       .asciiz "Seleccione columna ["
coma:           .asciiz ","
corchete:       .asciiz "]: "
salto_linea:    .asciiz  "\n"
espacio:        .asciiz  " "

rows:          .asciiz "Introduce el numero de filas: "
cols:          .asciiz "Introduce el numero de columnas: "
text_error:    .asciiz "\n--> Tamano maximo sobrepasado. Escribe de nuevo\n\n"
msgintro:      .asciiz "\nIntroduce los elementos de la matriz (separados por ENTER): \n\n"

    .text

main:

    #s0 = numero de filas
    #s1 = numero de columnas

        la $a0,text0
        li $v0,4
        syscall

    do_introducir:

        la $a0,rows
        li $v0,4
        syscall

        li	$v0,5 
	    syscall

	    move $s0,$v0    # s0 = filas

        la $a0,cols
        li $v0,4
        syscall

        li	$v0,5 
	    syscall

	    move $s1,$v0                # s1 = columnas

        mul $t2,$s0,$s1             # t2 = filas * columnas
        mul $t2,$t2,size            # t2 = (filas * columnas) * size 
        bgt $t2, maxdim, error      # t2 > 400, salta error 

        b salto_abajo

        error:
            la $a0,text_error
            li $v0,4
            syscall
            
            j do_introducir

    salto_abajo:

    la $a0, msgintro
    li $v0,4
    syscall
    
    mul $t0, $s0, $s1   # t0 = filas * columnas
    li $t1,0 
    la $s2, matrix2
    
    bucleintro:

        bge $t1, $t0, salto_bucle_intro     #  >=

        li $v0,5
        syscall
        #en v0 tengo lo que el usuario metio por teclado
        sw $v0,0($s2)
        addi $s2,4
        addi $t1,1
        j bucleintro

    salto_bucle_intro:
	
	li $v0,4
    la $a0,salto_linea
    syscall

    la $a0,text1    # imprimir mensaje
    li $v0,4
    syscall

	imprimir_matriz:

        li $v0,4
        la $a0,salto_linea
        syscall

        j matriz2
	    continuar2:

    li $t0,0    # t0 = 0
    li $t1,2    # t1 = 2

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

# s0 = numero de filas
# s1 = numero de columnas
# s2 = matrix 
# t0 -> i 
# t1 -> j

invertir_rows:
   
    li $t2,1    # t2 = 1

    do_rows: 
        #lw $s0,nrows

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

    la $s2,matrix2
    sub $s3,$s1,1    # $s3 = ncols - 1
    div	$s3,$t2		 # (ncols -1) / 2 
    mflo $s4		 # guarda en LO = s5

    forrows:
        
        bgt $t1,$s4,imprimir_matriz   # j > (ncols -1) / 2, salta imprimir_matriz

        mul $t4,$t3,$s1         # t5 = f * ncols
        add $t4,$t4,$t1         # t5 = (f * ncols) + j
        mul $t4,$t4,size        # t5 = (f * ncols + j ) * size
        add $t4,$t4,$s2         # t5 = sumo + direccion base

        lw $t5,0($t4)           # matrix[f][j]
        
        sub $s5,$s3,$t1         # s5 = (ncols - 1) - j
        mul $t6,$t3,$s1         # t6 = f * ncols
        add $t6,$t6,$s5         # t6 = (f * ncols) + (ncols - 1 - j)
        mul $t6,$t6,size        # t6 = [(f * ncols) + (ncols - 1 - j)] * size
        add $t6,$t6,$s2         # t6 = sumo + direccion base

        lw $t7,0,($t6)          # matrix[f][ncols-1-j]

        sw $t5,0($t6)           # matrix[f][j] = matrix[f][ncols-1-j];
        sw $t7,0($t4)           # matrix[f][ncols-1-j] = aux;

        addi $t1,$t1,1          # j++

    j forrows

invertir_cols:
    
    li $t2,1    # t2 = 1

    do_cols: 
        #lw $s1,ncols

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

    la $s2,matrix2
    sub $s3,$s0,1    # $s3 = nrows - 1
    div	$s3,$t2	     # (nrows -1) / 2 
    mflo $s4		 # guarda en LO = s5

    forcols:
        
        bgt $t0,$s4,imprimir_matriz   # i > (nrows -1) / 2, salta do_main
        
        mul $t4,$t0,$s1         # t4 = i * ncols
        add $t4,$t4,$t3         # t4 = (i * ncols) + c
        mul $t4,$t4,size        # t4 = (i * ncols + c ) * size
        addu $t4,$t4,$s2        # t4 = sumo + direccion base

        lw $t5,0($t4)           # matrix[i][c]

        sub $s5,$s3,$t0         # s5 = (nrows - 1) - i
        mul $t6,$s5,$s1         # t6 = (nrows - 1 - i) * ncols
        add $t6,$t6,$t3         # t6 = (nrows - 1 - i * ncols) + c 
        mul $t6,$t6,size        # t6 = (nrows - 1 - i * ncols + c) * size
        addu $t6,$t6,$s2        # t6 = sumo + direccion base

        lw $t7,0,($t6)          # matrix[nrows-1-i][c]

        sw $t5,0($t6)           # matrix[i][c] = matrix[nrows-1-i][c]
        sw $t7,0($t4)           # matrix[nrows-1-i][c] = aux;

        addi $t0,$t0,1          # i++

    j forcols

#Imprimir matriz

matriz2:
	la $s2,matrix2
    li $t0,0     # i = 0, filas

    for1:
        bge $t0,$s0,end1    # i >= filas, salta end1
        addi $t0,$t0,1      # i++
        li $t1,0            # j = 0, columnas
        
        for2:
            bge $t1,$s1,end2    # j >= columnas, salta end2
            lw $a0, 0($s2)      # primer elemento del vector matrix
            li $v0,1            # imprimo entero
            syscall

            li $v0,4
            la $a0,espacio
            syscall

            addi $s2,$s2,size   # matrix + size
            addi $t1,$t1,1      # j++

            j for2

        end2:
            li $v0,4
            la $a0,salto_linea
            syscall

            j for1
        
    end1:
        li $v0,4
        la $a0,salto_linea
        syscall

	j continuar2

final:
    li $v0,10
    syscall