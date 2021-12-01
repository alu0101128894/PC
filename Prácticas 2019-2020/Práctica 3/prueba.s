for:
        bge $s0,$s1,fin

        mtc1 $s0,$f7
        cvt.s.w $f17,$f7

        mul.s $f16,$f22,$f17 # c*x
        add.s $f16,$f16,$f23  #c*x + d

        
        mul.s $f4,$f17,$f17 #c*x +d + b*x*x
        mul.s $f5,$f21,$f4
        add.s  $f16,$f16,$f5

        #c*x + d + b*x*x + a*x*x*x

        mul.s $f4,$f17,$f4
        mul.s $f6,$f20,$f4
        add.s $f16,$f16,$f6
        
        #imprimimos 

        la	$a0,l_f
        li	$v0,4
        syscall

        #imprimo la x

        move $s0,$a0
        li $v0,1
        syscall

        la	$a0,cad_igual
        li	$v0,4
        syscall

        #imprimo la f

        mov.s $f12,$f16
        li $v0,2
        syscall

        add.s $f17,$f17,$f19 #x++
        addi $s0,1

        j for