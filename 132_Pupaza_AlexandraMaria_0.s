
.section .note.GNU-stack,"",@progbits
.data
    x: .space 4
    y: .space 4
    i: .space 4
    j: .space 4
    id: .space 4
    valoare: .space 4
    k: .space 4
    contor: .space 4
    dim: .space 4
    desc: .space 4
    poz_start: .space 4
    poz_final: .space 4
    operatie: .space 4
    v: .space 4096
    nrfisiere: .space 4
    formatNuAdd: .asciz "%d\n"
    formatScan: .asciz "%d"
    formatPrintAdd: .asciz "%d: (%d, %d)\n"
    formatAddNuExista: .asciz "%d: (0, 0)\n"
    formatPrintGet: .asciz "(%d, %d)\n"
    formatNuExista: .asciz "(0, 0)\n"
    formatScan2: .asciz "%d %d"
    formatPrint: .asciz "%d"
    formatPrint2: .asciz "%d %d\n"

.text
program:

    pushl $operatie
    pushl $formatScan
    call scanf
    popl %ebx
    popl %ebx

    movl operatie, %eax


    cmpl $1, %eax
    je add

    cmpl $2, %eax
    je get

    cmpl $3, %eax
    je DELETE

    cmpl $4, %eax
    je defrag

add:
    pushl $nrfisiere
    pushl $formatScan
    call scanf
    popl %ebx
    popl %ebx

    movl nrfisiere, %ecx
    movl %ecx, j
    

    for_nrfisiere:

        pushl $dim
        pushl $desc
        pushl $formatScan2
        call scanf
        popl %ebx
        popl %ebx
        popl %ebx

        movl dim, %eax
        xorl %edx, %edx
        movl $8, %ebx
        divl %ebx
        cmpl $0, %edx
        je fara_rotunjire
        addl $1, %eax
        cmpl $2, %eax
        jl printareNuAdd

fara_rotunjire:

        for_vector:
            movl $0, %ecx
            
            movl $0, %ebx

            for_parcurgere:
            cmpl $1024, %ecx
            je printareNuAdd
                movl (%esi, %ecx, 4), %edx
                cmpl $0, %edx
                je adauga_spatiu

                cmpl $0, %edx
                jne spatiu_zero

                   adauga_spatiu:
                        addl $1, %ebx
                        cmpl %ebx, %eax
                        je adauga_vector

                        cmpl %ebx, %eax 
                        jg avanseaza

                    spatiu_zero:
                        movl $0, %ebx

                        avanseaza:
                            addl $1, %ecx
                            movl %ecx, poz_final
                            jmp for_parcurgere

adauga_vector:
    pushl poz_final
    movl poz_final, %eax
    subl %ebx, %eax
    addl $1, %eax

    movl %eax, poz_start
    pushl poz_start

for_dimensiune:
    
    movl desc, %edi
    movl %edi, (%esi, %eax, 4)

    cmpl %eax, %ecx
    je PrintareAdd

    addl $1, %eax
    jmp for_dimensiune

    

printareNuAdd:
popl %ebx
popl %ebx
 pushl desc
  pushl $formatAddNuExista
  call printf
 popl %edx
 popl %edx

 pushl $0
    call fflush
    popl %ebx

 jmp exit_nuAdd

PrintareAdd:
    popl %eax
    popl %edx

    pushl %edx
    pushl %eax
    pushl desc
    push $formatPrintAdd
    call printf
    popl %eax
    popl %eax
    popl %eax
    popl %eax

    pushl $0
    call fflush
    popl %ebx

exit_nuAdd:
    movl j, %ecx
    subl $1, %ecx
    movl %ecx, j
    cmpl $0, %ecx
    jne for_nrfisiere

        movl i, %ecx
        subl $1, %ecx
        movl %ecx, i
        cmpl $0, %ecx
        jne program

        cmpl $0, %ecx
        je et_exit
        

get:
    pushl %eax
    pushl $valoare
    pushl $formatScan
    call scanf
    popl %ebx
    popl %ebx

    lea v, %esi

    movl valoare, %eax
    movl $0, %ecx
    movl $-1, %ebx
    movl %ebx, poz_start

    for_get:
        cmpl %eax, (%esi, %ecx, 4)
        je verifica_start

        jmp verifica_nuEgal

        verifica_start:
            cmpl $-1, %ebx
            je pozitie_start
            jmp continua

        verifica_nuEgal:
            cmpl $-1, %ebx
            jne stop
            jmp continua

        stop:
            subl $1, %ecx
            movl %ecx, poz_final
            jmp afara

        pozitie_start:
            movl %ecx, poz_start
            movl %ecx, %ebx

        continua:
            inc %ecx
            cmp $1023, %ecx      #1012 merge, 1013 nu merge
            je verifica
            jmp for_get

        verifica:
            cmpl %ecx, %eax
            je poz_finala

        poz_finala:
            movl %ecx, poz_final
        afara:
            popl %eax
            cmpl $3, %eax
            je cont_del
            cmpl $-1, %ebx
            je NuExista
            jmp Exista

    NuExista:

        
        pushl $formatNuExista
        call printf
        
        popl %ebx
        jmp exit
        
    Exista:

        pushl poz_final
        pushl poz_start
        push $formatPrintGet
        call printf
        popl %ebx
        popl %ebx
        popl %ebx
exit:
        movl i, %ecx
        subl $1, %ecx
        movl %ecx, i
        cmpl $0, %ecx
        jne program

        cmpl $0, %ecx
        je et_exit
    
