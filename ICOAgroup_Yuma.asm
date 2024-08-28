.data
    # ............................................................ Menu ............................................................ #
menu:               .asciiz "Select an option:\n1. Calculate (A AND B) OR C\n2. Calculate A NAND (B OR C)\n3. Calculate A XNOR (B OR C)\n4. Calculate (A - B) * C\n5. Calculate A + (B * C)\n6. Calculate (A * B) * (B % C)\n7. Exit\n\nEnter your choice: "
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
exit_msg:           .asciiz "Exiting program. またね （ ´ ∀｀）/~ Byyeeeee!\n"
cat_art:            .asciiz " /\\_/\\\n( o.o )\n > ^ <\n"
newline:            .asciiz "\n"
    # ................................................ Invalid option/input message ................................................ #
invalid_option_msg: .asciiz "Invalid option! Please enter a number between 1 and 7.\n"
invalid_input_msg:  .asciiz "Invalid Input!"
invalid_input_logical_msg: .asciiz "Invalid input! A, B, and C should only be 0 or 1 for logical operation.\n"

.text
.globl main

main:
    # .......................................... Display menu and read operation number .......................................... #
    li $v0, 4
    la $a0, menu
    syscall

    # .................................................... Read operation number ................................................ #
    li $v0, 5
    syscall

    move $t0, $v0   # Move user choice to $t0
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
    beq $t0, $t4, option_4 # Branch if equal to 4
    beq $t0, $t5, option_5 # Branch if equal to 5
    beq $t0, $t6, option_6 # Branch if equal to 6
    beq $t0, $t7, exit     # Branch if equal to 7

    j invalid_op_num # Unconditional jump to invalid option

# .................................................... [(A AND B) OR C] .................................................... #
option_1:
    # Prompt for value of A
    li $v0, 4
    la $a0, prompt_logic_A
    syscall

    # Read the value of A
    li $v0, 5                     # Syscall for read integer
    syscall                       # Read the integer input

    move $a0, $v0                 # Move input value to $a0 (A)
    jal validate_input_logical    # Validate input as logical
    move $s0, $v0                 # Move validated input to $s0

    # Prompt for value of B
    li $v0, 4
    la $a0, prompt_logic_B
    syscall

    # Read the value of B
    li $v0, 5                     # Syscall for read integer
    syscall                       # Read the integer input

    move $a0, $v0                 # Move input value to $a0 (B)
    jal validate_input_logical    # Validate input as logical
    move $s1, $v0                 # Move validated input to $s1

    # Prompt for value of C
    li $v0, 4
    la $a0, prompt_logic_C
    syscall

    # Read the value of C
    li $v0, 5                     # Syscall for read integer
    syscall                       # Read the integer input

    move $a0, $v0                 # Move input value to $a0 (C)
    jal validate_input_logical    # Validate input as logical
    move $s2, $v0                 # Move validated input to $s2

    # Calculate (A AND B) OR C
    and $t0, $s0, $s1             # $t0 = A AND B
    or $t1, $t0, $s2              # $t1 = (A AND B) OR C

    # Print the result message
    li $v0, 4
    la $a0, result_msg
    syscall

    # Print the result
    li $v0, 1
    move $a0, $t1
    syscall

    # Newline for output clarity
    li $v0, 4
    la $a0, newline
    syscall

    j back_to_menu

# .................................................... [A NAND (B OR C)] .................................................... #
option_2:
 # Prompt for value of A
    li $v0, 4
    la $a0, prompt_logic_A
    syscall

    # Read the value of A
    li $v0, 5                     # Syscall for read integer
    syscall                       # Read the integer input
    move $a0, $v0                 # Move input value to $s0 (A)

    jal validate_input_logical    # Validate input as logical
    move $s0, $v0                 # Move validated input to $s0

    # Prompt for value of B
    li $v0, 4
    la $a0, prompt_logic_B
    syscall

    # Read the value of B
    li $v0, 5                     # Syscall for read integer
    syscall                       # Read the integer input
    move $a0, $v0                 # Move input value to $s1 (B)

    jal validate_input_logical    # Validate input as logical
    move $s1, $v0                 # Move validated input to $s1

    # Prompt for value of C
    li $v0, 4
    la $a0, prompt_logic_C
    syscall

    # Read the value of C
    li $v0, 5                     # Syscall for read integer
    syscall                       # Read the integer input
    move $a0, $v0                 # Move input value to $s2 (C)

    jal validate_input_logical    # Validate input as logical
    move $s2, $v0                 # Move validated input to $s2

    # Calculate A NAND (B OR C)
    or $t0, $s1, $s2              # $t0 = B OR C
    and $t1, $s0, $t0             # $t1 = A AND (B OR C)
    xori $t2, $t1, 1              # $t2 = A NAND (B OR C)

    # Print the result message
    li $v0, 4
    la $a0, result_msg
    syscall

    # Print the result
    li $v0, 1
    move $a0, $t2
    syscall

    # Newline for output clarity
    li $v0, 4
    la $a0, newline
    syscall

    j back_to_menu

