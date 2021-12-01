    .data
entero: .asciiz "Introduzca un entero: "
suma: .asciiz "La suma es: "
    .text

main:
    li $t3,0

    la $a0,entero
    li $v0,4
    syscall

    li $v0,5
    syscall
    move $t0,$v0

    la $a0,entero
    li $v0,4
    syscall

    li $v0,5
    syscall
    move $t1,$v0

    add $t3,$t0,$t1
    
    la $a0,suma
    li $v0,4
    syscall

    li $v0,1
    move $a0,$t3
    syscall

    li $v0,10
    syscall
