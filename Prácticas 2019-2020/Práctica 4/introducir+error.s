
size = 4 #bytes que ocupa cada elemento
maxdim = 400

    .data
#nrows:      .word   4   # filas
#ncols:      .word   3   # columnas


#matrix:     .word  11, 12, 13
            #.word  21, 22, 23
           # .word  31, 32, 33
          #  .word  41, 42, 43

matrix2:       .space maxdim

rows:          .asciiz "Introduce el numero de filas: "
cols:          .asciiz "Introduce el numero de columnas: "
text_error:    .asciiz "--> Tamano maximo sobrepasado. Escribe de nuevo\n"
msgintro:      .asciiz "Introduce los elementos de la matriz (separados por ENTER): \n"

text1:          .asciiz  "\nPractica 4. Trabajando con Matrices.\n"
text4:          .asciiz  "Elija opcion <0> Salir, <1> invertir fila, <2> invertir columna: "

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
    # valores usados = s0,s1,s2,t0,t1,t2
    do_introducir:
        la $a0,rows
        li $v0,4
        syscall

        li	$v0,5 
	    syscall

	    move $s0,$v0 # s0 = filas

        la $a0,cols
        li $v0,4
        syscall

        li	$v0,5 
	    syscall

	    move $s1,$v0 # s1 = columnas

        mul $t2,$s0,$s1             # filas * columnas
        mul $t2,$t2,size            # (filas * columnas) * size 
        bgt $t2, maxdim, error      # t2 > 400, salta error 

        b continuar

        error:
            la $a0,text_error
            li $v0,4
            syscall
            
            j do_introducir

    continuar:

    la $a0, msgintro
    li $v0,4
    syscall
    
    mul $t0, $s0, $s1
    li $t1,0
    la $s2, matrix2
    
    bucleintro:
        bge $t1, $t0, continuar3 # >=

        li $v0,5
        syscall
        #en v0 tengo lo que el usuario metio por teclado
        sw $v0,0($s2)
        addi $s2,4
        addi $t1,1
        j bucleintro

#########################################################################################

    continuar3:
    
    la $a0,text1    # imprimir mensaje
    li $v0,4
    syscall

    j matriz        # Imprimir matriz 
    continuar2:

    # t3 = seleccion 
    # s3 = 2 
    do_main:
        la $a0,text4
        li $v0,4
        syscall

        li $v0,5 #leemos entero
        syscall

        move $t3,$v0            # seleccion (0,1,2)

        blt $t3,$zero,do_main   # seleccion < 0
        li $s3,2                # s3 = 2
        bgt $t3,$s3,do_main     # seleccion > 2
        
    beq $t3,0,final            
    beq $t3,1,invertir_rows     # si seleccion = 1 , salta invertir_rows
    beq $t3,2,invertir_cols

    li $v0,4
    la $a0,salto_linea
    syscall

# s0 = nrows  
# s1 = ncols  
# t4 = matrix 
# t5 = 0 -> i  
# t6 = 0 -> j 

#Imprimir matriz
matriz:

    la $t4,matrix2
    li $t5,0      #contador i = 0, filas

    for1:
        bge $t2,$s0,end1  # i >= filas, salta end1
        addi $t5,$t5,1 # i++
        li $t6,0 #contador j = 0, columnas
        
        for2:
            bge $t3,$s1,end2 # j >= columnas, salta end2
            lw $a0, 0($t4) #primer elemento del vector matrix
            li $v0,1   #imprimo entero
            syscall

            li $v0,4
            la $a0,espacio
            syscall

            addi $t4,$t4,size # matrix + size
            addi $t6,$t6,1 # j++

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

invertir_rows:

    do_rows: 
        #lw $s1,nrows
        li $s3,1

        la	$a0,textrows
        li	$v0,4
        syscall

        move $a0,$s3 #valor s3 = 1
        li $v0,1 # imprimir entero
        syscall

        la	$a0,coma
        li	$v0,4
        syscall

        move $a0,$s1 # valor s1 = nrows
        li	$v0,1 # imprimir entero
        syscall

        la	$a0,corchete
        li	$v0,4
        syscall

        li	$v0,5 #leer entero
        syscall

        move $t4,$v0 #guardo f en t4

        blt $t4,$s3,do_rows # f < 1
        bgt $t4,$s1,do_rows # f > nrows

    addi $t4,$t4,-1  # -> f--

    la $t1,matrix2
    li $t2,0 	     # j = 0
    sub $s4,$s2,1    # $s4 = ncols - 1
    div	$s4,$s0		 # (ncols -1) / 2 
    mflo $s5		 # guarda en LO = s5

    # t5, t6, t7, t8, s5, s6 -> valores usados

    forrows:
        
        bgt $t2,$s5,do_main	# j > (ncols -1) / 2, salta do_main

        mul $t5,$t4,$s2     # t5 = f * ncols
        add $t5,$t5,$t2     # t5 = (f * ncols) + j
        mul $t5,$t5,size    # t5 = (f * ncols + j ) * size
        add $t5,$t5,$t1     # t5 = sumo + direccion base

        lw $t6,0($t5)       # matrix[f][j]
        
        mul $t7,$t4,$s2     # t7 = f * ncols
        sub $s6,$s4,$t2     # s6 = (ncols - 1) - j
        add $t7,$t7,$s6     # t7 = (f * ncols) + (ncols - 1 - j)
        mul $t7,$t7,size    # t7 = [(f * ncols) + (ncols - 1 - j)] * size
        add $t7,$t7,$t1     # t7 = sumo + direccion base

        lw $t8,0,($t7)      # matrix[f][ncols-1-j]

        sw $t6,0($t7)       # matrix[f][j] = matrix[f][ncols-1-j];
        sw $t8,0($t5)       # matrix[f][ncols-1-j] = aux;

        addi $t2,$t2,1      # j++

    j forrows


   final:
    li $v0,10
    syscall
