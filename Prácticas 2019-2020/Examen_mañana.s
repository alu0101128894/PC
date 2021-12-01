    .data
titulo:				.asciiz	"Introduzca dos numeros para que sean sumados separados por retorno de carro: "

    .text   



    solicita:   # No recibe argumentos
                # llamara a la fucion suma
                # devuelve un 1 o un 0 en $v0
        # Primero guarda $ra en la pila para saber donde debe volver
        addi $sp,$sp,-4
        sw $ra,0($sp) # guardo $ra

        # Pido los numero por consola
        la $a0, titulo
        li $v0,4
        syscall
        
        # Recojo el primero
        li $v0,6
        syscall
        mov.s $f20,$f0
        # en $f20 tengo el primer numero

        # recojo el segundo
        li $v0,6
        syscall
        mov.s $f22,$f0
        # en $f22 tengo el segundo numero

        # llamo a la funcion suma
        jal suma
        # me devuelve la suma de los numeros en $f2
        # primero cargo un 0
        move $v0,$zero
        # Hago la comparacion para saber si devuelvo un 0 o un 1
        c.le.s $f2,$f20
        bc1t finsolicita
        c.le.s $f2,$f22
        bc1t finsolicita
        li $v0,1

        finsolicita:
            # recupero los valores anteriores
		    lw $ra,0($sp)
            addi $sp,$sp,4 # dejo el puntero de pila como estaba

            jr $ra # vuelvo al main

    suma:
        # Recibe en $f20 y $f22 los numeros a sumar
        # Devuelve en $f2 el resultado
        li.s $f2,0.0 # lo pongo a cero primero
        add.s $f2,$f20,$f22

        jr $ra

    main:

        Repetir:
            jal solicita
            # Devuelve en $v0 u 0 o un 1
            
        # Comparacion
        beq $v0,$zero,fin
        j Repetir

        fin:
            li $v0,10
            syscall