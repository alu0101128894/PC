#Entrada y salida - entero

        .data
numero:         .asciiz "Introduzca un numero flotante: "
suma:           .asciiz "La suma es: "
        .text

main: 

    li $v0,4 # cadena = 4
    la $a0,numero
    syscall

    li $v0,6 #v0 = 6 flotante
    syscall  
    mov.s $f4,$f0
    
    li $v0,4 # cadena = 4
    la $a0,numero
    syscall

    li $v0,6 #v0 = 6 flotante
    syscall 
    mov.s $f5,$f0
   
############################################

    add.s $f3,$f4,$f5

    li $v0,2
    mtc1 $t0,$f3
    cvt.w.s $t0,$t2

    li $v0,4
    la $a0,suma
    syscall

    li $v0,1 #imprimir entero
    move $t0,$t4
    syscall

    li $v0,10
    syscall
    
#mtc1 $f0,$t0 #convertimos el flotante en entero
#cvt.w.s $t0,$t2 #entero a simple precision