
# suma 
#     recibe como argumentos dos numeros en punto flotante
#     devuelve la suma de dos numeros

# solicita
#     pide dos numeros floantes por consola
#     llama la funcion suma
#     devuelve 1 si la suma es mayor que cualquiera de los dos sumandos
#     y 0 caso contrario

# el main debe llamar a "solicita" hasta que devuelva 0

    .data

frase:  .asciiz "Introduzca un flotante: "
    .text

solicita:

    addi $sp,$sp,-4  # Primero guarda $ra en la pila para saber donde debe volver
    sw $ra,0($sp) # guardo ra

    la $a0,frase
    li $v0,4
    syscall

    li $v0,6
    syscall
    mov.s $f20,$f0 # primer valor f20 -> temporal salvado, preserva entre llamada

    la $a0,frase
    li $v0,4
    syscall

    li $v0,6
    syscall
    mov.s $f21,$f0 # segundo valor f21

    jal suma # llamo la funcion suma

    # do{
    #     si la suma es mayor que f20 y f21 salta y imprime 1
    # while( f6 > f20 || f6 > f20)

    li $v0,0

    # Hago las comparaciones para saber si devuelvo un 0 o un 1

    c.le.s $f6,$f20 #  suma <= f20 -> 0
    bc1t abajo  
      
    c.le.s $f6,$f21 # suma <= f21 -> 0
    bc1t abajo  

    li $v0,1 #v0 = 1

    abajo:   
        lw $ra,0($sp) # recupero los valores anteriores
        addi $sp,$sp,4 # dejo el puntero de pila como estaba

    jr $ra

suma:
    li.s $f6,0.0 # f6 = 0.0
    add.s $f6,$f20,$f21 # f6 = f20 + f21
    jr $ra

main:

    bucle:
        jal solicita # devuelve o un 0 o un 1

        beq $v0,$zero,hastaluego # v0 == 0 salta
        j bucle

    hastaluego:
        li $v0,10
        syscall
