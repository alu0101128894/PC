#Practica 4. Principio de computadoras - Jose Javier Diaz Gonzalez

# Programa que imprime la Traspuesta de la mariz
# La matriz tiene dimension mxn

m = 4		# numero de filas de m1
n = 5		# numero de columnas de  m1
size = 4	# tamano de cada elemento

#CUANDO QUIERES HACER LA TRASPUESTA HAY QUE PONER UNA COMA EN LA TRASPUESTA
			.data
m1:			.word	1, 2, 3, 4, 5
			.word	6, 7, 8, 9, 0
			.word	0, 2, 4, 6, 8
			.word	1, 3, 5, 7, 9

traspuesta:		 .asciiz "La traspuesta de m es: \n\n"
espaciado:	     .asciiz "  "         # espacios a cada posicion
salto:		     .asciiz "\n"
sin_espacios:    .asciiz ""
			.text

#PSEUDOCODIGO

#       for(j = 0;j < n; j++){
#        cout<<"\n";
#	      for(i =0;i < m; i++){
#	          cout<< "m1 -> (i,j)" <<" "<<endl;

# FIN DEL PSEUDOCODIGO	

main:
    #Las siguientes lineas sirven para imprimir una cadena por la consola
    li $v0, 4 # el registro $v0 debe tener el valor 4 para imprimir cadenas
    la $a0, traspuesta # el registro $a0 debe tener la direccion de la cadena a imprimir "traspuesta"
    syscall

    la $s1,m1             
    move $t2,$zero        # Copia (muevo) el contenido del registro $t2  al registro $zero ( j=0 )
    li $t3,size		      #llamamos t3 = size
    li $t4,n			  #llamamos t4 = n
    mul $t5,$t3,$t4		  #llamamos t5 = (n * tamano)
		
for1:
    move $t1,$zero		  # Copia (muevo) el contenido del registro $t1  al registro $zero ( i=0 )
    li $v0, 4	#Imprimimos la cadena de "sin_espacios"
    la $a0, sin_espacios	
    syscall		          # Entramos en el borde derecho de la matriz
    li $v0, 4	#Imprimimos la cadena de "espaciado"
    la $a0, espaciado	
    syscall		

for2:
    mul $t6,$t5,$t1		  #t6 = t5 * i  calculo el desplazamineto, si quiero calcular la suma lo hago por fuera
    addu $t6,$t6,$s1	  #t6 = t6 en m1 -> ($s1)
    lw $t6,0($t6)		  #t6 = t6 (i,j)

    move $a0,$t6		  # Imprimimos t6 en (i,j)
    li $v0,1
    syscall
	
    li $v0, 4	#Imprimimos la cadena de "espaciado"
    la $a0, espaciado     # Agregamos un espaciado entre cada numero
    syscall		

    addi $t1,$t1,1		  #i++
    blt $t1,m,for2	      # si $t1 < m entonces salta a for2 ; t1 -> i [i < m ]

    li $v0, 4    #Imprimimos la cadena de "sin_espacios"
    la $a0, sin_espacios	
    syscall		          # Entramos en el borde izquierdo de la matriz
    
    li $v0, 4	# Agregamos un salto entre cada numero	
    la $a0, salto    
    syscall		

    addi $t2,$t2,1		  #j++
    add $s1,$s1,size      # $s1 = &s1 + size -> (4)
    blt $t2,n,for1	      # si $t2 < n entonces salta a for2 ; t1 -> i [i < n ]
		
    # las siguientes dos instrucciones finalizan el programa   
    li	$v0,10
    syscall
			
