j init
# entrance of interrupt handler
j int0
j int1
j int2
j int3

int0:
# protect necessary register
addiu $sp, $sp, -1
sw $a0, ($sp)
addiu $sp, $sp, -1
sw $v0, ($sp)
addiu $sp, $sp, -1
sw $s0, ($sp)
addiu $sp, $sp, -1
sw $s1, ($sp)
addiu $sp, $sp, -1
mfc0 $s1, $8
sw $s1, ($sp)
addiu $sp, $sp, -1
mfc0 $s1, $9
sw $s1, ($sp)
# set new inm and enable interrupt
addi $s0, $zero, 2
mtc0 $s0, $8
mfc0 $s0, $8
ori $s0, $s0, 1
mtc0 $s0, $8
# clear, then display "f","ff","fff","ffff","fffff","ffffff","fffffff","ffffffff"
addi $v0, $zero, 1
addi $a0, $zero, 0
syscall
addi $s0, $zero, 0xf
addi $a0, $zero, 0xf
syscall
addi $s1, $zero, 7
int0_loop:
sll $s0, $s0, 4
add $a0, $s0, $a0
syscall
addi $s1, $s1, -1
bne $s1, $zero, int0_loop
# disenable interrupte
addi $s0, $zero, 2
mtc0 $s0, $8
# restore register
lw $s1, ($sp)
mtc0 $s1, $9
addiu $sp, $sp, 1
lw $s1, ($sp)
srl $s1, $s1, 1
sll $s1, $s1, 1
mtc0 $s1, $8
addiu $sp, $sp, 1
lw $s1, ($sp)
addiu $sp, $sp, 1
lw $s0, ($sp)
addiu $sp, $sp, 1
lw $v0, ($sp)
addiu $sp, $sp, 1
lw $a0, ($sp)
addiu $sp, $sp, 1
# enable interrupt and return
eret

int1:
# protect necessary register
addiu $sp, $sp, -1
sw $a0, ($sp)
addiu $sp, $sp, -1
sw $v0, ($sp)
addiu $sp, $sp, -1
sw $s0, ($sp)
addiu $sp, $sp, -1
sw $s1, ($sp)
addiu $sp, $sp, -1
mfc0 $s1, $8
sw $s1, ($sp)
addiu $sp, $sp, -1
mfc0 $s1, $9
sw $s1, ($sp)
# set new inm and enable interrupt
addi $s0, $zero, 6
mtc0 $s0, $8
mfc0 $s0, $8
ori $s0, $s0, 1
mtc0 $s0, $8
# clear, then display "f","ff","fff","ffff","fffff","ffffff","fffffff","ffffffff"
addi $v0, $zero, 1
addi $a0, $zero, 0
syscall
addi $s0, $zero, 0x1
addi $a0, $zero, 0x1
syscall
addi $s1, $zero, 7
int1_loop:
sll $s0, $s0, 4
add $a0, $s0, $a0
syscall
addi $s1, $s1, -1
bne $s1, $zero, int1_loop
# disenable interrupte
addi $s0, $zero, 6
mtc0 $s0, $8
# restore register
lw $s1, ($sp)
mtc0 $s1, $9
addiu $sp, $sp, 1
lw $s1, ($sp)
srl $s1, $s1, 1
sll $s1, $s1, 1
mtc0 $s1, $8
addiu $sp, $sp, 1
lw $s1, ($sp)
addiu $sp, $sp, 1
lw $s0, ($sp)
addiu $sp, $sp, 1
lw $v0, ($sp)
addiu $sp, $sp, 1
lw $a0, ($sp)
addiu $sp, $sp, 1
# enable interrupt and return
eret

int2:
# protect necessary register
addiu $sp, $sp, -1
sw $a0, ($sp)
addiu $sp, $sp, -1
sw $v0, ($sp)
addiu $sp, $sp, -1
sw $s0, ($sp)
addiu $sp, $sp, -1
sw $s1, ($sp)
addiu $sp, $sp, -1
mfc0 $s1, $8
sw $s1, ($sp)
addiu $sp, $sp, -1
mfc0 $s1, $9
sw $s1, ($sp)
# set new inm and enable interrupt
addi $s0, $zero, 14
mtc0 $s0, $8
mfc0 $s0, $8
ori $s0, $s0, 1
mtc0 $s0, $8
# clear, then display "f","ff","fff","ffff","fffff","ffffff","fffffff","ffffffff"
addi $v0, $zero, 1
addi $a0, $zero, 0
syscall
addi $s0, $zero, 0x2
addi $a0, $zero, 0x2
syscall
addi $s1, $zero, 7
int2_loop:
sll $s0, $s0, 4
add $a0, $s0, $a0
syscall
addi $s1, $s1, -1
bne $s1, $zero, int2_loop
# disenable interrupte
addi $s0, $zero, 14
mtc0 $s0, $8
# restore register
lw $s1, ($sp)
mtc0 $s1, $9
addiu $sp, $sp, 1
lw $s1, ($sp)
srl $s1, $s1, 1
sll $s1, $s1, 1
mtc0 $s1, $8
addiu $sp, $sp, 1
lw $s1, ($sp)
addiu $sp, $sp, 1
lw $s0, ($sp)
addiu $sp, $sp, 1
lw $v0, ($sp)
addiu $sp, $sp, 1
lw $a0, ($sp)
addiu $sp, $sp, 1
# enable interrupt and return
eret

