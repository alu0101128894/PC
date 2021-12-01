N = 10

    .data
imp_cadena:    .asciiz "Introduzca el porcentaje: "
vector:        .double 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0
coma:           .asciiz ", "
salto_linea: .asciiz "\n"
    .text


# Hacer una funcion que dado un numero flotantes de doble presicion devuelva
# ese mismo nuemero aumentado en un %

# recibe en f12 = double que hay que aumentar un porcentaje
# recibe en % f14 = porcentaje a aumentar f12
# devuelve en f0 = f12 + (f12 * f14/100)

porcentaje: # salvado no se debe usar en funciones
    mov.d $f18,$f14
    li.d $f16,100.0

    div.d $f18,$f18,$f16  #  f18 / 100
    mul.d $f18,$f12,$f18  # f12 * f18 / 100
    add.d $f0,$f12,$f18   # f12 + ..

    jr $ra

proc_vect:  # aplica un porcentaje a un vector de flotantes doble presicion
            # que debe solicitarse por consola
            # a0 = se pasa la direccion del vector double 
            # a1 = el numero de elementos del vector

            #guardo la pila en $ra, reservo espacio en la pila
            addi $sp,$sp,-8
            sw $ra,0($sp)
            sw $a0,4($sp)

            li $v0,7 # pido el porcentaje por consola
            syscall
            
            mov.d $f14,$f0 # en f0-f1 tengo el flotante que se leyo, lo muevo a f14

            move $t1,$zero # contador
            lw $a0,4($sp)

            repetir:  
                l.d $f12,0($a0)  # cargo el numero en la posicion a0
                jal porcentaje   # llamo la funcion

                s.d $f0,0($a0) # retorna con el porcentaje en f0, y lo guardo en a0

                addi $a0,8 
                addi $t1,1

                blt $t1,$a1,repetir # menor que el num de elemento repite

            lw $ra,0($sp) # recupero el valor anterior de $ra
            addi $sp,8

            jr $ra

             
print_vect: # imprime un vector de double por consola
            # a0 = direccion de memoria del vector de double a imprimir
            # a1 = numero de elementos del vector
            
            li $t0,0 # i
            move $t1,$a0
            bucle:

                bge $t0,$a1,fin # t0 >= a1
                l.d $f12,0,($t1)
                li $v0,3
                syscall

                la $a0,coma
                li $v0,4
                syscall

                addi $t1,8 # numero de elementos++ -> un double ocupa 8 bytes
                addi $t0,1 # i++

                j bucle

            fin: 
                la $a0,salto_linea
                li $v0,4
                syscall
                jr $ra

main:
    
    la $a0,vector
    li $a1,N
    jal print_vect

    la $a0,vector
    li $a1,N
    jal proc_vect

    la $a0,vector
    li $a1,N
    jal print_vect

    li $v0,10
    syscall