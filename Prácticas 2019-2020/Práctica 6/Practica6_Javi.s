# PRACTICA 6

# Leer la consola



    .data
text0: .asciiz "Jose Javier Diaz Gonzalez"
text: .asciiz "Practica 6. Suma de dos enteros entre 0 y 10 normalizados. Repite operacion hasta que la suma normalizada sea 0.\n\n"
text2: .asciiz "Introduzca el primer entero entre 0 y 10: "
text3: .asciiz "Introduzca el segundo entero entre 0 y 10: "
resultado: .asciiz "El resultado de la suma normalizada es: "
fin:        .asciiz "FIN. El resultado de la suma normalizada ha sido cero y el programa ha finalizado."

    .text

normaliza:

    li $v0,5 # read int
    syscall
    
    move $t0,$v0    # t0 = primer valor

    mtc1 $t0,$f2   # esta instruccion copia "crudo" del registro $t0 al $f2
    cvt.s.w $f4,$f2  # $f4 = convertido al formato_IEEE754 ($f4) 

    li.s $f7,10.0 
    div.s $f4,$f4,$f7 # f4 = f4 (los dos numeros
    
    j $ra

suma:

    add.s $f8,$f5,$f6 # f8 = f5 + f6

    j $ra

main:
        la $a0,text0
        li $v0,4
        syscall

        la $a0,text 
        li $v0,4
        syscall

    bucle1: 

        la $a0,text2
        li $v0,4
        syscall

        jal normaliza
        mov.s $f5,$f4    # directamente esta convertido
        li $t2,10
        blt $t0,$zero,bucle1         # t0 < 0
        bgt $t0,$t2,bucle1            # t1 > 10
    
    bucle2:
    
        la $a0,text3
        li $v0,4
        syscall
        
        jal normaliza
        mov.s $f6,$f4  # ya lo tengo convertido, el f4 y listo
        li $t2,10
        blt $t0,$zero,bucle2          # t1 < 0
        bgt $t0,$t2,bucle2           # t1 > 10

        
        la $a0,resultado
        li $v0,4
        syscall
        
        jal suma
        mov.s $f12,$f8 #lo imprimo por consola (f8) , f12 imprimir flotante
        li $v0,2    # imprimo flotante
        syscall

li $v0,10
syscall
