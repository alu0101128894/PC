
# Practica 2. JOSE JAVIER DIAZ GONZALEZ

	.data		# directiva que indica la zona de datos
titulo: 		.asciiz			"Encuentra el numero de veces que aparece una cifra en un entero.\n"
msgcifra:		.asciiz			"Introduzca la cifra a buscar (numero de 0 a 9): "
msgnumero:		.asciiz			"Introduzca un entero positivo donde se realizara la busqueda: "
msgbusqueda1:	.asciiz			"Buscando cifra "
msgbusqueda2:	.asciiz			" en el numero "
msgresultado1:	.asciiz			" ...\nLa cifra buscada se encontro en "
msgresultado2:	.asciiz			" ocasiones\n"
	.text		# directiva que indica la zona de codigo

main:

# s0 = cifra
# s1 = numero
# t5 = 9 
# t6 = 0 		
# t7 = 10 
# t1 = s1 en temporal
# t3 = resto de la division

# cout << "Encuentra el numero de veces que aparece una cifra en un entero." << endl;

	la	$a0,titulo
	li	$v0,4 		# imprimir cadena
	syscall

#    do {
#        cout << "Introduzca la cifra a buscar (numero de 0 a 9): ";
#        cin >> cifra;
#    } while ((cifra < 0) || (cifra > 9));
# NOTA: $s0 cifra

do_while1: 
	la $a0,msgcifra
	li	$v0,4
	syscall

	li	$v0,5 		# leer entero
	syscall
	move $s0,$v0 	# guardo en salvado (s0 = cifra)
	
	blt $s0,$zero,do_while1 	# s0 < 0  
	li $t5,9 					# numero 9
    bgt $s0,$t5,do_while1 		# s0 > 9

#    do {
#        cout << "Introduzca un entero positivo donde se realizara la busqueda: ";
#        cin >> numero;
#    } while (numero < 0);
# NOTA: $s1 numero

do_while2:

	la $a0,msgnumero
	li	$v0,4  
	syscall

	li	$v0,5 
	syscall

	move $s1,$v0 			# guardo en salvado = (s1 = numero)

	blt $s1,$zero,do_while2 # s1 < 0

#  $s0 esta la cifra a buscar y en $s1 el numero en el que buscar la cifra
#  cout << "Buscando " << cifra << " en " << numero << " ... " << endl;

	la	$a0,msgbusqueda1
	li	$v0,4
	syscall

	move $a0,$s0 # valor s0 = cifra
	li	$v0,1 # imprimir entero
	syscall

	la	$a0,msgbusqueda2
	li	$v0,4
	syscall

	move $a0,$s1 # valor s1 = numero
	li	$v0,1
	syscall

# 	int encontrado = 0;
# 	do {
#     	int resto = numero % 10;
#     	if (resto == cifra) encontrado++;
#     	numero = numero / 10;
# 	} while (numero != 0);

	li $t6,0 			# encontrado = 0
	li $t7,10  			# guardo un 10
	move $t1,$s1 		# paso de salvado a temporal = s1 lo paso a t1

do:
	div $t1,$t7 		# numero % 10 
	mfhi $t3			# resto de la division -> int resto = numero % 10
	beq $t3,$s0,true  	# si el resto = cifra (salta a true) -> encontrado ++
	b while 			# salta a la etiqueta salta

	true:
		addi $t6,1 	# encontrado++

	while: 
		mflo $t1 				# guardamos el resultado de la division
		beq $t1,$zero,final 	# resultado division == 0 salto a final
		j do 					# salto a do, no cumple

final:
	move $s2,$t6 #contador resultado (t6)

#$s2 tenemos el contador de econtrados
	la	$a0,msgresultado1
	li	$v0,4
	syscall

	move $a0,$s2
	li	$v0,1
	syscall

	la	$a0,msgresultado2
	li	$v0,4
	syscall

	# las siguientes dos instrucciones finalizan el programa
	li $v0,10
	syscall
 
