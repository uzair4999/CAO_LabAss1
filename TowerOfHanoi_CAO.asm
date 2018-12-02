#UzairMarfani- CAO Assignment
#02-131172-022
 
.data
prompt: .asciiz "Enter number of disks to play Tower of Hanoi game: "
part1: .asciiz "\nMove disk "
part2: .asciiz " from rod "
part3: .asciiz " to rod "
 
.text
.globl main
main:
    li $v0,  4          # print string
    la $a0,  prompt
    syscall
    li $v0,  5          # read integer
    syscall
 
    # parameters for the routine
    add $a0, $v0, $zero # move to $a0
    li $a1, 'A' #source
    li $a3, 'B' #aux
    li $a2, 'C' #destination
 
    jal tower_of_hanoi           # call hanoi routine
 
    li $v0, 10          # exit
    syscall
 
tower_of_hanoi:
 
    #save in stack
    addi $sp, $sp, -20 
    sw   $ra, 0($sp)
    sw   $s0, 4($sp)
    sw   $s1, 8($sp)
    sw   $s2, 12($sp)
    sw   $s3, 16($sp)
 
    add $s0, $a0, $zero
    add $s1, $a1, $zero
    add $s2, $a2, $zero
    add $s3, $a3, $zero
 
    addi $t1, $zero, 1
    beq $s0, $t1, solution
 
    recursive1:
 
        addi $a0, $s0, -1
        add $a1, $s1, $zero
        add $a2, $s3, $zero
        add $a3, $s2, $zero
        jal tower_of_hanoi
 
        j solution
 
    recursive2:
 
        addi $a0, $s0, -1
        add $a1, $s3, $zero
        add $a2, $s2, $zero
        add $a3, $s1, $zero
        jal tower_of_hanoi
 
    exit_game:
 
        lw   $ra, 0($sp)        # restore registers from stack
        lw   $s0, 4($sp)
        lw   $s1, 8($sp)
        lw   $s2, 12($sp)
        lw   $s3, 16($sp)
 
        addi $sp, $sp, 20       # restore stack pointer
 
        jr $ra
 
    solution:
 
        li $v0,  4              # print string
        la $a0,  part1
        syscall
        li $v0,  1              # print integer
        add $a0, $s0, $zero
        syscall
        li $v0,  4              # print string
        la $a0,  part2
        syscall
        li $v0,  11             # print character
        add $a0, $s1, $zero
        syscall
        li $v0,  4              # print string
        la $a0,  part3
        syscall
        li $v0,  11             # print character
        add $a0, $s2, $zero
        syscall
 
        beq $s0, $t1, exit_game
        j recursive2
 
