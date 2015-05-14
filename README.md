##CS 2160 Computer Organization & Assembly Language
###HW6

Due by e-mail Thursday October 31, 2013, beginning of class (12:15PM)

Write an assembly language program with the following specifications:

1. File name: `HW6_<your name>.asm`  (e.g., `HW5_Glock.asm`)
2. A `strcmp` routine which compares two strings.  It accepts string addresses in `$a0` and `$a1`.  If the string at `$a1` sorts before the string at `$a0`, the routine returns a negative number in `$v0`.  In the strings are in order, the result is non-negative.
3. A `sort` routine based on a bubble sort.  The bubble sort sorts a string array.  The strings are declared at the beginning of the program. And are stored at five separate locations.  The addresses of the strings are in a “table”.  The number of entries in the table is located at `nEntries`.  The table itself is located at `NameTable`.  Name table is composed of the addresses of the (`nEntries`) strings.
4)	Insert your code at the end of the code below:  Please do not change the boilerplate code as this causes difficulties in grading.

```Assembly
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
# your code here
#returns a negative number if string at $a1 is before string at $a0
#	$a0, $a1 location of strings to compare
#	$v0 compare result
jr	$ra

Sort:
# your code here
jr $ra
```