DELETE:

     jmp get

     cont_del:
        movl poz_start, %ecx
        movl poz_final, %edx


        movl poz_start, %ecx
        movl poz_final, %edx

        cmpl $-1, %ecx
        je afisare_delete

        for_delete:
            movl $0, %eax
            movl %eax, (%esi, %ecx, 4)
            cmp %ecx, %edx
            je afisare_delete
            addl $1, %ecx
            jmp for_delete

        afisare_delete:
        
            movl $0, %ecx
            movl $-1, %eax
            movl %eax, poz_start
            movl $-1, %edx
            

            loop_afisare_del:
                cmpl $1024, %ecx
                je verifica_delete

                movl (%esi, %ecx, 4), %ebx
                cmpl $0, %ebx
                jne verifica_del

                jmp continuare


                verifica_del:
                    cmpl $-1, %eax
                    je start_del

                verifica_poz:
                    cmpl $-1, %eax
                    jne verifica_id

                    verifica_id:
                        mov id, %ebp
                        cmp %ebp, %ebx
                        je pozitie_finala
                        jmp afisare_interval

                    pozitie_finala:
                        movl contor, %ebp
                        addl $1, %ebp
                        movl %ebp, contor
                        
                        jmp continuare


                start_del:
                    movl %ecx, poz_start
                    movl %ebx, id
                    movl %ecx, k
                    movl $1, %ecx
                    movl %ecx, contor
                    movl k, %ecx
                    movl $1, %eax
                    jmp continuare

                

                afisare_interval:
                    pushl %ecx
                    pushl %edx

                    movl contor, %eax
                    addl poz_start, %eax
                    subl $1, %eax
                    movl %eax, poz_final
                    
                    pushl poz_final
                    pushl poz_start
                    pushl id
                    pushl $formatPrintAdd
                    call printf
                    popl %ebx
                    popl %ebx
                    popl %ebx
                    popl %ebx

                    popl %edx
                    popl %ecx
                    
                    
                    movl $-1, %eax
                    movl %eax, poz_start
                    subl $1, %ecx
                    
                continuare:
                    inc %ecx
                    jmp loop_afisare_del


            verifica_delete:
                cmpl $-1, poz_start
                je delete_exit
                jmp afisare_interval
    delete_exit:
        movl i, %ecx
        subl $1, %ecx
        movl %ecx, i
        cmpl $0, %ecx
        jne program

        cmpl $0, %ecx
        je et_exit            
defrag:
    movl $0, %ecx
    movl (%esi, %ecx, 4), %eax
    movl $0, %edx
    for_defrag:
        cmp $1024, %ecx
        je for_0
        movl (%esi, %ecx, 4), %eax
        cmp $0, %eax
        jne adauga_j
        jmp continua_for_defrag
        adauga_j:
            mov %eax, (%esi, %edx, 4)
            addl $1, %edx

        continua_for_defrag:
            addl $1, %ecx
            jmp for_defrag

    for_0:
        cmpl $1024, %edx
        je afisare_defrag
        movl $0, %ebx
        movl %ebx, (%esi, %edx, 4)
        addl $1, %edx
        jmp for_0

        afisare_defrag:
        
            movl $0, %ecx
            movl $-1, %eax
            movl %eax, poz_start
            movl $-1, %edx
            

            loop_afisare_defrag:

                movl (%esi, %ecx, 4), %ebx
                cmpl $0, %ebx
                jne verifica_defrag

                jmp continuare_defrag


                verifica_defrag:
                    cmpl $-1, %eax
                    je start_defrag

                verifica_poz_defrag:
                    cmpl $-1, %eax
                    jne verifica_id_defrag

                    verifica_id_defrag:
                        movl id, %ebp
                        cmpl %ebp, %ebx
                        je pozitie_finala_defrag
                        jmp afisare_interval_defrag

                    pozitie_finala_defrag:
                        movl contor, %ebp
                        addl $1, %ebp
                        movl %ebp, contor
                        
                        jmp continuare_defrag


                start_defrag:
                    movl %ecx, poz_start
                    movl %ebx, id
                    movl %ecx, k
                    movl $1, %ecx
                    movl %ecx, contor
                    movl k, %ecx
                    movl $1, %eax
                    jmp continuare_defrag

                

                afisare_interval_defrag:
                    pushl %ecx
                    pushl %edx

                    movl contor, %eax
                    addl poz_start, %eax
                    subl $1, %eax
                    movl %eax, poz_final
                    
                    pushl poz_final
                    pushl poz_start
                    pushl id
                    pushl $formatPrintAdd
                    call printf
                    popl %ebx
                    popl %ebx
                    popl %ebx
                    popl %ebx

                    popl %edx
                    popl %ecx
                    
                    
                    movl $-1, %eax
                    movl %eax, poz_start
                    subl $1, %ecx
                    
                continuare_defrag:
                    inc %ecx
                    cmpl $1024, %ecx
                    jne loop_afisare_del
        

    exit_defrag:
    
        movl i, %ecx
        subl $1, %ecx
        movl %ecx, i
        cmpl $0, %ecx
        jne program

        cmpl $0, %ecx
        je et_exit

.global main
main:
    lea v, %esi

    mov $0, %ecx
vector_0:
    movl $0, (%esi, %ecx, 4)
    add $1, %ecx
    cmp $1024, %ecx
    jne vector_0
    movl $256, (%esi, %ecx, 4)

    pushl $x
    pushl $formatScan
    call scanf
    popl %ebx
    popl %ebx

    movl x, %ecx
    mov %ecx, i
    jmp program

    
et_exit:
    pushl $0
    call fflush
    popl %ebx
    movl $1, %eax
    movl $0, %ebx
    int $0x80