# .................................................... [A XNOR (B OR C)] .................................................... #
option_3:
    # Prompt for value of A
    li $v0, 4
    la $a0, prompt_logic_A
    syscall

    # Read the value of A
    li $v0, 5                     # Syscall for read integer
    syscall                       # Read the integer input
    move $a0, $v0                 # Move input value to $s0 (A)

    jal validate_input_logical    # Validate input as logical
    move $s0, $v0                 # Move validated input to $s0

    # Prompt for value of B
    li $v0, 4
    la $a0, prompt_logic_B
    syscall

    # Read the value of B
    li $v0, 5                     # Syscall for read integer
    syscall                       # Read the integer input
    move $a0, $v0                 # Move input value to $s1 (B)

    jal validate_input_logical    # Validate input as logical
    move $s1, $v0                 # Move validated input to $s1

    # Prompt for value of C
    li $v0, 4
    la $a0, prompt_logic_C
    syscall

    # Read the value of C
    li $v0, 5                     # Syscall for read integer
    syscall                       # Read the integer input
    move $a0, $v0                 # Move input value to $s2 (C)

    jal validate_input_logical    # Validate input as logical
    move $s2, $v0                 # Move validated input to $s2

    # Calculate A XNOR (B OR C)
    or $t0, $s1, $s2              # $t0 = B OR C
    xor $t1, $s0, $t0             # $t1 = A XOR (B OR C)
    xori $t2, $t1, 1              # $t2 = A XNOR (B OR C)

    # Print the result message
    li $v0, 4
    la $a0, result_msg
    syscall

    # Print the result
    li $v0, 1
    move $a0, $t2
    syscall

    # Newline for output clarity
    li $v0, 4
    la $a0, newline
    syscall

    j back_to_menu

# .................................................... [(A - B) * C] .................................................... #
option_4:
    # Prompt for value of A
    li $v0, 4
    la $a0, prompt_arith_A
    syscall

    # Read the value of A
    li $v0, 5                     # Syscall for read integer
    syscall                       # Read the integer input

    # Validate input value A
    move $a0, $v0                 # Move input value to $a0 (A)
    jal validate_input_arithmetic
    move $s0, $v0                 # Move validated input to $s0

    # Prompt for value of B
    li $v0, 4
    la $a0, prompt_arith_B
    syscall

    # Read the value of B
    li $v0, 5                     # Syscall for read integer
    syscall                       # Read the integer input

    # Validate input value B
    move $a0, $v0                 # Move input value to $a0 (B)
    jal validate_input_arithmetic
    move $s1, $v0                 # Move validated input to $s1

    # Prompt for value of C
    li $v0, 4
    la $a0, prompt_arith_C
    syscall
    
    # Read the value of C
    li $v0, 5                     # Syscall for read integer
    syscall                       # Read the integer input
    
    # Validate input value C
    move $a0, $v0                 # Move input value to $a0 (C)
    jal validate_input_arithmetic
    move $s2, $v0                 # Move validated input to $s2
    
    # Calculate (A - B) * C
    sub $t0, $s0, $s1             # $t0 = A - B
    mul $t1, $t0, $s2             # $t1 = (A - B) * C

    # Display arithmetic result
    li $v0, 4
    la $a0, result_msg
    syscall

    # Print integer
    li $v0, 1
    move $a0, $t1
    syscall

    # Enter new line
    li $v0, 4
    la $a0, newline
    syscall

    j back_to_menu

# .................................................... [A + (B * C)] .................................................... #
option_5:
    # Prompt for value of A
    li $v0, 4
    la $a0, prompt_arith_A
    syscall

    # Read the value of A
    li $v0, 5                     # Syscall for read integer
    syscall                       # Read the integer input

    # Validate input value A
    move $a0, $v0                 # Move input value to $a0 (A)
    jal validate_input_arithmetic
    move $s0, $v0                 # Move validated input to $s0

    # Prompt for value of B
    li $v0, 4
    la $a0, prompt_arith_B
    syscall

    # Read the value of B
    li $v0, 5                     # Syscall for read integer
    syscall                       # Read the integer input

    # Validate input value B
    move $a0, $v0                 # Move input value to $a0 (B)
    jal validate_input_arithmetic
    move $s1, $v0                 # Move validated input to $s1

    # Prompt for value of C
    li $v0, 4
    la $a0, prompt_arith_C
    syscall
    
    # Read the value of C
    li $v0, 5                     # Syscall for read integer
    syscall                       # Read the integer input
    
    # Validate input value C
    move $a0, $v0                 # Move input value to $a0 (C)
    jal validate_input_arithmetic
    move $s2, $v0                 # Move validated input to $s2
    
    # Calculate A + (B * C)
    mul $t0, $s1, $s2             # $t0 = B * C
    add $s3, $t0, $s0             # $s3 = A + (B * C)

    # Display arithmetic result
    li $v0, 4
    la $a0, result_msg
    syscall

    # Print integer
    li $v0, 1
    move $a0, $s3
    syscall

    # Enter new line
    li $v0, 4
    la $a0, newline
    syscall

    j back_to_menu