int3:
# protect necessary register
addiu $sp, $sp, -1
sw $a0, ($sp)
addiu $sp, $sp, -1
sw $v0, ($sp)
addiu $sp, $sp, -1
sw $s0, ($sp)
addiu $sp, $sp, -1
sw $s1, ($sp)
addiu $sp, $sp, -1
mfc0 $s1, $8
sw $s1, ($sp)
addiu $sp, $sp, -1
mfc0 $s1, $9
sw $s1, ($sp)
# set new inm and enable interrupt
addi $s0, $zero, 30
mtc0 $s0, $8
mfc0 $s0, $8
ori $s0, $s0, 1
mtc0 $s0, $8
# clear, then display "f","ff","fff","ffff","fffff","ffffff","fffffff","ffffffff"
addi $v0, $zero, 1
addi $a0, $zero, 0
syscall
addi $s0, $zero, 0x3
addi $a0, $zero, 0x3
syscall
addi $s1, $zero, 7
int3_loop:
sll $s0, $s0, 4
add $a0, $s0, $a0
syscall
addi $s1, $s1, -1
bne $s1, $zero, int3_loop
# disenable interrupte
addi $s0, $zero, 30
mtc0 $s0, $8
# restore register
lw $s1, ($sp)
mtc0 $s1, $9
addiu $sp, $sp, 1
lw $s1, ($sp)
srl $s1, $s1, 1
sll $s1, $s1, 1
mtc0 $s1, $8
addiu $sp, $sp, 1
lw $s1, ($sp)
addiu $sp, $sp, 1
lw $s0, ($sp)
addiu $sp, $sp, 1
lw $v0, ($sp)
addiu $sp, $sp, 1
lw $a0, ($sp)
addiu $sp, $sp, 1
# enable interrupt and return
eret

init:
addi $sp, $zero, 1023
addi $s1, $zero, 4
sw $s1, ($sp)
addi $s1, $zero, 3
addi $sp, $sp, -1
sw $s1, ($sp)
addi $s1, $zero, 2
addi $sp, $sp, -1
sw $s1, ($sp)
addi $s1, $zero, 1
addi $sp, $sp, -1
sw $s1, ($sp)
addi $s1, $zero, 1
mtc0 $s1, $8
j main

main:
#############################################################
#����j,jal,jrָ�����Ҫ�ɷֿ����ԣ�ִ������Ӧ����15������ revise date 2015/12/17 tiger
#############################################################
.text
 addi $s1,$zero, 1   #����j,jal,jrָ�����Ҫ�ɷֿ����ԣ�ִ������Ӧ����15������
 j jmp_next1
 addi $s1,$zero, 1
 addi $s2,$zero, 2
 addi $s3,$zero, 3
jmp_next1:
 j jmp_next2
 addi $s1,$zero, 1
 addi $s2,$zero, 2
 addi $s3,$zero, 3
jmp_next2:
 j jmp_next3
 addi $s1,$zero, 1
 addi $s2,$zero, 2
 addi $s3,$zero, 3
jmp_next3:
 j jmp_next4
 addi $s1,$zero, 1
 addi $s2,$zero, 2
 addi $s3,$zero, 3
jmp_next4:jal jmp_count

######################################


#��λ����  ��Ҫ֧�ֳ�addi,sll,add,syscall,srl,sll,sra,beq,j,syscall    revise date:2015/12/16 tiger

.text
addi $s0,$zero,1     #����λ��ѭ�����ԣ�0��������ʾ���ǳ�ʼֵ1����1λ�ظ�15�ε�ֵ��1���������ۼ�ֵ
addi $s1,$zero,1  
sll $s1, $s1, 31   #�߼�����31λ $s1=0x80000000
 

###################################################################
#                �߼����Ʋ��� 
# ��ʾ����������ʾ0x80000000 0x20000000 0x08000000 0x02000000 0x00800000 0x00200000 0x00080000 0x00020000 0x00008000 0x00002000 0x00000800 0x00000200 0x00000080 0x00000020 0x00000008 0x00000002 0x00000000  
###################################################################
LogicalRightShift:            #�߼����Ʋ��ԣ�������?1��λ��������ֱ�����Ϊ��?

