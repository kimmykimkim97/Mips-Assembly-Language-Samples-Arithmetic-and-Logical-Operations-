# I know it looks messy. lol. This was a last minute attempt. Will be fixing it sooooon.

.data
    # ............................................................ Menu ............................................................ #
menu:               .asciiz "Select an option:\n1. Calculate (A - B) * C\n2. Calculate A + (B * C)\n3. Calculate (A * B) * (B % C)\n4. Calculate (A AND B) OR C\n5. Calculate A NAND (B OR C)\n6. Calculate A XNOR (B OR C)\n7. Exit\n\nEnter your choice: "
    # ................................. Prompt message for A, B, C value for arithmetic equations ................................. #
prompt_arith_A:     .asciiz "Enter the value of A: "
prompt_arith_B:     .asciiz "Enter the value of B: "
prompt_arith_C:     .asciiz "Enter the value of C: "
    # ................................... Prompt message for A, B, C value for logical equations ................................... #
prompt_logic_A:     .asciiz "Enter the value of A (0 or 1 only): "
prompt_logic_B:     .asciiz "Enter the value of B (0 or 1 only): "
prompt_logic_C:     .asciiz "Enter the value of C (0 or 1 only): "
    # ....................................................... result message ....................................................... #
result_msg:         .asciiz "The result: "
line_div:           .asciiz "-------------------------------------------------------------------------\n"
    # ........................................................ Exit message ........................................................ #
exit_msg:           .asciiz "Exiting program. またね ~ Byyeeeee!"
newline:            .asciiz "\n"
    # ................................................ Invalid option/input message ................................................ #
invalid_option_msg: .asciiz "Invalid option! Please enter a number between 1 and 7.\n"
invalid_input_msg:  .asciiz "Invalid input! A, B, and C should only be integer value for arithmetic operation.\n"
invalid_input_logical_msg: .asciiz "Invalid input! A, B, and C should only be 0 or 1 for logical operation.\n"    

.text
.globl  main

main:
    # .......................................... Display menu and read operation number .......................................... #
    li $v0, 4
    la $a0, menu
    syscall
    # .................................................... Read operation number ................................................ #
    li $v0, 5
    syscall

    move $t0, $v0
    # Move user choice to $t0
    # ...........................................  Initialize the registers with values ...........................................#
    li $t1, 1 # Load immediate: 1
    li $t2, 2 # load immediate: 2
    li $t3, 3 # load immediate: 3
    li $t4, 4 # load immediate: 4
    li $t5, 5 # load immediate: 5
    li $t6, 6 # load immediate: 6
    li $t7, 7 # load immediate: 7

    # .................................................... Handle user choice .................................................... #
    blez $t0, invalid_op_num  # Branch if less than or equal to zero
    bgt $t0, 7, invalid_op_num # Branch if greater than 6
    beq $t0, $t1, option_1 # Branch if equal to 1
    beq $t0, $t2, option_2 # Branch if equal to 2
    beq $t0, $t3, option_3 # Branch if equal to 3
    beq $t0, $t4, option_4 # Unconditional jump
    beq $t0, $t5, option_5 # Branch if equal to 5
    beq $t0, $t6, option_6 # Branch if equal to 6
    beq $t0, $t7, exit

    j invalid_op_num # Unconditional jump
    # .................................................... [(A - B) * C] .................................................... #
