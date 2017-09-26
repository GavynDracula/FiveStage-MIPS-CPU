addi $a0, $zero, 0x8
addi $t0, $zero, 0x8
addi $s0, $zero, 0x4
addi $s1, $zero, 0x6
addi $v0, $zero, 0x1
syscall

loop1:
sllv $a0, $a0, $s0
add $a0, $a0, $t0
syscall
addi $s1, $s1, -1
bgez $s1, loop1

add $s2, $zero, $a0
sw $a0, ($v0)
lh $a0, ($v0)
syscall
add $a0, $zero, $s2
addi $s1, $zero, 0x7
syscall

loop2:
srlv $a0, $a0, $s0
syscall
addi $s1, $s1, -1
bgez $s1, loop2

addi $v0, $zero, 0xa
syscall
