;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;Keolai's common subroutines;;2021;;For the Speccy;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; include keolib.asm ;;


short_wait:
    ld a,$00
    ld b,$00
    ld c,$00
SWloop:
    inc a
    cp $ff
    jp z,SWloop2
    jp SWloop
SWloop2:
    ld a,b
    cp $02
    ret z
    ld b,a
    inc b
    ld a,$00
    jp SWloop 
    
      
wait:
    ld a,$00
    ld b,$00
    ld c,$00
Wloop:
    inc a
    cp $ff
    jp z,Wloop2
    jp Wloop
Wloop2:
    ld a,b
    cp $ff
    jp z,Wloop3
    ld b,a
    inc b
    ld a,$00
    jp Wloop 
Wloop3:                  ;very long
    ld a,c
    cp $07               ;change this to manipulate wait time
    ret z
    ld c,a
    inc c
    ld b,$00
    jp Wloop
    
    
print_char:
    push hl
    push bc
    push de
    push af
    ld a, $02
    call $1601
    pop af
    push af
    rst $0010
    pop af
    pop de
    pop bc
    pop hl
    ret
    
print_string:
    ld a,(hl)
    cp 255
    ret z
    inc hl
    call print_char
    jr print_string
    
convert_xy:             ;convert x and y locations to bitmap memory locations, x sits in b and y in c
    ld a,c              ;y first
    and %00111000       ;look at y3-y5 first
    and a               ;clear carry flag
    rla                 ;move over to end of low byte
    rla
    ld l,a              ;move results to low byte storage register
    ld a,c              ;look at the rest of y
    and %11000000       ;look at y7 and 6
    and a
    rra                 ;move over
    rra
    rra 
    ld d,a              ;temporary storage
    ld a,c
    and %00000111       ;remask
    or %01000000        ;base address ($4000)
    or d                ;done
    ld h,a              ;move to results register
    ld a,b              ;x now
    and %00011111
    or l
    ld l,a              ;store result in l
    ret

quick_color:
    ld iy, $5800
    ld d, $00           ;low end of color attribute
    ld e, $00           ;high end, compare to $03    
qcolor_screen:
    ld a,b              ;B is used to select color
    ld (iy), a
    inc iy
    inc d
    ld a, $ff
    cp d
    jp z, qcolor_end
    jp qcolor_screen
qcolor_end:
    ld a, $03
    cp e
    ret z
    inc e
    ld d, $00
    jp qcolor_screen    
    
load_picture:           ; load data in ix, load bc with $0000
    call convert_xy
    ld d,(ix)
    ld a, (hl)
    or d
    ld d,a
    ld (hl), d
    inc b
    inc ix
    ld a,b
    cp $21
    jp z, inc_y
    jp load_picture
    
inc_y:
    ld a,c
    cp $bd
    ret z
    inc c
    ld b, $01
    jp load_picture

;;hl = b * c
slow_mult:
    ld hl,0
    ld a,b
    or a
    ret z
    ld d,0
    ld e,c
slow_mult_loop:
    add hl,de
    djnz slow_mult_loop
    ret 

;L is (0-255), A is (0-63), BC is result
fast_mult:
    or a, #40
    ld h,a
    ld c,(hl)
    add a,#40
    ld h,a
    ld b,(hl)
    ret

;;bc = hl/e
div:
    ld a,e
    or a
    ret z
    ld bc,-1
    ld d,a
    ld d,0
div_loop:
    sbc hl,de
    inc bc
    jr nc, div_loop
    ret
