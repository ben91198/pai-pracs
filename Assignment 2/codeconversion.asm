.model small
.data
m1 db 10,13,"*****MENU*****"
   db 10,13,"1.bcd to hex conversion"
   db 10,13,"2.hex to bcd conversion"
   db 10,13,"3.exit"
   db 10,13,"Enter ur choice: $"
m2 db 10,13,"Enter 5 digit bcd no: $"
m3 db 10,13,"The equivalent hex no is: $"
m4 db 10,13,"Enter the 4 digit hex no: $"
m5 db 10,13,"The equivalent bcd no is: $"
m6 db 10,13,"Wrong choice !! enter again$"

.code
mov ax,@data
mov ds,ax

menu:lea dx,m1
     mov ah,09h
     int 21h
     
     mov ah,01h
     int 21h
     
     cmp al,31h
     jz x1          
     cmp al,32h
     jz x2     
     cmp al,33h
     jz x3
     jnz x4                 ;if wrong choice is entered

x1:call bth
   jmp menu

x2:call htb
   jmp menu

x3:call exit

x4:lea dx,m6
   mov ah,09h
   int 21h
   jmp menu




;;------------------BCD TO HEX CONVERSION-------------------------;;

bth proc near
      lea dx,m2
	 mov ah,09h
	 int 21h

mov bx,0000h           ;result in bx

mov ah,01h             ;accept 1st digit
int 21h
sub al,30h
mov ah,00h
mov cx,10000
mul cx
add bx,ax

mov ah,01h             ;accept 2nd digit
int 21h
sub al,30h
mov ah,00h
mov cx,1000
mul cx
add bx,ax

mov ah,01h             ;accept 3rd digit
int 21h
sub al,30h
mov ah,00h
mov cx,100
mul cx
add bx,ax

mov ah,01h             ;accept 4th digit
int 21h
sub al,30h
mov ah,00h
mov cx,10
mul cx
add bx,ax

mov ah,01h             ;accept 5th digit
int 21h
sub al,30h
mov ah,00h
add bx,ax

lea dx,m3              ;display 2nd string
mov ah,09h
int 21h
mov dl,bh                ;display 1st digit
and dl,0f0h
ror dl,04h
add dl,30h

cmp dl,39h               ;in case if char output
jbe sk1
add dl,07h

sk1:mov ah,02h
int 21h

mov dl,bh                ;display 2nd digit
and dl,0fh
add dl,30h
                        
cmp dl,39h               ;in case if char output
jbe sk2
add dl,07h

sk2:mov ah,02h
int 21h

mov dl,bl                ;display 3rd digit
and dl,0f0h
ror dl,04h
add dl,30h

cmp dl,39h               ;in case if char output
jbe sk3
add dl,07h

sk3:mov ah,02h
int 21h

mov dl,bl                ;display 4th digit
and dl,0fh
add dl,30h

cmp dl,39h               ;in case if char output
jbe sk4
add dl,07h

sk4:mov ah,02h
int 21h
ret
endp 

;;------------------HEX TO BCD CONVERSION-------------------------;;

htb proc near
    lea dx,m4
    mov ah,09h
    int 21h

mov ah,01h             ;accept msb of no in bh register(bx=bh+bl)
int 21h
sub al,30h
cmp al,09h
jbe next
sub al,07h

next:mov cl,04h        ;rotate 4 times
     ror al,cl
     mov bh,al

mov ah,01h             ;accept lsb of no in bh register
int 21h

sub al,30h
cmp al,09h
jbe next1
sub al,07h

next1:add bh,al

mov ah,01h             ;accept msb of no in bl register
int 21h

sub al,30h
cmp al,09h
jbe next2
sub al,07h

next2:mov cl,04h       ;rotate 4 times
     ror al,cl
     mov bl,al

mov ah,01h             ;accept lsb of no in bl register
int 21h
sub al,30h
cmp al,09h
jbe next3
sub al,07h

next3:add bl,al

lea dx,m5               ;display 2nd string
mov ah,09h
int 21h

mov dx,0000h            ;div no in by 10000
mov ax,bx
mov cx,10000
div cx
mov bx,dx
mov dl,al
add dl,30h

mov ah,02h              ;display the msb of result i.e remainder
int 21h

mov dx,0000h            ;div no in by 1000
mov ax,bx
mov cx,1000
div cx
mov bx,dx               ;copy the remainder in bx
mov dl,al
add dl,30h

mov ah,02h              ;display the 2nd digit of result i.e remainder
int 21h

mov dx,0000h            ;div no by 100
mov ax,bx
mov cx,100
div cx
mov bx,dx               ;copy the remainder in bx
mov dl,al
add dl,30h

mov ah,02h              ;display the 3rd digit of result i.e remainder
int 21h

mov dx,0000h            ;div no by 10
mov ax,bx
mov cx,10
div cx
mov bx,dx               ;copy the remainder in bx
mov dl,al
add dl,30h

mov ah,02h              ;display the 4th digit of result i.e remainder
int 21h

mov dx,0000h            ;display the remainder
mov ax,bx
mov bx,dx               ;copy the remainder in bx
mov dl,al
add dl,30h

mov ah,02h              ;display the 5th digit of result i.e remainder
int 21h
ret
endp
               ;;-------------------EXIT------------------------;;
exit proc near
     mov ah,4ch
     int 21h
endp        
end