option_1:
    # Prompt and read input values (A, B, C) for arithmetic operation
    li $v0, 4
    la $a0, prompt_arith_A
    syscall

    li  $v0, 5                          # Use syscall 5 for reading an integer
    syscall
    move $t2, $v0 # Move the integer input to $t2

    li $v0, 4
    la $a0, prompt_arith_B
    syscall

    li $v0, 5 # Use syscall 5 for reading an integer
    syscall 

    move $t3, $v0 # Move the integer input to $t3
    li $v0, 4
    la $a0, prompt_arith_C
    syscall

    li $v0, 5 # Use syscall 5 for reading an integer
    syscall
    move $t4, $v0 # Move the integer input to $t4

    # Validate input values
    move $a0, $s0
    jal validate_input_arithmetic
    move $s0, $v0

    move $a0, $s1
    jal validate_input_arithmetic
    move $s1, $v0

    move $a0, $s2
    jal validate_input_arithmetic
    move $s2, $v0

    # Calculate (A - B) * C
    sub $t5, $t2, $t3 # $t5 = A - B                                                                                                                                                                                                     
    mul $t6, $t5, $t4 # $t6 = (A - B) * C                                                                                                                                                                                                        

    # Display arithmetic result
    li $v0, 4 # Print string
    la $a0, result_msg
    syscall

    li $v0, 1 # Print integer
    move $a0, $t6
    syscall

    #enter new line
    li $v0, 4
    la $a0, newline
    syscall

    j back_to_menu

    # .................................................... [A + (B * C)] .................................................... #
option_2:
    # Prompt and read input values (A, B, C) for arithmetic operation
    li $v0, 4 #print string
    la $a0, prompt_arith_A
    syscall

    li $v0, 5 #read input
    syscall
    move $s0, $v0 # move value of A into $s0

    li $v0, 4 #print string
    la $a0, prompt_arith_B
    syscall

    li $v0, 5 #read input
    syscall
    move $s1, $v0 # move value of B into $s1

    li $v0, 4 #print string
    la $a0, prompt_arith_C
    syscall

    li $v0, 5 #read input
    syscall
    move $s2, $v0 # move value of  into $s2

   # Validate input values
    move $a0, $s0
    jal validate_input_arithmetic
    move $s0, $v0

    move $a0, $s1
    jal validate_input_arithmetic
    move $s1, $v0

    move $a0, $s2
    jal validate_input_arithmetic
    move $s2, $v0

    # Calculate A + (B * C)
    mul $t0, $s1, $s2 #t0 = s1 * s2
    add $s3, $t0, $s0 #s3 = t0 + s0

    # Display arithmetic result
    li $v0, 4 #print string
    la $a0, result_msg
    syscall

    li $v0, 1 #print result
    move $a0, $s3
    syscall

    #enter new line
    li $v0, 4
    la $a0, newline
    syscall
    j back_to_menu

    # .................................................... [(A * B) * (B % C)] .................................................... #
option_3:
    # Prompt and read input values (A, B, C) for arithmetic operation
    li $v0, 4                           #print string
    la $a0, prompt_arith_A
    syscall

    li $v0, 5                           #read input
    syscall
    move $s0, $v0 # move value of A into $s0

    li $v0, 4                           #print string
    la $a0, prompt_arith_B
    syscall

    li $v0, 5                           #read input
    syscall
    move $s1, $v0 # move value of B into $s1

    li $v0, 4                           #print string
    la $a0, prompt_arith_C
    syscall

    li $v0, 5                        #read input
    syscall
    move $s2, $v0                   # move value of  into $s2

                                    # Validate input values
    move $a0, $s0
    jal validate_input_arithmetic
    move $s0, $v0

    move $a0, $s1
    jal validate_input_arithmetic
    move $s1, $v0

    move $a0, $s2
    jal validate_input_arithmetic
    move $s2, $v0
    
    # Calculate (A * B)
    mul $s3, $s0, $s1 # $s3 = A * B                                                                                                                        
    # Calculate (B % C)
    div $s1, $s2                    # Divide $s1 by $s2; quotient in LO, remainder in HI
    mfhi $t0                        # Move remainder from HI into $t0 (or another register to avoid overwriting $s1)                                                                                                                                

    # Calculate (A * B) * (B % C)
    mul $s3, $s3, $t0               # $s3 = (A * B) * (B % C)                                                                                                                                                                                               

    # Display arithmetic result
    li $v0, 4                      #print string
    la $a0, result_msg
    syscall

    #print result
    li $v0, 1 
    move $a0, $s3
    syscall

    #enter new line
    li $v0, 4
    la $a0, newline
    syscall
    j back_to_menu
    # .................................................... [(A AND B) OR C] .................................................... #
