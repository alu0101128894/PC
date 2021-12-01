reverse_r:
    bgt    $a1,1,mayor    #(1) 5 > 2, tonces salto    #(3) 3 > 2, tonces salto    #(5) 1 > 2, no salto
    li    $v0,1                                         #(5) v0 = 1 es capicua
    jr    $ra                                         #(5) salta a (6)


    mayor:    addi    $sp,$sp,-12    #(2)reservo espacio pila
        sw    $ra,0($sp)
        sw    $a0,4($sp)
        sw    $a1,8($sp)
                    #(2)guardo dir en pila (dir de (8))
        addi    $a0,$a0,1    #(2)a0 = apunta sig elem'o'
        addi    $a1,$a1,-2    #(2)a1 = 3
        jal    reverse_r    #(2)ra = linea de abaj. dir de(6)

        lw    $a0,4($sp)
        lw    $a1,8($sp)
                        #(7)t0 = 'h'
        addi    $t2,$a1,-1        #(6)t2 = 2 lo usare para sumar
                        #   y apuntar al final
        add    $t7,$a0,$t2        #(6)t7 apunta al ultimo 'a'

                        #
        lb    $t1,0($t7)        # t1 = 'a'
        lb    $t0,0($a0)        #(6)t0 = 'o'
        beq    $t0,$t1,igual        # si son iguales salta
        li    $v0,0            # como no es capicua

    igual:

        sb    $t0,0($t7)        # t0 = 'o'
        sb    $t1,0($a0)        # a0(pos.2) metemos 'a'


        lw    $ra,0($sp)        # cuidado con el orden lw y addi
        addi    $sp,$sp,12        # cuidado con el orden lw y addi
        jr    $ra

        # devuelve 1 si capicua