# potencias

# recibe un numero flotante y un numero entero mayor o igual a 0
# devuelve el resultado de elevar el numero en punto flotante

# sumadepotencias:
# recibe la direccion de memoria 
# haciendo uso de la funcion anterior , calcula la suma de cada elementos del vector elevado al 
# indice

# vector de numero flotantes 

#funcion
#potencia:
#$f12 <- flotante
# $a0 = potencia a elevar
# f0 = ($f12) ^ $a0

#suma_potencia: 
# $a0 dir del vector
# $a1 longitud       (1.3)^0 + (2.5)^1 + (1.7)^2


N = 4
size = 4

    .data
vector: .float 1.0, 2.0, 1.0, 1.0
    .text

potencia:   # f12 flotante en simple precision -> base de la potencia
            # $a0 = potencia a elevar 
            # f0 = ($f12) ^ $a0

            # si b es la base, p es la botencia
            # float b, int p
            # resultado = 1.0
            # for (i=0, i<p, i++){
            #   resultado = resultado * base
            # }

            # todo numero elevado a 0 = 1

            # ti = i
            # f0 = resultado  = 1
            
            li $t1,0
            li.s $f0,1.0

            for_potencia:
                bge $t1,$a0,fin_potencia # si es mayor igual, salta

                mul.s $f0,$f0,$f12 # f0 = f0 * f12 
                addi $t1,1
                j for_potencia
                fin_potencia:
                    jr $ra

suma_potencias:     # $a0 dir del vector (simple precision)
                    # $a1 longitud 
                    # f0 = v[0]^0 + v[0]^0 + ... + v[N]

                    addi $sp,-4
                    sw $ra,0($sp)

                    li $t0,0  # i
                    move $t2,$a0
                    li.s $f16,0.0

                    bucle_suamapot:
                        l.s $f12,0($t2) # si pongo ($a0) debajo, hay que guardarlo en otro registro
                        move $a0,$t0    # estoy sobreescribiendo (move $a0,$t0)
                       
                        # usar push, precaucion guardar pila 
                       
                        jal potencia    # devuelve en $f0 = $f12 ^$a0

                        # guardar pop

                        add.s $f16,$f16,$f0 # devuelve en $f0 = $f12 ^ $a0
                        addi $t2,size
                        addi $t0,1
                        blt $t0,$a1,bucle_suamapot # a1 = numero de elementos (longitud)

                    mov.s $f0,$f16 # lo guardo en f0
                    #jr $ra -> no se puede

                    lw $ra,0($sp)
                    addi $sp,4
                    jr $ra

# si una funcion llama a otra funcion, $ra se pierde = usar pila

main: 

    # li.s $f12,2.0
    # li $a0,3        #- > (2.0)^3
    # jal potencia

    la $a0,vector
    li $a1,N
    jal suma_potencias    

    #cuando regrese

    li $v0,2
    mov.s $f12,$f0
    syscall

    li $v0,10
    syscall
