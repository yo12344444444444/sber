IDEAL
MODEL huge
STACK 100h
DATASEG
    enemyMidelCord dw 1, 160, 100 
    foodP dw 0, 5, 5, 0, 10
         dw 5, 5, 5, 5, 10
         dw 5, 5, 5, 5, 10
         dw 0, 5, 5, 0, 11
    inputSize dw 2
    num dw ?
    hiddenSize dw 3
    outputSiz dw 5
    filehandle dw ?
    Filename db "file.txt",0
    ErrorMsg db "error"
SEGMENT inputSeg
ENDS inputSeg
SEGMENT hiddenSeg
    
ENDS hiddenSeg
SEGMENT outputSeg
    
ENDS outputSeg
CODESEG
proc OpenFile
    ; Open file
    mov ah, 3Dh
    xor al, al
    lea dx, [filename]
    int 21h
    jc openerror
    mov [filehandle], ax
    ret
    openerror:
        mov dx, offset ErrorMsg
        mov ah, 9h
        int 21h
        ret
endp OpenFile
proc drowPlayer
    push ax
    push cx
    push di
    mov di, 100 
    mov cx ,0
    mov ax , 0
    row:
        inc cx
        add di, 320
        sub di , ax
        mov ax ,0
        colom:
            inc ax
            inc di
            mov [es:di] , 2
            cmp ax , 4
            jnz colom
        cmp cx , 4
        jnz row
    pop di
    pop cx
    pop ax
    ret 
endp drowPlayer
proc drowFood
    push bx
    push cx
    push di
    push ax
    mov di , 1000
    mov cx, 0
    mov bx , offset foodP
    looop:
        cmp [bx] , 10
        jz nextline
        cmp [bx] , 11
        jz ende
        inc di
        inc bx
        inc cx
        mov ax , [bx]
        mov [es:di] , ax
        jmp looop
    nextLine:
        mov ax, 320
        sub ax , cx
        add di, ax
        inc bx
        mov cx ,0
        jmp looop
    ende:
        pop ax
        pop di
        pop cx
        pop bx
        ret
endp drowFood
proc ReadFile
    push ax
    push cx
    push cx
    mov ah,3Fh
    mov bx, [offset filehandle]
    mov cx,1
    mov dx,offset num
    int 21h
    ret
    pop bx
    pop cx
    pop ax
endp ReadFile 
proc readNN
    push si
    push bx
    push cx
    push ax
    push dx
    mov cx , [offset hiddensize]
    hiddenLoop:
        c
    pop dx
    pop ax
    pop cx
    pop bx
    pop si
    ret
endp readNN
start:
    mov ax, @data
    mov ds, ax
    mov ax, 13h
    int 10h
    mov ax, 0A000h 
    mov es, ax
    call openfile
    ;call drowPlayer
    call readnn 
inf:
    jmp inf

exit:
    mov ax, 4c00h
    int 21h
END start