# .................................................... [(A * B) * (B % C)] .................................................... #
option_6:
     # Prompt for value of A
    li $v0, 4
    la $a0, prompt_arith_A
    syscall

    # Read the value of A
    li $v0, 5                     # Syscall for read integer
    syscall                       # Read the integer input

    # Validate input value A
    move $a0, $v0                 # Move input value to $a0 (A)
    jal validate_input_arithmetic
    move $s0, $v0                 # Move validated input to $s0

    # Prompt for value of B
    li $v0, 4
    la $a0, prompt_arith_B
    syscall

    # Read the value of B
    li $v0, 5                     # Syscall for read integer
    syscall                       # Read the integer input

    # Validate input value B
    move $a0, $v0                 # Move input value to $a0 (B)
    jal validate_input_arithmetic
    move $s1, $v0                 # Move validated input to $s1

    # Prompt for value of C
    li $v0, 4
    la $a0, prompt_arith_C
    syscall
    
    # Read the value of C
    li $v0, 5                     # Syscall for read integer
    syscall                       # Read the integer input
    
    # Validate input value C
    move $a0, $v0                 # Move input value to $a0 (C)
    jal validate_input_arithmetic
    move $s2, $v0                 # Move validated input to $s2
    
    # Check for division by zero
    beq $s2, $zero, input_invalid  # If C is zero, jump to input invalid

    # Calculate (A * B)
    mul $s3, $s0, $s1              # $s3 = A * B

    # Calculate (B % C)
    div $s1, $s2                   # Divide $s1 by $s2; quotient in LO, remainder in HI
    mfhi $t0                       # Move remainder from HI into $t0

    # Calculate (A * B) * (B % C)
    mul $s3, $s3, $t0              # $s3 = (A * B) * (B % C)

    # Display arithmetic result
    li $v0, 4
    la $a0, result_msg
    syscall

    # Print integer
    li $v0, 1
    move $a0, $s3
    syscall

    # Enter new line
    li $v0, 4
    la $a0, newline
    syscall

    j back_to_menu

# .......................................................... Functions .......................................................... #

#......................................... Function to handle invalid menu option input ......................................... #
invalid_op_num:
    # Display an error message indicating invalid input
    li $v0, 4
    la $a0, invalid_option_msg
    syscall

    # Return to the main menu
    j back_to_menu

#.................................. Function to validate input values for arithmetic operations .................................. #
validate_input_arithmetic:

    # Check if the input value is greater than 1000
    li $t0, 1000
    bgt $a0, $t0, invalid_input_arith
    ble $a0, $t0, valid_input

valid_input:
    jr $ra

# Handle invalid input for arithmetic operations
invalid_input_arith:
    # Display an error message indicating invalid input
    li $v0, 4
    la $a0, invalid_input_msg
    syscall

    # Return to the main menu
    j back_to_menu

input_invalid:      
    li $v0, 4       # Print Invalid message if C = 0 for option 6
    la $a0, invalid_input_msg
    syscall

    # Return to the main menu
    j back_to_menu

#.................................. Function to validate input values for logical operations .................................. #
validate_input_logical:
    # Input values must be 0 or 1 for logical operations
    li $t5, 0
    li $t6, 1

    # Check if the input is 0 or 1
    beq $a0, $t5, valid_logical
    beq $a0, $t6, valid_logical

    # If not, go to invalid input handler
    j invalid_input_logical

valid_logical:
    jr $ra

invalid_input_logical:
    # Display an error message indicating invalid input
    li $v0, 4
    la $a0, invalid_input_logical_msg
    syscall

    # Return to the main menu
    j back_to_menu

#........................................... Function to return to the main menu ........................................... #
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

#...................................................... Exit the program ..................................................... #
exit:
    # Display an exit message with ASCII art
    li $v0, 4
    la $a0, exit_msg
    syscall

    # Display additional cat ASCII art
    li $v0, 4
    la $a0, cat_art
    syscall

    # Terminate the program
    li $v0, 10
    syscall