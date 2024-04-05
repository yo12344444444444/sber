IDEAL
MODEL huge
STACK 100h
DATASEG
filehandle dw ?
Filename db "file.txt",0
ErrorMsg db "error"
Buffer dw ?

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
proc ReadFile
; Read file
    mov ah,3Fh
    mov bx, [filehandle]
    mov cx,2
    mov dx,offset Buffer
    int 21h
    ret
endp ReadFile 
start:
	mov ax, @data
	mov ds, ax
    call openfile
    call readfile
    
; --------------------------
; Your code here
; --------------------------
	
exit:
	mov ax, 4c00h
	int 21h
END start