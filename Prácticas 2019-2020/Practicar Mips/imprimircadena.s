.data 

        vector:      .space 20 
        cadena:      .asciiz "Escriba una cadena: "  
        cadenaes:   .asciiz "La cadena es: "

.text

main:

    la $a0,cadena    
    li $v0,4    
    syscall

    li $a1,20 # pasas en $a1 el tamano maximo de la cadena
    la $a0,vector    
    li $v0,8         #read string
    syscall
    # aqui ya tendrias la cadena metida en vector, con el \n al final

    # la puedes mostrar por pantalla para verla
    la $a0,vector
    li $v0,4
    syscall


    # li $a1,20 tiene que ir antes de hacer la llamada al sistema 

    # li $t1,4   # los caracteres van de byte en byte, entonce basta con sumar 1
     
    # ya tienes tu cadena de texto en vector, y lo que te hace falta es cambiar el \n del final por \0
    # Te guardas el tamano de la cadena en un registro (este lo puedes sacar con strlen) o con esta parte de codigo que ya tenias

    la $t0,vector # cargas la direccion del primer elemento en $t0

    # lb $a0,0($t0) 
    # guarda un cero en $t1, por ejemplo
    move $t1,$zero
    loop:
        lb $a0,0($t0) # cargas un caracter para compararlo luego
        # add $t0,$t0,$t1  # t0 = t0+4
        addi $t1,1 # sumas 1 a la cantidad de caracteres. Como empezaste en 0, ponerlo aqui va bien
        beq $a0,$zero, Exit  # a0 == 0 -> salta  
        
        # Si es diferente de cero, te mueves una posicion
        addi $t0,1
        # haces el bucle otra vez
        j loop
        #la $a0, cadenaes      
        #li $v0,8
        #syscall
                
        #la $a0, cadenaes      
        #li $v0,4        
        #syscall 

        #j loop
        
    # cuando terminas el bucle, tienes en $t1 la cantidad de caracteres de la cadena
    # si le restas 1, tienes la cantidad de bytes que te tienes que desplazar hasta el final
    addi $t1,-1
   
    # te pones en la posicion correspondiente y le cargas un 0
    la $t0,vector
    add $t0,$t0,$t1
    sb $zero,0($t0)

    # ahora ya denerias tener tu cadena sin el \n
    la $a0,cadenaes
    li $v0,4
    syscall

    la $a0,vector
    syscall


    Exit:
    li $v0,10   
    syscall