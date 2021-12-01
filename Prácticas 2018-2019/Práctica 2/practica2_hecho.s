#PRACTICA 2: Factorial del numero, etiqueta num y almacenar el resultadoetiqueta result

	.data 
num:	.word 5
result:	.word 0	

	.text

main:

    # if (num >= 0) {
    #     result = 1;
    #     while (num > 0) {
    #       result *= num;
    #       num--
    #     }
    # }

    lw $t0, num
	bge $t0,$zero,if           
	b else
	if:  
        li $t1,1               
	    bgt $t0,$zero,while
	    while: 
            beq $t0, 1, else
	        mul $t1,$t1,$t0         
	        addi $t0,$t0,-1
	        jal while
            b else
    else:    
    sw $t1,result
	li $v0,10
    syscall