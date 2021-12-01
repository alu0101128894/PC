
#Polinomio Hermite - Iterativa

			.data

titulo:	                .asciiz "Practica 5. PRINCIPIOS DE COMPUTADORES (Practica en Parejas).\n"
hermite:                .asciiz "Polinomio de Hermite (Iterativa).\n" 
pedirorden:             .asciiz "Introduzca el orden del polinomio: "
pedirpunto:             .asciiz "Introduzca el punto donde calcular el polinomio: "
orden_negativa:         .asciiz "Tiene orden negativa."
resultado_general:      .asciiz "El resultado de Hermite es: "
salto:                  .asciiz "\n"

			.text

#double hermite( int n, double x){
#   float H, H1, H2;
#   H2 = 1;             //H2 = Hermite(n-2)
#   H1 = 2 * x;         //H1 = Hermite(n-1)
#   if(n == 0) return H2;
#   if(n == 1) return H1;
#   else{
#     int i = 2;
#     do{
#       H = 2 * x * H1 - 2 * H2 * (i-1);
#       H2 = H1;
#       H1 = H;
#       i++;
#     } while (i <= n);
#   return (H);
#}

main:
    li $v0, 4 
    la $a0, titulo 
    syscall
    
    li $v0, 4 
    la $a0,hermite  #imprimir hermite
    syscall
    
    la $a0,salto#imprime el salto de linea
    li $v0,4
    syscall
    
    li $v0,4
    la $a0,pedirorden
    syscall

    li $v0,5
    syscall 			#Orden

    move $t2,$v0		#Orden

    la $a0,salto
    li $v0,4
    syscall
	
	li.d $f12,1.0  	 	# Hermite
	blt $t2,$zero,error          #Si orden es negativo salta a error
    beq $t2,$zero,resultado 	 #¿Orden = 0?
    la $a0,pedirpunto
    li $v0,4
    syscall

    li $v0,7   			 #Punto
    syscall
	
    li $t0,2            	 # Contador
    li.d $f2,1.0        	 # Hermite (n - 2)
    li.d $f10,2.0		     # 2
    mul.d $f4,$f2,$f0    	 # Hermite (n - 2) * x
    mul.d $f4,$f0,$f10       # Hermite (n-1) = 2*(x * Hermite(n-1))
	bne $t2,1,herm_operacion		     #¿Orden = 1?
    mov.d $f12,$f4
    j resultado
    

herm_operacion:
    	
    mul.d $f12,$f4,$f0 		    #Hermite = Hermite(n-1)*x
	mul.d $f12,$f12,$f10 		#Hermite = 2*(Hermite(n-1)*x)
	sub $t1,$t0,1     		    #contador-1
	mtc1 $t1,$f6
	cvt.d.w $f6,$f6 		    #Cambio el contador-1 a double para que pueda hacer operaciones con otros double
	mul.d $f8,$f2,$f6 		    #Guardo el substraendo en una variable distinta = Hermite(n-2)*(contador-1)
	mul.d $f8,$f8,$f10 		    #substraendo = 2*(Hermite(n-2)*(i-1))
	sub.d $f12,$f12,$f8 		#Hermite = Hermite - substraendo (2*x*Hermite(n-1))-(2*Hermite(n-2)*(i-1))
	mov.d $f2,$f4       		#Hermite (n-2)= Hermite(n-1)
	mov.d $f4,$f12     		    #Hermite (n-1)= Hermite
	addi $t0,$t0,1
	blt $t2,$t0,resultado		#Contador menor que orden
	b herm_operacion

error:
	li $v0, 4
        la $a0,orden_negativa
        syscall
        j fin
        
resultado:
        li $v0, 4
        la $a0,resultado_general
        syscall
        li $v0, 3
        syscall
        
fin:
        li	$v0,10
        syscall

	
	

        
