.data 

        vector:      .space 20 
        cadena:      .asciiz "Escriba una cadena: "  
        cadenaes:   .asciiz "La cadena es: "

.text

main:

    la $a0,cadena    
    li $v0,4    
    syscall

    la $a0,vector    
    li $v0,8         #read string
    syscall

    li $a1,20 

    la $t0,vector  

    li $t1,4   
     
    lb $a0,0($t0) 
     loop:

        add $t0,$t0,$t1  # t0 = t0+4
        beq $a0,$zero, Exit  # a0 == 0 -> salta  
        
        la $a0, cadenaes      
        li $v0,8
        syscall
                
        la $a0, cadenaes      
        li $v0,4        
        syscall 

        j loop

    Exit:
    li $v0,10   
    syscall