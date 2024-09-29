.data
    prompt_num:       .asciiz "¿Cuántos números de la serie Fibonacci deseas generar?: "
    fib_msg:          .asciiz "Los primeros números de la serie Fibonacci son: "
    sum_msg:          .asciiz "La suma de la serie es: "
    newline:          .asciiz "\n"

.text
.globl main

main:
    # Solicitar cuántos números de la serie Fibonacci desea generar
    li $v0, 4                     # syscall para imprimir string
    la $a0, prompt_num             # cargar mensaje en $a0
    syscall
    
    li $v0, 5                     # syscall para leer número entero
    syscall
    move $t0, $v0                 # $t0 tiene el número de términos de la serie

    # Inicializar variables
    li $t1, 0                     # $t1 será el primer número de la serie (0)
    li $t2, 1                     # $t2 será el segundo número de la serie (1)
    li $t3, 0                     # $t3 será el contador
    li $t4, 0                     # $t4 acumula la suma de la serie

    # Mostrar el mensaje de la serie Fibonacci
    li $v0, 4                     # syscall para imprimir string
    la $a0, fib_msg                # cargar mensaje en $a0
    syscall

fibonacci_loop:
    # Imprimir el número actual de la serie ($t1)
    li $v0, 1                     # syscall para imprimir entero
    move $a0, $t1                 # mover el valor de $t1 (fibonacci actual)
    syscall

    # Salto de línea entre números
    li $v0, 4                     # syscall para imprimir string
    la $a0, newline                # cargar salto de línea
    syscall

    # Sumar el valor actual de $t1 a $t4 (la suma total)
    add $t4, $t4, $t1

    # Generar el siguiente número de Fibonacci
    add $t5, $t1, $t2             # $t5 = $t1 + $t2
    move $t1, $t2                 # $t1 ahora es el anterior $t2
    move $t2, $t5                 # $t2 ahora es el nuevo número Fibonacci

    # Incrementar el contador
    addi $t3, $t3, 1

    # Comparar si ya se generaron todos los términos
    bne $t3, $t0, fibonacci_loop

    # Imprimir la suma de la serie
    li $v0, 4                     # syscall para imprimir string
    la $a0, sum_msg                # cargar mensaje en $a0
    syscall

    li $v0, 1                     # syscall para imprimir entero
    move $a0, $t4                 # mover la suma total en $a0
    syscall

    # Salto de línea final
    li $v0, 4                     # syscall para imprimir string
    la $a0, newline                # cargar salto de línea
    syscall

    # Terminar el programa
    li $v0, 10                    # syscall para salir
    syscall
