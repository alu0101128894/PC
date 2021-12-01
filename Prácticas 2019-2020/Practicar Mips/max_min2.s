# Con una funcion, hacer el simulacro1

# Calcular el maximo y el minimo de un vector
N=10 # numero de elementos del vector
    .data
vector: .word 3, 2, -1, 4, 7, 8, 12, -8, 1, 0
salto: .asciiz "\n"

    .text

minmax: # funcion que calcula el maximo y minimo deun vector
        # $a0= direccion base del vector, $a1=numero de elmentos del vector
        # debe devolver en: $v0 elmax $v1 min


main:

    # $t2 minimo
    # $t3 maximo
    # $t0 direccion del elemento a comparar
    # $t4 elemento a comparar
    # Cargo la direccion del vector
    la $t0,vector
    # el minimo y el maximo empezaran siendo el primer elemento
    lw $t2,0($t0)
    lw $t3,0($t0)
    li $t1,1 
    
    bucle:
        # voy al siguiene elemento
        addi $t0,4
        # Cargo el siguiente elemento en $t4
        lw $t4,0($t0)
        # Si es mayor que el minimo, no sobreescribo
        bge $t4,$t2,nomin
            lw $t2,0($t0)
        nomin:
        # Si es menor que el maximo, no sobreescribo
            ble $t4,$t3,nomax
            lw $t3,0($t0)
        nomax:
            # cuento el siguiente elemento
            addi $t1,1
        # Si es menor o igual que el numero de elementos, repite
        ble $t1,N,bucle

    move $a0,$t2
    li $v0,1
    syscall

    la $a0,salto
    li $v0,4
    syscall

    move $a0, $t3
    li $v0,1
    syscall


    li $v0, 10
    syscall