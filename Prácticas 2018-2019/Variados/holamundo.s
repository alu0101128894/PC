        .data

texto: .asciiz "Hola mundo"
text1:  .word 5
        .text

main: 

li $v0,4
la $a0,texto
syscall

lw $t0,text1

li $v0, 5
la $a0, text1
syscall
move $a0,$t0
li $v0, 1
syscall


li $v0,10
syscall