        .data
x:       .word 6
y:       .word 5
min:     .word 0
    .text

main:

    lw $a0,x
    lw $a1,y
    jal minimo

    sw $v0,min
    
    li $v0,10
    syscall

    minimo:
        move $v0,$a0
        bgt $a0,$a1,minimo2
        jr $ra
        minimo2:
            move $v0,$a1
            jr $ra