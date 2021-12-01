# PRACTICA 4. PRINCIPIO DE COMPUTADORES.

m = 4		# numero de filas de m1
n = 5	# numero de columnas de  m1
size = 4	# tamano de cada elemento


# HAY QUE PONER UN ESPACIO DETRAS DE CADA COMA EN LA DEF DE VECTORES Y MATRICES
			.data
      
m1:	    .word	1, 2, 3, 4, 5
		    .word	6, 7, 8, 9, 0
		    .word	0, 2, 4, 6, 8
	  	  .word	1, 3, 5, 7, 9


text1:       .asciiz "Practica 4 de Principio de Computadores\n"
text2:       .asciiz "Matriz traspuesta: "
salto_linea: .asciiz "\n"


			.text
main:

    #  for (int i=0; i<n; i++)
    #   for (int k=0; k<i; k++)
    #     cout<<" ";
    #   cout<<matriz[j][i]<<endl;
    # (n*i+j)*size

    
# $s0: size
# $s1: filas (m)
# $s2: columnas(n)

#----BLOQUE ENTRADA DE DATOS---
  la $a0, text1              
  li $v0, 4                   
  syscall                     

  la $a0, text2               
  li $v0, 4                   
  syscall   

  la $a0,salto_linea                     
  li $v0, 4
  syscall                 

  la $t1, m1          
  li $s1, m                  
  li $s2, n 
  li $s0,size
#--- FIN BLOQUE ENTRADA DE DATOS ---

  li $t8, 0                   
  li $t9, 0                   
  li $t4, 1                   
  mul $t6, $s0, $s2    #t6 = size * n      # calculo el desplazamiento para el primer bucle
  la $t7, m1   #cargas la direccion de m1
  
  salto:                      

  lb $a0, 0($t7)              
  li $v0, 1                   
  syscall   
                         
  add $t7, $t7, $t6  #t7 = m1 + size*n
  addi $t8, $t8, 1 #t8 = i++

  blt $t8, $s1, salto  
         
  la $a0,salto_linea                     
  li $v0, 4
  syscall  

  la $t7, m1          
  li $t8, 0  
  mul $t5, $t4, $s0           
  add $t7, $t7, $t5           
  addi $t9, $t9, 1            
  addi $t4, $t4, 1            
  blt $t9, $s2, salto  
   

  li $v0,10
  syscall
      
