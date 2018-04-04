.model small

.data
msg1 db "Array Addition is:$"
arr db 1h,2h,3h,4h,5h

.code
mov ax,@data
mov ds,ax

mov bl,00
mov ch,05
lea si,arr
back:adc bl,[si]   
inc si
dec ch
jnz back

lea dx,msg1
mov ah,09h
int 21h

mov bh,bl
mov cl,04h
and bl,0f0h
rol bl,cl
cmp bl,09h
jbe next2
add bl,07h
next2:add bl,30h

mov dl,bl
mov ah,02h
int 21h

and bh,0fh              
cmp bh,09h
jbe next3
add bh,07h
next3:
add bh,30h

mov dl,bh
mov ah,02h
int 21h
        
mov ah,4ch
int 21h
end
              
