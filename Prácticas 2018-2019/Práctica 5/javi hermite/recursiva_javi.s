#Practica 5. Principio de computadoras - Jose Javier Diaz Gonzalez - Daniel Barroso Rocio (Practica pareja)

#Polinomio Hermite - Recursiva

            .data
titulo:	                .asciiz "Practica 5. PRINCIPIOS DE COMPUTADORES (Practica en Parejas).\n"
hermite:                .asciiz "Polinomio de Hermite (Recursiva).\n"           
orden:                  .asciiz "Introduzca el orden del polinomio: "
punto:                  .asciiz "Introduzca el punto donde calcular el polinomio: "
orden_negativa:         .asciiz "Tiene orden negativa."
resultado_general:      .asciiz "El resultado del polinomio es: "
resultado_cero:         .asciiz "El resultado del polinomio es: 1"
salto_de_linea:         .asciiz "\n"

            .text


#double hermite( int n, double x){
#   if(n==0) return 1;
#   if(n==1) return 2*x;
#   return 2 * x * hermite(n-1,x) -2 * (n-1) * hermite(n-2,x);
#}

main:

    li $v0, 4 
    la $a0, titulo 
    syscall
    
    li $v0, 4 
    la $a0,hermite  #imprimir hermite
    syscall
      
    li $v0,4
	la $a0,salto_de_linea #imprime el salto de linea
    syscall

    li $v0,4
	la $a0,orden #imprimir orden (es entero)
    syscall
   
    li $v0,5 #entero que se lee
    syscall

    move $t2,$v0 #mueve el registro t2 al registro v0 (entero)
    blt $t2,$zero,negativa #si t2 < que 0 , salta a la etiqueta "negativa"
    beq $t2,$zero,cero # si t2 = que 0 salta a la etiqueta "cero"

    li $v0,4
	la $a0,salto_de_linea #salto de linea
    syscall
	
	li $v0,4
    la $a0,punto #imprimir punto (es flotante)
    syscall

    li $v0,6 #flotante que se lee
    syscall
    #PEDIR VALORES
    
    move $a0,$t2            #entero: a0 = t2 (orden)
    mov.s $f12,$f0          #flotante: f12 = f0 (punto)

    #simple precision y doble precision siempre operar con flotante
    
    li.s $f1,2.0      #f1 = 2 -> flotante (para operar)      
    li.s $f10,1.0      #f10 = 1 -> flotante (para operar)   

jal recursiva #llamar a la subrutina "recursiva"
    mov.s $f0,$f7 #f0 = f7

    li $v0,4
	la,$a0,resultado_general #imprime el resultado_general
    syscall

    mov.s $f12,$f0 # f12 para imprimir (se termina aqui)
    li $v0,2
    syscall
	j final
	
negativa:
    li $v0,4                #registro para imprimir
	la $a0,orden_negativa   #imprime cuando la orden es negativa
    syscall                 #llamar el sistema por consola
    j final                 #salta a la etiqueta "final" y termina

cero:
	li $v0,4                 #imprime la cadena de "cero"
    la $a0,resultado_cero    #imprime cuando es 0
    syscall                  #llamar el sistema por consola

final:  #se termina (final programa)
    li $v0,10
    syscall
	
#OPERACION RECURSIVIDAD  - FORUMULA HERMITE

recursiva:  #etiqueta recursiva

    addi $sp, -16  #para hacer huecos en la pila, multiplos de 8
    sw $ra,8($sp) #save word y luego cargas
    sw $a0,16($sp) #save word

    H0: #cuando HERMITE N-2 = 1
    
        bne $a0,$zero,H1    #si a0 > 0 se va la etiqueta H1
        li.s $f2,1.0        #f2 = 1
        j pop_pila          #salta a la etiqueta "pop_pila"

    H1: #cuando HERMITE N-1 = 2*x
    
        bne $a0,1,general    #si a0 > t3 salta al caso "general"
        mul.s $f3,$f1,$f12     #f3 = f1 * f12 -> 2 * x
        sub $a0,$a0,1        #a0 = a0 - 1, (n-1),  para llegar al caso base
        b H0 #salto a la etiqueta anterior "H0"

    general: #caso general (toda la formula)
    
        sub $a0,$a0,1        #Introduce 1 mas para asi llegar al maximo, a0 - 1 para llegar al caso base
        jal recursiva #una funcion que se llama asi misma, la subrutina
        lw $a0,16($sp)          #Carga en a0 el 24 del puntero de pila

        #Primera operacion
        mul.s $f4,$f1,$f12       # f4 = 2*x (x = punto)
        mul.s $f4,$f4,$f3       # f4 = (2*x)* HERMITE N-1 -> (2*x) = 4x2
        
        #Segunda operacion
        mtc1 $a0,$f6            # a0 = f6, copia cruda : n -> f6
        cvt.s.w $f6,$f6         # f6 = f6,esta en un entero y lo almacena en un flotante (simple precision)

        sub.s $f6,$f6,$f10       #f6 = f6 - 1 -> n-1
        mul.s $f5,$f1,$f2       #f5 = f1 * f2 -> 2 * HERMITE N-2
        mul.s $f5,$f5,$f6       #f5 = f5 * f6 -> 2 *(n-1)* HERMITE N-2
        
        #Resultado
        sub.s $f7,$f4,$f5       #f7 = [(2*x) * Hn-1] - [2 * (n-1) * Hn-2]

        mov.s $f2,$f3           #HERMITE N-2 = HERMITE N-1
        mov.s $f3,$f7           #HERMITE N-1 = HERMITE (resultado)

    pop_pila:  #bajar en la pila                      
        lw $ra,8($sp)  #load word, y vuelves al punto donde lo has guardado
        addi $sp,16
        jr $ra


