#Entrada y salida - entero

        .data
entero:         .asciiz "Introduzca un entero: "
suma:           .asciiz "La suma es: "
        .text

main: 

    li $v0,4 # cadena = 4
    la $a0,entero
    syscall

    li $v0,5 #v0 = 5 leemos entero
    syscall  
    move $t0,$v0 #almacenamos en t0 el primer entero 
    

    li $v0,4
    la $a0,entero
    syscall
    li $v0,5 #v0 = 5 leemos entero
    syscall  
    move $t1,$v0 #almacenamos en t1 el segundo entero
    
############################################

    add $t2,$t0,$t1 #suma t0 + t1

    li $v0,4
    la $a0,suma
    syscall

    li $v0,1 #imprimir entero
    move $a0,$t2
    syscall


    li $v0,10
    syscall
    
 