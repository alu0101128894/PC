.data
      cout1: .asciiz "\nIntroduzca un numero entero: "
      cout2: .asciiz "\nEl numero entero es: "
.text

main:

      addi $sp,-24
      sw $ra,16($sp)

      li $v0,4
      la $a0,cout1
      syscall

      li $v0,5
      syscall

      move $t0,$v0
      move $a0,$t0

    jal factorial

    move $t1,$v0

    li $v0,4
    la $a0,cout2
    syscall

    li $v0,1
    move $a0,$t1
    syscall

    li $v0,10
    syscall

factorial:

      addi $sp,-24
      sw $ra,16($sp)
      sw $a0,24($sp)

casobase:

      bgt $a0,$zero,casonobase
      li $v0,1
      j pop

casonobase:

      addi $a0,$a0,-1
      jal factorial
      lw $a0,24($sp)
      mult $a0,$v0
      mflo $v0

pop:

      lw $ra,16($sp)
      addi $sp,24
      jr $ra
