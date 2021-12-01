#Entrada y salida - entero

        .data
numero:         .asciiz "Introduzca un numero flotante: "
suma:           .asciiz "La suma es: "
        .text

main: 

    li $v0,4 # cadena = 4
    la $a0,numero
    syscall

    li $v0,6 
    syscall  
    mov.s $f4,$f0
    

    li $v0,4
    la $a0,numero
    syscall
    li $v0,6
    syscall  
    mov.s $f5,$f0 
    
############################################

    add.s $f2,$f4,$f5

    li $v0,4
    la $a0,suma
    syscall

    li $v0,2 
    mov.s $f12,$f2
    syscall


    li $v0,10
    syscall
    
 