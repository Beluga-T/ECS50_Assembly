.data
    string1:
        .string "hello"    # create a 101 space for null terminated string and initialize it to val
        # .space 100
    string2:
        .string "hella"    # create a 101 space for null terminated string and initialize it to val
        # .space 100
    len1:              # create a long for storing string1's length
        .long 0

    len2:              # create a long for storing string2's length
        .long 0

    min_val:           # store min value
        .long 0

    strlen_str:
        .long 0

    strlen_ret:
        .long 0
    oldDist:
        .space 4 * 100
    curDist:
        .space 4 * 100
    min_input_a:
        .long 0
    min_input_b:
        .long 0
    min_ret:
        .long 0

.text

.global _start
.equ ws,4

strlen:
    # save registers that will be used
    push %ecx
    push %ebx

    movl strlen_str, %ebx   # ebx = str
    movl $0, %ecx           # len = 0

    # for (; str[len] != '\0'; ++len)
    strlen_for_start:
        # str[len] != '\0' => str[len] - 0 != 0
        cmpb $0, (%ebx, %ecx, 1)
        je strlen_for_end
        incl %ecx           # ++len
        jmp strlen_for_start
    strlen_for_end:

    movl %ecx, strlen_ret

    # restore registers and return
    pop %ebx
    pop %ecx

    ret
strlen_end:

# int min(int a, int b){
#   return a < b ? a:b;
# }
min:
    # save registers that will be used
    push %eax
    push %ebx

    movl min_input_a, %eax # a
    movl min_input_b, %ebx # b

    cmpl %ebx, %eax # %eax - %ebx (a - b)
    jge min_ret_b   # if a-b >= 0, a>=b , jump to min_ret_b
    jmp min_ret_a   # else, jump to min_ret_a

    min_ret_a:
        movl %eax, min_ret  # min_ret = a
        jmp min_restore     # jump to min_restore

    min_ret_b:
        movl %ebx, min_ret  # min_ret = b
        jmp min_restore     # jump to min_restore

    min_restore:
        # restore registers and return
        pop %ebx
        pop %eax
    ret

min_end:

# void swap(int** a, int** b){
#   int* temp = *a;
#   *a = *b;
#   *b = temp;
# }


_start:

    # int word1_len = strlen(word1);
    movl $string1, strlen_str
    call strlen
    movl strlen_ret, %edi
    movl %edi, len1 # store word1_len

    # int word2_len = strlen(word2);
    movl $string2, strlen_str
    call strlen
    movl strlen_ret, %edi
    movl %edi, len2 # store word2_len

    # comments out to TEST for min
    # movl $10, min_input_a # a = 10
    # movl $20, min_input_b # b = 20
    # call min
    # movl min_ret, %edi  # min_ret = min(a,b) = 10

# for(i = 0; i < word2_len + 1; i++){
#   oldDist[i] = i;
#   curDist[i] = i;
# }
movl $0, %ebx                   # i = 0
first_start_for:
    cmpl len2, %ebx             # i < len2 + 1 == i <= len2
    jg first_end_for            # if i > len2, end the loop

    # oldDist[i] = i;
    movl %ebx, oldDist(,%ebx, ws) # Store i into oldDist[i]
    # curDist[i] = i;
    movl %ebx, curDist(,%ebx, ws) # Store i into oldDist[i]

    incl %ebx                   # ++i
    jmp first_start_for         # Continue the loop
first_end_for:

# for(i = 1; i < word1_len + 1; i++){
#     curDist[0] = i;
#   ebx = i
    movl %ebx, curDist(,0, ws)  # Store i into curDist[0]
    # word1[i-1]
    

#     for(j = 1; j < word2_len + 1; j++){
#      a if(word1[i-1] == word2[j-1]){
#         curDist[j] = oldDist[j - 1];
#       }#the characters in the words are the same
#      a else{
#         curDist[j] = min(min(oldDist[j], #deletion
#                           curDist[j-1]), #insertion
#                           oldDist[j-1]) + 1; #subs titution
#       }
#     }#for each character in the second word
#     swap(&oldDist, &curDist);
#   }#for each character in the first word

# for(i = 1; i < word1_len + 1; i++){
# %ebx = i
movl $1, %ebx

out_for_start:

    cmpl len1, %ebx             # i < len1 + 1 == i <= len1
    jg out_for_end              # if i > len1, end the loop         
   
    # curDist[0] = i;
    movl %ebx, curDist(,0, ws)  # Store i into curDist[0]

    # for(j = 1; j < word2_len + 1; j++)
    movl $1, %ecx               # j = 1
    in_for_start:




    incl %ebx                   # ++i
    jmp out_for_start           # Continue the outerloop
out_for_end:


done:
    nop 
