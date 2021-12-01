#recorrido de un vector - suma

n = 10
tamayo = 4

    .data
vector:     .word 1, 3, 2, 4, 6, 5, 7, 9, 8, 10
suma:       .word 0
    .text

main: 
    move $s0,$zero #s0 contendra la suma de todos los elementos

    la $s1,vector #guardo s1 la direccion del vector
    move $t0,$zero # t0 contendra el indice, empezando por 0
    li $t2,tamayo # t2 contiene el tamaño

    bucle: 
        mul $t1,$t0,$t2 # t1 = indice * tamaño
        addu $t1,$s1,$t1 # t1 = (indice * tamaño) + dureccion del vector
        lw $t1,0($t1) #t1 contiene el elemento
        add $s0,$s0,$t1 # acumulo s0 = s0 + vector[t0]
        addi $t0,$t0,1 # calculo el siguiente indice
        blt $t0,n,bucle # si t0 < 10, salta a bucle
        sw $s0,suma

        li $v0,10
        syscall