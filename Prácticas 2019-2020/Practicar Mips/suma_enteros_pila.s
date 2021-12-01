maxlen=200
    .data
cadena: .space maxlen
nombre: .asciiz "\nFin del proframa\n"
cadsum: .asciiz "La suma es: "

    .text

printf: # $a0, direccion de memoria de la cadena a imprimir
        # no devuelve nada solo muestra por pantalla
    li $v0,4
    syscall
    jr $ra

# Esta funcion si necesita pila
suma_enteros:   # recibe en $a0 el primer entero
                # recibe en $a1 el segundo entero
                # escribe por pantalla "la suma es " y el resultado

    # hago un push en la pila y me guardo $ra (es un registro de 4 bytes)
    addi $sp,-8 # reservo espacio en la pila
    sw $ra,0($sp) # guardo $ra en la pila
    sw $a0,4($sp) # guardo $a0 en la pila
    
    la $a0,cadsum
    jal printf # $ra = machaca la enterior y ya no puede vovler al main

    lw $a0,4($sp) # recupero el $a0 que guarde en la pila porque se modifico
    add $t0,$a0,$a1 # $t0 la suma de los dos
    move $a0,$t0
    li $v0,1
    syscall

    # hago pop de $ra de la pila
    lw $ra,0($sp)
    lw $a0,4($sp)
    addi $sp,8
    jr $ra

main:

    li $a0,3
    li $a1,5
    jal suma_enteros # $ra = guarda la siguiente instruccion

    # la $a0,cadsum
    # jal printf

    li $v0,10
    syscall