option_4:
     # Prompt for value of A
    li $v0, 4                     # Syscall for print string
    la $a0, prompt_logic_A        # Load address of prompt for A
    syscall                       # Print the prompt

    # Read the value of A
    li $v0, 5                     # Syscall for read integer
    syscall                       # Read the integer input
    move $s0, $v0                 # Move input value to $s0 (A)

    # Prompt for value of B
    li $v0, 4                     # Syscall for print string
    la $a0, prompt_logic_B        # Load address of prompt for B
    syscall                       # Print the prompt

    # Read the value of B
    li $v0, 5                     # Syscall for read integer
    syscall                       # Read the integer input
    move $s1, $v0                 # Move input value to $s1 (B)

    # Prompt for value of C
    li $v0, 4                     # Syscall for print string
    la $a0, prompt_logic_C        # Load address of prompt for C
    syscall                       # Print the prompt

    # Read the value of C
    li $v0, 5                     # Syscall for read integer
    syscall                       # Read the integer input
    move $s2, $v0                 # Move input value to $s2 (C)

    # Validate input values
    move $a0, $s0
    jal validate_input_logical
    move $s0, $v0

    move $a0, $s1
    jal validate_input_logical
    move $s1, $v0

    move $a0, $s2
    jal validate_input_logical
    move $s2, $v0


    # Calculate A AND B
    and $s3, $s0, $s1             # $s3 = A AND B

    # Calculate (A AND B) OR C
    or $s4, $s3, $s2              # $s4 = (A AND B) OR C

    # Print the result message
    li $v0, 4                     # Syscall for print string
    la $a0, result_msg            # Load address of result message
    syscall                       # Print the message

    # Print the result
    li $v0, 1                     # Syscall for print integer
    move $a0, $s4                 # Move the result to $a0
    syscall                       # Print the result

    # Newline for output clarity
    li $v0, 4                     # Syscall for print string
    la $a0, newline               # Load address of newline
    syscall                       # Print newline
    j       back_to_menu
    # .................................................... [A NAND (B OR C)] .................................................... #
option_5:
    # Prompt for value of A
    li $v0, 4                     # Syscall for print string
    la $a0, prompt_logic_A        # Load address of prompt for A
    syscall                       # Print the prompt

    # Read the value of A
    li $v0, 5                     # Syscall for read integer
    syscall                       # Read the integer input
    move $s0, $v0                 # Move input value to $s0 (A)

    # Prompt for value of B
    li $v0, 4                     # Syscall for print string
    la $a0, prompt_logic_B        # Load address of prompt for B
    syscall                       # Print the prompt

    # Read the value of B
    li $v0, 5                     # Syscall for read integer
    syscall                       # Read the integer input
    move $s1, $v0                 # Move input value to $s1 (B)

    # Prompt for value of C
    li $v0, 4                     # Syscall for print string
    la $a0, prompt_logic_C        # Load address of prompt for C
    syscall                       # Print the prompt

    # Read the value of C
    li $v0, 5                     # Syscall for read integer
    syscall                       # Read the integer input
    move $s2, $v0                 # Move input value to $s2 (C)

    # Validate input values
    move $a0, $s0
    jal validate_input_logical
    move $s0, $v0

    move $a0, $s1
    jal validate_input_logical
    move $s1, $v0

    move $a0, $s2
    jal validate_input_logical
    move $s2, $v0

    # Calculate B OR C
    or $s3, $s1, $s2              # $s3 = B OR C

    # Calculate A NAND (B OR C)
    and $s4, $s0, $s3             # $s4 = A AND (B OR C)
    nor $s4, $s4, $zero           # $s4 = NOT (A AND (B OR C)), which is NAND

    # Print the result message
    li $v0, 4                     # Syscall for print string
    la $a0, result_msg            # Load address of result message
    syscall                       # Print the message

    # Print the result
    li $v0, 1                     # Syscall for print integer
    move $a0, $s4                 # Move the result to $a0
    syscall                       # Print the result

    # Newline for output clarity
    li $v0, 4                     # Syscall for print string
    la $a0, newline               # Load address of newline
    syscall                       # Print newline
    j      back_to_menu 
    # .................................................... [A XNOR (B OR C)] .................................................... #
