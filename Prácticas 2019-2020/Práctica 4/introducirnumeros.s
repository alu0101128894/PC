
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

    .text

main:
    #so = numero de filas
    #s1 = numero de columnas
    #multiplico $s0*$s1*4 y si eso es mayor que maxdim vuelva a preguntar

    do:
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
            
            j do

continuar:

    la $a0, msgintro
    li $v0,4
    syscall
    
    mul $t0, $s0, $s1
    li $t1,0
    la $s3, matrix2
    
    bucleintro:
        bge $t1, $t0, finintroducir # i >= (rows*cols)

        li $v0,5
        syscall
        #en v0 tengo lo que el usuario metio por teclado
        sw $v0,0($s3)
        addi $s3,4
        addi $t1,1
        j bucleintro
    
    finintroducir:
    
    li $v0,10
    syscall
