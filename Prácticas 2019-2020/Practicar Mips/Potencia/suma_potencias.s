N=4
size=4
	.data
vector:	.float 3.0, 2.0, 1.0, 1.0
	.text

potencia: # $f12 flotante en simple precision que es la base de la potencia
		  # $a0  entero positivo, al cual quiero elevar la base
		  # devuelve en $f0 $f12 elevado a $a0, es decir $f0 = ($f12)^$a0
		  
		  # si b es la base, y p es la potencia:
		  # float b; int p;
		  # resultado = 1.0
		  # for ( i = 0 ; i < p ; i++)
		  #     resultado = resultado * b;
		  # $t1 es i
		  # $f0 es resultado
		  
		  li.s $f0,1.0
		  li $t1,0
		  for_potencia: bge $t1,$a0,finforpotencia	
		  	mul.s $f0,$f0,$f12
		  	addi $t1,1
			j for_potencia
		  finforpotencia:
			  jr $ra
			  
suma_de_potencias:   # $a0 direccion de memoria de un vector de flotantes simple precision
					 # $a1 numero de lementos del vector
					 # $f0 = v[0]^0+v[1]^1+..........v[N]^N
					 
					 addi $sp,-16
					 sw $ra,0($sp)
					 
					 li $t0,0
					 move $t1,$a0
					 li.s $f16,0.0
					 bucle_sumapot:
						 l.s $f12,0($t1)
						 move $a0,$t0
						 # como voy a llamar a la funcion potencia, y no tengo por que
						 # saber qué registros temporales usa la funcion potencia
						 # por precaucion los guardo en la pila y los vuelvo a recuperar
						 # antes de volver a usarlos
						 sw $t0,4($sp)
						 sw $t1,8($sp)
						 s.s $f16,12($sp)
						 
						 jal potencia  # devuelve en $f0 = $f12 ^$a0
						 
						 # como no se si potencia ha modificado mis registros temporales
						 # los recupero de como los tenia, antes de ejecutar la funcion
						 #potencia						 
						 lw $t0,4($sp)
						 lw $t1,8($sp)
						 l.s $f16,12($sp)
						 
						 add.s $f16,$f16,$f0
						 addi $t1,size						 
						 addi $t0,1
						 blt $t0,$a1,bucle_sumapot
					 mov.s $f0,$f16
					 
					 lw $ra,0($sp)
					 addi $sp,16
					 jr $ra
					 

main:
	
	la $a0,vector
	li $a1,N
	jal suma_de_potencias
	
	# cuando regrese en $f0 debo tener el resultado
	li $v0,2
	mov.s $f12,$f0
	syscall
	
	li $v0,10
	syscall


	