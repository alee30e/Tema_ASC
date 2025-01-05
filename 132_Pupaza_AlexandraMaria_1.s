.section .note.GNU-stack,"",@progbits
.data
    x: .space 4
    y: .space 4
    i: .space 4
    j: .space 4
    id: .space 4
    valc: .space 4
    indice_coloana_curenta: .space 4
    lungime: .space 4
    index_coloana_k: .space 4
    gasit: .space 4
    r: .space 4
    gasit_spatiu: .space 4
    spl: .space 4
    linie_sus: .space 4
    eldif: .space 4
    k: .space 4
    valoare: .space 4
    contor: .space 4
    poz_final: .space 4
    poz_disp: .space 4
    m: .space 4
    start: .space 4
    linie_mai_sus: .space 4
    n: .space 4
    index_linie: .space 4
    index_coloana: .space 4
    poz_start: .space 4
    dim: .space 4
    desc: .space 4
    blocuri_necesare: .space 4
    start_linie: .space 4
    start_coloana: .space 4
    stop_linie: .space 4
    stop_coloana: .space 4
    operatie: .space 4
    zero: .long 0
    v: .space 1048576
    nrfisiere: .space 4
    formatNuAdd: .asciz "%d\n"
    formatScan: .asciz "%d"
    formatPrintAdd: .asciz "%d: ((%d, %d), (%d, %d))\n"
    formatPrintGet: .asciz "((%d, %d), (%d, %d))\n"
    formatNuExista: .asciz "%d: ((0, 0), (0, 0))\n"
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


    cmp $1, %eax
    je add

    
    cmp $2, %eax
    je get

    cmp $3, %eax
    je delete


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
inceput:
        movl dim, %eax
        xorl %edx, %edx
        movl $8, %ebx
        divl %ebx
        cmp $0, %edx
        je fara_rotunjire
        addl $1, %eax
       
fara_rotunjire:
        xorl %edx, %edx
        movl %eax, blocuri_necesare
        movl $0, start_linie
        movl $0, stop_linie
        movl $0, stop_coloana
        movl $0, start_coloana
        movl $0, index_linie
        movl $0, index_coloana
        cmp $1024, %eax
        jg printareNuAdd
        for_vector:
            movl $0, %ecx
            movl $0, %ebx
            movl $0, %ebx

        for_parcurgere_m:
        
            movl $0, index_coloana

            movl index_linie, %eax
            movl $1024, %edx
            mul %edx
            addl index_coloana, %eax
            movl %eax, %ecx
        
            cmp $1048576, %ecx
            je printareNuAdd
            movl $0, %ebx

            for_parcurgere_n:


            cmpl $1024, index_coloana
            je cauta_urmatoarea_linie

            movl index_linie, %eax
            movl $1024, %edx
            mul %edx
            addl index_coloana, %eax
            movl %eax, %ecx

                movl (%esi, %ecx, 4), %eax
                cmpl $0, %eax
                je adauga_spatiu

                cmpl $0, %eax
                jne spatiu_zero

                   adauga_spatiu:
                        addl $1, %ebx
                        
                        movl %ecx, stop_coloana
                        cmpl blocuri_necesare, %ebx
                        je adauga_matrice

                        cmpl blocuri_necesare, %ebx
                        jl avanseaza

                    spatiu_zero:
                        movl $0, %ebx

                        avanseaza:
                            addl $1, index_coloana
                            
                            jmp for_parcurgere_n

adauga_matrice:

    movl stop_coloana, %eax
    subl %ebx, %eax
    addl $1, %eax
    movl %eax, poz_start
    pushl poz_start

    movl index_coloana, %eax
    subl %ebx, %eax
    addl $1, %eax
    movl %eax, start_coloana
    popl %eax



for_dimensiune:
    
    mov desc, %edi
    mov %edi, (%esi, %eax, 4)

    cmp %eax, %ecx
    je PrintareAdd

    add $1, %eax
    jmp for_dimensiune


