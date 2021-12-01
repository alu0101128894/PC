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


for (j = 0; j <= (ncols-1) / 2; j++) {
	aux = matrix[f][j];
	matrix[f][j] = matrix[f][ncols-1-j];
	matrix[f][ncols-1-j] = aux;
}



1 2 3 4 -> 4 (n-1)

for(i=0; i < n; i++){
 
    v[i] = V[n-1-i]

 }

 H O L A

 pi = 0

 pf = tamaño palabra - 1
 pf = 

 p1 = 0
 pf = i - 1

 while( pi < pf){

    aux = palabra[pi]
    palabra[pi] = palabra[pf]
    palabra[pi]=aux

    pi++
    pff--
}


for (i=0, j = longitud-1; i < longitud/2; i++,j--)
{
	temporal=cadena[i];
	cadena[i]=cadena[j];
	cadena[j]=temporal;
}