add    $a0,$0,$s1       #display $s1    #�߼����Ʋ��ԣ�������?1��λ��������ֱ�����Ϊ��?
addi   $v0,$0,34        # display hex
syscall                 # we are out of here.  
     
srl $s1, $s1, 2   
beq $s1, $zero, shift_next1
j LogicalRightShift

shift_next1:

add    $a0,$0,$s1       #display $s1
addi   $v0,$0,34         # display hex
syscall                 # we are out of here.  


###################################################################
#                �߼����Ʋ��� 
# ��ʾ����������ʾ0x00000004 0x00000010 0x00000040 0x00000100 0x00000400 0x00001000 0x00004000 0x00010000 0x00040000 0x00100000 0x00400000 0x01000000 0x04000000 0x10000000 0x40000000 0x00000000 
###################################################################

addi $s1,$zero, 1        #                �߼����Ʋ��� 
LogicalLeftShift:         #�߼����Ʋ��ԣ�������?1��λ������ֱ�����Ϊ��?
sll $s1, $s1, 2  

add    $a0,$0,$s1       #display $s1
addi   $v0,$0,34         # display hex
syscall                 # we are out of here.  
      
beq $s1, $zero, ArithRightShift
j LogicalLeftShift


###################################################################
#                �������Ʋ��� 
# ��ʾ����������ʾ0x80000000 0xf0000000 0xff000000 0xfff00000 0xffff0000 0xfffff000 0xffffff00 0xfffffff0 0xffffffff 
###################################################################
ArithRightShift:          #�������Ʋ��ԣ�#������λ���ԣ�80000000�������ƣ�������ʾΪF0000000,FF000000,FFF00000,FFFF0000ֱ��FFFFFFFF

addi $s1,$zero,1     #                �������Ʋ��� 
sll $s1, $s1, 31   #�߼�����31λ $s1=0x80000000

add    $a0,$0,$s1       #display $s1
addi   $v0,$0,34         # display hex
syscall                 # we are out of here.  

sra $s1, $s1, 3    #$s1=0X80000000-->0XF0000000

add    $a0,$0,$s1       #display $s1
addi   $v0,$0,34         # display hex
syscall                 # we are out of here.  


sra $s1, $s1, 4    #0XF0000000-->0XFF000000

add    $a0,$0,$s1       #display $s1
addi   $v0,$0,34         # display hex
syscall                 # we are out of here.  


sra $s1, $s1, 4    #0XFF000000-->0XFFF00000

add    $a0,$0,$s1       #display $s1
addi   $v0,$0,34         # display hex
syscall                 # we are out of here.  

sra $s1, $s1, 4    

add    $a0,$0,$s1       #display $s1
addi   $v0,$0,34         # display hex
syscall                 # we are out of here.  

sra $s1, $s1, 4    

add    $a0,$0,$s1       #display $s1
addi   $v0,$0,34         # display hex
syscall                 # we are out of here.  


sra $s1, $s1, 4    

add    $a0,$0,$s1       #display $s1
addi   $v0,$0,34         # display hex
syscall                 # we are out of here.  


sra $s1, $s1, 4    

add    $a0,$0,$s1       #display $s1
addi   $v0,$0,34         # display hex
syscall                 # we are out of here.  


sra $s1, $s1, 4    


add    $a0,$0,$s1       #display $s1
addi   $v0,$0,34         # display hex
syscall                 # we are out of here.  

#############################################################
#����Ʋ���?,����addi,andi,sll,srl,sra,or,ori,nor,syscall  LED������Ʒ�ʽ������ʾ����?
#############################################################

.text
addi $s0,$zero,1 
sll $s3, $s0, 31      # $s3=0x80000000
sra $s3, $s3, 31      # $s3=0xFFFFFFFF   
addu $s0,$zero,$zero   # $s0=0         
addi $s2,$zero,12 

addiu $s6,$0,3  #����Ƽ���?
zmd_loop:

addiu $s0, $s0, 1    #������һ������Ƶ�����?
andi $s0, $s0, 15  

#######################################
addi $t0,$0,8    
addi $t1,$0,1
left:

sll $s3, $s3, 4   #���������?
or $s3, $s3, $s0

add    $a0,$0,$s3       # display $s3
addi   $v0,$0,34         # system call for LED display 
syscall                 # display 

sub $t0,$t0,$t1
bne $t0,$0,left
#######################################

addi $s0, $s0, 1   #������һ������Ƶ�����?
addi $t8,$0,15
and $s0, $s0, $t8
sll $s0, $s0, 28     

addi $t0,$0,8
addi $t1,$0,1

zmd_right:

srl $s3, $s3, 4  #���������?
or $s3, $s3, $s0