PrintareAdd:
    
    push index_coloana
    push index_linie
    push start_coloana
    push index_linie
    push desc
    push $formatPrintAdd
    call printf
    pop %eax
    pop %eax
    pop %eax
    pop %eax
    pop %eax
    pop %eax

    jmp exit_add

cauta_urmatoarea_linie:
    addl $1, index_linie
    jmp for_parcurgere_m

printareNuAdd:
pushl zero
pushl zero
pushl zero
pushl zero
push desc
push $formatPrintAdd
call printf
popl %edx
popl %edx
popl %edx
popl %edx
 pop %edx
 pop %edx

 jmp exit_add

exit_add:
    mov j, %ecx
    sub $1, %ecx
    mov %ecx, j
    cmp $0, %ecx
    jne for_nrfisiere

        mov i, %ecx
        sub $1, %ecx
        mov %ecx, i
        cmp $0, %ecx
        jne program

        cmp $0, %ecx
        je et_exit
      

get:
    pushl %eax
    pushl $valoare
    pushl $formatScan
    call scanf
    popl %ebx
    popl %ebx
    movl $0, contor
        movl $0, start_linie
        movl $0, stop_linie
        movl $0, stop_coloana
        movl $0, start_coloana
        movl $0, index_linie
        movl $0, index_coloana
    movl valoare, %eax
    movl $0, %ecx
    movl $-1, %ebx
    movl %ebx, poz_start

    for_get_m:
            
            movl index_linie, %eax
            movl $1024, %edx
            mul %edx
            movl $0, index_coloana
            addl index_coloana, %eax
            movl %eax, %ecx
        
            cmpl $256, index_linie
            je NuExista
            movl $-1, %ebx

            for_get_n:

                cmpl $1024, index_coloana
                je verifica_ultimul_numar
                movl index_linie, %eax
                movl $1024, %edx
                mul %edx
                addl index_coloana, %eax
                movl %eax, %ecx

        movl valoare, %eax

        cmp %eax, (%esi, %ecx, 4)
        je verifica_start

        jmp verifica_nuEgal

        verifica_start:
            cmp $-1, %ebx
            je pozitie_start
            jmp verificaEgal

        verificaEgal:
            movl index_coloana, %edi
            addl $1, contor
            movl %edi, stop_coloana
            jmp cauta_urmatorul_element


        verifica_nuEgal:
            cmp $-1, %ebx
            jne Exista
            jmp cauta_urmatorul_element

        pozitie_start:
            movl index_coloana, %ebx
            movl $1, contor
            movl %ebx, start_coloana

        cauta_urmatorul_element:
            addl $1, index_coloana
            jmp for_get_n

        verifica_ultimul_numar:
            cmp $-1, %ebx
            je cauta_urmatoarea_linie_get

     Exista:

        pop %eax
        cmp $3, %eax
        je continua_for_delete

        pushl stop_coloana
        pushl index_linie
        pushl start_coloana
        pushl index_linie
        pushl $formatPrintGet
        call printf
        popl %ebx
        popl %ebx
        popl %ebx
        popl %ebx 
        popl %ebx
        jmp exit     

cauta_urmatoarea_linie_get:
    addl $1, index_linie
    movl $0, index_coloana
    jmp for_get_m   

    NuExista:

        pop %eax
        cmp $3, %eax
        je continua_for_delete

        pushl zero
        pushl zero
        pushl zero
        pushl zero
        pushl $formatPrintGet
        call printf
        pop %ebx
        pop %ebx
        pop %ebx
        pop %ebx
        popl %ebx
        popl %ebx
        jmp exit

     
        
exit:
        movl i, %ecx
        subl $1, %ecx
        movl %ecx, i
        cmp $0, %ecx
        jne program

        cmp $0, %ecx
        je et_exit  


