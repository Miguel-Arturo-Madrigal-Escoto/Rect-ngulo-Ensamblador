.model small
.data
            
    xh1 dw ?
    yh1 dw ?
    
    xh2 dw ?
    yh2 dw ?
    
    xv1 dw ?
    yv1 dw ?
    
    i db 0 
       
.code

pixel macro x,y,color
    mov cx,x            ; cx = x 

    mov dx,y            ; dx = y

    mov al,color        ; al = color
    mov ah,0Ch          ; ah = 0Ch
    
    int 10h
    
endm    

inicio:
    lea ax,data
    mov ds,ax
     
    ;Establecer el modo de video
    mov ah,0       ; ah = 0
    mov al,13h     ; al = 13h
    int 10h    
    
    ;Activar el mouse
    mov ax, 0      ; ax = 0
    int 33h
    
mouse:      
    mov ax,3
    int 33h
    shr cx,1       ; x/2 -> en este modo el valor de x es doble 
    
    test bx,1      ; click izquierdo -> 1
    jz mouse       ; si no es click izquierdo
    
    
    ;primer linea horizontal
    mov xh1,cx     ; xh1 = cx
    mov yh1,dx     ; yh1 = dx
    
    ;primer linea vertical
    mov xv1,cx     ; xv1 = cx
    mov yv1,dx     ; yv1 = dx
    
    ;segunda linea horizontal
    mov xh2,cx     ; xh2 = cx
    mov yh2,dx     ; yh2 = dx
    sub yh2,50     ; yh2 = yh2 - 50
    
    ;segunda linea vertical
    ; lv2 (toma los valores de xh2, yh2) 
      
       
lh1:           
    pixel xh1,yh1,0Ah
    
    inc i         ; i = i + 1 
    inc xh1       ; xh1 = xh1 + 1
    cmp i,100     ; flags = bx - 100 
    
    jne lh1       ; jnz lh1 
      
    mov i,0
    
lv1:           
    pixel xv1,yv1,0Bh
    
    inc i         ; i = i + 1 
    dec yv1       ; yv1 = yv1 - 1
    cmp i,50      ; flags = bx - 50 
    
    jne lv1       ; jnz lh1 
    
    
    mov i,0
          
lh2:
    pixel xh2,yh2,0Ch
    
    
    inc i         ; i = i + 1
    inc xh2       ; xh2 = xh2 +1
    cmp i,100     ; flags = bx - 100 
    
    jne lh2       ; jnz lh2   
    
    
    mov i,0
    
lv2:
    pixel xh2,yh2,0Dh
    
    inc i         ; i = i + 1
    inc yh2       ; yh2 = yh2 + 1
    cmp i,50      ; flags = bx - 50
    
    jne lv2       ; jnz lv2
      
    mov ah,4Ch    ; ah = 04Ch
    int 21h
    
    ret