addu    $a0,$0,$s3       # display $s3
addi   $v0,$0,34         # system call for LED display 
syscall                 # display 

sub $t0,$t0,$t1
bne $t0,$0,zmd_right
srl $s0, $s0, 28  
#######################################

sub $s6,$s6,$t1
beq $s6,$0, exit
j zmd_loop

exit:

add $t0,$0,$0
nor $t0,$t0,$t0      #test nor  ori
sll $t0,$t0,16
ori $t0,$t0,0xffff

addu   $a0,$0,$t0       # display $t0
addi   $v0,$0,34         # system call for LED display 
syscall                 # display 
#################################################################################
#������ʵ��0-15���ֵ�Ԫ�Ľ�������,�˳������mars mips������������
#����ʱ�뽫Mars Setting�е�Memory Configuration����ΪCompact��data at address 0
#
#################################################################################
 .text
sort_init:
 addi $s0,$0,-1
 addi $s1,$0,0
 
 sw $s0,0($s1)
 addi $s0,$s0,1
 addi $s1,$s1,4
 sw $s0,0($s1)
 addi $s0,$s0,1
 addi $s1,$s1,4
 sw $s0,0($s1)
 addi $s0,$s0,1
 addi $s1,$s1,4
 sw $s0,0($s1)
 addi $s0,$s0,1
 addi $s1,$s1,4
 sw $s0,0($s1)
 addi $s0,$s0,1
 addi $s1,$s1,4
 sw $s0,0($s1)
 addi $s0,$s0,1
 addi $s1,$s1,4
 sw $s0,0($s1)
 addi $s0,$s0,1
 addi $s1,$s1,4
 sw $s0,0($s1)
 addi $s0,$s0,1
 addi $s1,$s1,4
  sw $s0,0($s1)
 addi $s0,$s0,1
 addi $s1,$s1,4
  sw $s0,0($s1)
 addi $s0,$s0,1
 addi $s1,$s1,4
 sw $s0,0($s1)
 addi $s0,$s0,1
 addi $s1,$s1,4
  sw $s0,0($s1)
 addi $s0,$s0,1
 addi $s1,$s1,4
  sw $s0,0($s1)
 addi $s0,$s0,1
 addi $s1,$s1,4
  sw $s0,0($s1)
 addi $s0,$s0,1
 addi $s1,$s1,4
  sw $s0,0($s1)
 addi $s0,$s0,1
 addi $s1,$s1,4
    sw $s0,0($s1)
 addi $s0,$s0,1
 addi $s1,$s1,4
   
 addi $s0,$s0,1
 
 add $s0,$zero,$zero   
 addi $s1,$zero,60   #��������
sort_loop:
 lw $s3,0($s0)     
 lw $s4,0($s1)
 slt $t0,$s3,$s4
 beq $t0,$0,sort_next   #��������
 sw $s3, 0($s1)
 sw $s4, 0($s0)   
sort_next:
 addi $s1, $s1, -4   
 bne $s0, $s1, sort_loop  
 
 add    $a0,$0,$s0       #display $s0
 addi   $v0,$0,34         # display hex
 syscall                 # we are out of here.  DISP: disp $r0, 0
 
 addi $s0,$s0,4
 addi $s1,$zero,60
 bne $s0, $s1, sort_loop

 addi   $v0,$zero,10         # system call for exit
 syscall                  # we are out of here.   
 #MIPS������ʵ��������ͣ��ָ��ʵ��syscall

jmp_count: addi $s0,$zero, 0
       addi $s0,$s0, 1
       add    $a0,$0,$s0      
       addi   $v0,$0,34         # display hex
       syscall                 # we are out of here.  
       
       addi $s0,$s0, 2
       add    $a0,$0,$s0      
       addi   $v0,$0,34         # display hex
       syscall                 # we are out of here.  
       
       addi $s0,$s0, 3
       add    $a0,$0,$s0      
       addi   $v0,$0,34         # display hex
       syscall                 # we are out of here.  
       
       addi $s0,$s0, 4       
       add    $a0,$0,$s0      
       addi   $v0,$0,34         # display hex
       syscall                 # we are out of here.  
       
       addi $s0,$s0, 5              
       add    $a0,$0,$s0      
       addi   $v0,$0,34         # display hex
       syscall                 # we are out of here.  
       
       addi $s0,$s0, 6              
       add    $a0,$0,$s0      
       addi   $v0,$0,34         # display hex
       syscall                 # we are out of here.  

       addi $s0,$s0, 7              
       add    $a0,$0,$s0      
       addi   $v0,$0,34         # display hex
       syscall                 # we are out of here.  

       addi $s0,$s0, 8              
       add    $a0,$0,$s0      
       addi   $v0,$0,34         # display hex
       addi   $v0,$0,34         # display hex       
       syscall                 # we are out of here.  

       
       jr $31
