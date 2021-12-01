
(a=b) 

beq $s0,$s1

(a<b) -> [blt $s0,$s1]

slt $t0,$s0,$s1
bne $t0,$zero,etiqueta

(a>b) -> [bgt $s0,$s1]

slt $t0,$s1,$s0
bne $t0,$zero,etiqueta

(a<=b) -> [ble $s0,$s1]

slt $t0,$s1,$s0
beq $t0,$zero,etiqueta

(a>=b) -> [bge $s0,$s1]

slt $t0,$s0,$s1
beq $t0,$zero,etiqueta

