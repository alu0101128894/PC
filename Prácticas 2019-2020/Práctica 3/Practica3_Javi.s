
#Practica 3. Jose Javier Diaz Gonzalez

    .data		# directiva que indica la zona de datos
practica3:			.asciiz		"Practica 3. Jose Javier Diaz Gonzalez\n\n"
titulo: 			.asciiz		"Evaluacion polinomio f(x) = a x^3  + b x^2 + c x + d  en un intervalo [r,s]\n"
valores_abcd:		.asciiz		"Introduzca los valores de a,b,c y d (separados por retorno de carro): \n"
valores_rs:			.asciiz		"Introduzca [r,s] (r y s enteros, r <= s) (separados por retorno de carro):\n"
cadena1:			.asciiz     "f("
cadena2: 			.asciiz 	") = "
salto_de_linea: 	.asciiz		"\n"
	.text		# directiva que indica la zona de codigo

main:

	la	$a0,practica3
	li	$v0,4
	syscall

	la	$a0,titulo
	li	$v0,4
	syscall

    la $a0,valores_abcd
	li	$v0,4
	syscall

	li	$v0,6 		# flotante que se lee
	syscall
	mov.s $f20,$f0 	# lee el flotante y la guardo en f1

    li	$v0,6
	syscall
	mov.s $f21,$f0 	# b

    li	$v0,6
	syscall
	mov.s $f22,$f0 	# c 

    li	$v0,6
	syscall
	mov.s $f23,$f0 	# d

# int r,s;
# 	do {
# 		cout << "Introduzca [r,s] (r y s enteros, r <= s) (separados por retorno de carro):" << std::endl;
# 		cin >> r;
# 		cin >> s;
# 	} while (r > s);

while:

	la	$a0,valores_rs
	li	$v0,4
	syscall
	
	li	$v0,5 		# leer entero
	syscall
	move $t0,$v0 	# guardo el valor t0 = r

	li	$v0,5 		
	syscall
	move $t1,$v0 	# guardo el valor t1 = s

	bgt $t0,$t1,while # r > s salta

# float f;
# int x;
# 	for ( x = r ; x <= s ; x++) {
# 		f = a*x*x*x + b*x*x + c*x + d;
# 		cout << "f(" << x << ") = " << f << endl;
# 	}	

# a = f20
# b = f21
# c = f22
# d = f23

for:

	li.s $f25, 0.0
	li.s $f26, 0.0
	li.s $f27, 0.0
	li.s $f28, 0.0
	li.s $f29, 0.0

	mtc1 $t0, $f24 				# Copia cruda de x=r en el registro f24
	cvt.s.w $f25,$f24 			# f25 = X (en flotante) 

	mul.s $f26, $f22,$f25 		# $f26 = c*x

	mul.s $f27, $f25,$f25		# $f27 = x*x
	mul.s $f27,$f21,$f27		# $f27 = b*x*x

	mul.s $f28,	$f25, $f25		# $f28 = x*x
	mul.s $f28, $f28, $f25		# $f28 = x*x*x
	mul.s $f28, $f28, $f20		# $f28 = a*x*x*x

	add.s $f29, $f23, $f26		# f29 = d + c*x
	add.s $f29, $f29, $f27		# f29 = d + c*x + b*x*x
	add.s $f29, $f29, $f28		# f29 = d + c*x + b*x*x + a*x*x*x -> f(x)
	
	la	$a0,cadena1				# Imprime "f(" por pantalla
	li	$v0,4
	syscall 

	move $a0,$t0				# Imprime el valor X entero
	li $v0,1
	syscall		

	la $a0,cadena2				# Imprime ") = " por pantalla
	li $v0,4
	syscall	

	mov.s $f12,$f29				# f(x) = f29 en flotante
	li $v0,2					# Imprime el valor flotante = 2
	syscall

	la	$a0,salto_de_linea		# Imprime el salto de linea
	li	$v0,4
	syscall

	addi $t0,$t0,1				# x++ = Suma 1 a X=R
	ble $t0,$t1,for 			# Si X=R <= S , retorna al for 

# las siguientes dos instrucciones finalizan el programa
li $v0,10
syscall