option_6:
    # Prompt for value of A
    li $v0, 4                     # Syscall for print string
    la $a0, prompt_logic_A        # Load address of prompt for A
    syscall                       # Print the prompt

    # Read the value of A
    li $v0, 5                     # Syscall for read integer
    syscall                       # Read the integer input
    move $s0, $v0                 # Move input value to $s0 (A)

    # Prompt for value of B
    li $v0, 4                     # Syscall for print string
    la $a0, prompt_logic_B        # Load address of prompt for B
    syscall                       # Print the prompt

    # Read the value of B
    li $v0, 5                     # Syscall for read integer
    syscall                       # Read the integer input
    move $s1, $v0                 # Move input value to $s1 (B)

    # Prompt for value of C
    li $v0, 4                     # Syscall for print string
    la $a0, prompt_logic_C        # Load address of prompt for C
    syscall                       # Print the prompt

    # Read the value of C
    li $v0, 5                     # Syscall for read integer
    syscall                       # Read the integer input
    move $s2, $v0                 # Move input value to $s2 (C)

    # Validate input values
    move $a0, $s0
    jal validate_input_logical
    move $s0, $v0

    move $a0, $s1
    jal validate_input_logical
    move $s1, $v0

    move $a0, $s2
    jal validate_input_logical
    move $s2, $v0

    # Calculate B OR C
    or $s3, $s1, $s2              # $s3 = B OR C

    # Calculate A XNOR (B OR C)
    xor $s4, $s0, $s3             # $s4 = A XOR (B OR C)
    nor $s4, $s4, $zero           # $s4 = NOT (A XOR (B OR C)), which is XNOR

    # Print the result message
    li $v0, 4                     # Syscall for print string
    la $a0, result_msg            # Load address of result message
    syscall                       # Print the message

    # Print the result
    li $v0, 1                     # Syscall for print integer
    move $a0, $s4                 # Move the result to $a0
    syscall                       # Print the result

    # Newline for output clarity
    li $v0, 4                     # Syscall for print string
    la $a0, newline               # Load address of newline
    syscall                       # Print newline
    j       back_to_menu

    #----------------------------------------------------------------------------------------------------------------------------#
# Function to handle invalid menu option input
invalid_op_num:
    # Display an error message indicating invalid input
    li $v0, 4
    la $a0, invalid_op_msg
    syscall

    # Return to the main menu
    j back_to_menu

# Function to validate input values for arithmetic operations
validate_input_arithmetic:
    # Load ASCII codes for '0' and '9'
    li $t0, '0'
    li $t1, '9'

    # Check if the input value is negative
    bltz $a0, invalid_input

    # Check if the input value is within the range of '0' and '9'
    bge $a0, $t0, check_input
    bgt $a0, $t1, invalid_input

    # If the input is valid, return
    check_input:
    jr $ra

# Handle invalid input for arithmetic operations
invalid_input:
    # Display an error message indicating invalid input
    li $v0, 4
    la $a0, invalid_input_msg
    syscall

    # Return to the main menu
    j back_to_menu

# Function to validate input values for logical operations
validate_input_logical:
    # Load ASCII codes for '0' and '1'
    li $t0, '0'
    li $t1, '1'

    # Check if the input value is negative or greater than '1'
    bltz $a0, invalid_input_logical
    bgt $a0, $t1, invalid_input_logical

    # Check if the input value is not '0' or '1'
    bne $a0, $t0, invalid_input_logical

    # If the input is valid, return
    jr $ra

# Handle invalid input for logical operations
invalid_input_logical:
    # Display an error message indicating invalid input
    li $v0, 4
    la $a0, invalid_input_logical_msg
    syscall

    # Return to the main menu
    j back_to_menu

# Function to return to the main menu
back_to_menu:
    # Print a newline and a divider line
    li $v0, 4
    la $a0, newline
    syscall
    li $v0, 4
    la $a0, line_div
    syscall

    # Jump to the main menu
    j main

# Exit the program
exit:
    # Display an exit message
    li $v0, 4
    la $a0, exit_msg
    syscall

    # Terminate the program
    li $v0, 10
    syscall