delete:
    jmp get

     continua_for_delete:
        mov poz_start, %ecx
        mov poz_final, %edx
        
        

        mov poz_start, %ecx
        mov poz_final, %edx

            movl index_linie, %eax
            movl $1024, %edx
            mul %edx
            addl start_coloana, %eax
            mov %eax, poz_start
            
            movl index_linie, %eax
            movl $1024, %edx
            mul %edx
            addl stop_coloana, %eax
            movl %eax, poz_final

            mov poz_start, %eax
#jmp exit_delete

        mov poz_start, %ecx
        mov poz_final, %edx
        
        for_delete:

            mov $0, %eax
            mov %eax, (%esi, %ecx, 4)
            cmp %ecx, %edx
            je afisare_delete
            add $1, %ecx
            jmp for_delete

afisare_delete:
    movl $0, index_linie
    movl $0, start_linie
        movl $0, stop_linie
        movl $0, stop_coloana
        movl $0, start_coloana
        movl $0, index_linie
        movl $0, index_coloana
    movl $0, %ecx
    movl $-1, %ebx
    movl %ebx, poz_start

    for_delete_m:
            
            movl index_linie, %eax
            movl $1024, %edx
            mul %edx
            movl $0, index_coloana
            addl index_coloana, %eax
            movl %eax, %ecx
        
            cmpl $256, index_linie
            je exit_delete
            movl $-1, %ebx
            movl $0, id

            for_delete_n:

                cmpl $1024, index_coloana
                je verifica_ultimul_numar_delete
                movl index_linie, %eax
                movl $1024, %edx
                mul %edx
                addl index_coloana, %eax
                movl %eax, %ecx

        cmpl $0, (%esi, %ecx, 4)
        jne verifica_start_delete

        jmp verifica_nuEgal_delete

        verifica_start_delete:
            cmp $-1, %ebx
            je pozitie_start_delete
            jmp verificaEgal_delete

        verificaEgal_delete:
        mov id, %edi
        cmp %edi, (%esi, %ecx, 4)
        jne restart
            movl index_coloana, %edi
            addl $1, contor
            movl %edi, stop_coloana
            jmp cauta_urmatorul_element_delete

        restart:
            movl $-1, poz_start
            mov $-1, %ebx
            jmp ExistaDelete


        verifica_nuEgal_delete:
            cmp $-1, %ebx
            jne ExistaDelete
            jmp cauta_urmatorul_element_delete

        pozitie_start_delete:
            movl index_coloana, %ebx
            movl $1, contor
            movl (%esi, %ecx, 4), %edi
            mov %edi, id
            movl %ebx, start_coloana

        cauta_urmatorul_element_delete:
            addl $1, index_coloana
            jmp for_delete_n

        verifica_ultimul_numar_delete:
            cmp $-1, %ebx
            je cauta_urmatoarea_linie_delete
            jmp ExistaDelete

        cauta_urmatorul_element_linie:
            movl $0, id
            movl $-1, %ebx
            subl $1, index_coloana
            cmpl $1024, index_coloana
            je cauta_urmatoarea_linie_delete
            jmp cauta_urmatorul_element_delete
     ExistaDelete:

        pushl stop_coloana
        pushl index_linie
        pushl start_coloana
        pushl index_linie
        pushl id
        pushl $formatPrintAdd
        call printf
        popl %ebx
        popl %ebx
        popl %ebx
        popl %ebx
        popl %ebx 
        popl %ebx

    next:
        jmp cauta_urmatorul_element_linie 

cauta_urmatoarea_linie_delete:
    addl $1, index_linie
    movl $0, index_coloana
    jmp for_delete_m   

exit_delete:
        movl i, %ecx
        subl $1, %ecx
        movl %ecx, i
        cmp $0, %ecx
        jne program

        cmp $0, %ecx
        je et_exit

.global main
main:
    lea v, %esi
    pushl $x
    push $formatScan
    call scanf
    pop %ebx
    pop %ebx

    movl x, %ecx
    mov %ecx, i
    jmp program

    
et_exit:
    push $0
    call fflush
    pop %ebx
    mov $1, %eax
    mov $0, %ebx
    int $0x80