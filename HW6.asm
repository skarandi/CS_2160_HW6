.data
String1:
.asciiz	"George\n"
String2:
.asciiz "Zachary\n"
String3:
.asciiz "Roberta\n"
String4:
.asciiz "Robert\n"
String5:
.asciiz "Amy\n"
nEntries:
.word 5
NameTable:
.space 20
cr:
.asciiz	"\n"
Note1:
.asciiz "Original List:\n"
Note2:
.asciiz "Sorted List:\n"

.text
jal	Initialize
addi	$v0, $0, 4	#print command
la	$a0, Note1
syscall

jal	PrintOut
addi	$v0, $0, 4	#print command
la	$a0, Note2
syscall
jal	Sort
jal	PrintOut
addi	$v0, $0, 10	#end the program
syscall

Initialize:
la	$t0, NameTable
la 	$t1, String1
sw	$t1, 0($t0)
la 	$t1, String2
sw	$t1, 4($t0)
la 	$t1, String3
sw	$t1, 8($t0)
la 	$t1, String4
sw	$t1, 12($t0)
la 	$t1, String5
sw	$t1, 16($t0)
jr 	$ra

PrintOut:
addi	$t0, $0, 0	#initialize counter
la	$t2, nEntries
lw	$t2, 0($t2)
la	$t1, NameTable
addi	$v0, $0, 4	#print command
Reprint:
lw	$a0, 0($t1)
syscall
addi	$t0, $t0, 1	#increment counter
addi	$t1, $t1, 4
bne	$t0, $t2, Reprint
addi	$v0, $0, 4	#print command
la	$a0, cr
syscall

jr	$ra

strcmp:
#	returns a negative number if string at $a1 is before string at $a0
#	$a0, $a1 location of strings to compare
#	$v0 compare result
lw	$t2, ($a0)		# $t2 = value of 1st string
lw	$t3, ($a1)		# $t2 = value of 2nd string
lb	$t4, ($t2)		# $t4 = current letter of 1st string
lb	$t5, ($t3)		# $t5 = current letter of 2nd string
loop4:
sub	$t6, $t5, $t4		# $t6 = current letter of 2nd string - current letter of 1st string
blt	$t6, $zero, outoforder	# $t6 < 0; go to outoforder
bgt	$t6, $zero, inorder	# $t6 > 0; go to inorder
addi	$t2, $t2, 1		# move to next letter of 1st string
addi	$t3, $t3, 1		# move to next letter of 2nd string
lb	$t4, ($t2)		# $t4 = current letter of 1st string
lb	$t5, ($t3)		# $t5 = current letter of 2nd string
beq	$t5, 10, endstring2	# current letter of 2nd string = NL; go to endstring2
j	loop4			# return to loop4
inorder:
addi	$v0, $zero, 1		# $v0 = 1; strings are in order
j	loop3			# go to loop3
outoforder:
addi	$v0, $zero, -1		# $v0 = -1; strings are out of order
j	loop3			# go to loop3
endstring2:
lw	$t2, ($a0)		# $t2 = value of 1st string
lw	$t3, ($a1)		# $t3 = value of 2nd string
j	outoforder		# go to outoforder

Sort:
la	$s0, NameTable		# $s0 = NameTable
lb	$s2, nEntries		# $s2  = nEntries
li	$s3, 0			# done = false
loop1:
la	$a0, 0($s0)		# $a0 = 1st string in NameTable
la	$a1, 4($s0)		# $a1 = 2nd string in NameTable
li	$s1, 1			# pass = 1
beqz	$s3, setdone		# done = false; go to setdone
jr	$ra			# return
setdone:
li	$s3, 1			# done = true
loop2:
sub	$s4, $s2, $s1		# $s4 = (nEntries - pass)
addi	$s1, $s1, 1		# pass++
bgt	$s4, $zero, strcmp	# (nEntries - pass) > 0; go to strcmp
j	loop1			# (nEntries - pass) !> 0; return to loop1
loop3:
blt	$v0, $zero, swap	# strings are out of order; go to swap
addi	$a0, $a0, 4		# $a0 = next string in NameTable
addi	$a1, $a1, 4		# $a1 = next string in NameTable
j	loop2			# return to loop2
swap:
sw	$t3, ($a0)		# $a0 = $a1
sw	$t2, ($a1)		# $a1 = $a0
li	$s3, 0			# done = false
addi	$a0, $a0, 4		# $a0 = next string in NameTable
addi	$a1, $a1, 4		# $a1 = next string in NameTable
j	loop2			# return to loop2