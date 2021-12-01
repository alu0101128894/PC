		.text
main:

	li $t0,3         # Banco registro 00000000000000000000000000000011
	li.s $f20,5.6    # IEEE754     signo   exponente    mantisa
	# quiero multiplicar $t0 * $f20
	mtc1 $t0,$f22    # esta instrucción copia "crudo" del registro $t0 al $f22, $f22 = 0   000000000000  0000000000000000011
	cvt.s.w $f24,$f22  # $f24 = convertido_al_formato_IEEE754($f22)
	mul.s $f26,$f20,$f24

	li $v0,2
	mov.s $f12,$f26
	syscall
	
	
	li.s $f4,3.0
	cvt.w.s $f6,$f4
	mfc1 $t1,$f6

	li $v0,10
	syscall