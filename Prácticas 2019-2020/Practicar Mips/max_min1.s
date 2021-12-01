# Calcular el maximo y el minimo de un vector
N=10 # numero de elementos del vector
    .data
vector: .word 3, 2, -1, 4, 7, 8, 12, -8, 1, 0
salto: .asciiz "\n"


    .text
    
bucle:
         # $t2 minimo
    # $t3 maximo
    # $t0 direccion del elemento a comparar
    # $t4 elemento a comparar
    # Cargo la direccion del vector
    
    la $t0,vector
    # el minimo y el maximo empezaran siendo el primer elemento
    lw $t2,0($t0) # -> minimo
    lw $t3,0($t0) # -> maximo
    li $t1,1 

        addi $t0,4         # voy al siguiene elemento
        lw $t4,0($t0)      # Cargo el siguiente elemento en $t4
        
        bge $t4,$t2,nomin   # t4 >= t2 salta a nomin --> # Si es mayor que el minimo, no sobreescribo
        lw $t2,0($t0)       # cargas

        nomin:
            ble $t4,$t3,nomax   # t4 <= t2, salta a nomax --> # Si es menor que el maximo, no sobreescribo
            lw $t3,0($t0)       # cargas

        nomax:
            addi $t1,1       # cuento el siguiente elemento

        ble $t1,$a1,bucle   # Si es menor o igual que el numero de elementos, repite

main:

    li $a1,N
    jal bucle
    jr $ra

    move $a0,$t2
    li $v0,1
    syscall
    
    la $a0,salto
    li $v0,4
    syscall

    move $a0,$t3
    li $v0,1
    syscall

    li $v0,10
    syscall
   

