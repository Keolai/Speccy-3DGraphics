    DEVICE ZXSPECTRUM128
;; meant to test compilation ;;
   // include keolib.asm

SCREEN_COLOR EQU $5800

    org $8000

start:  
    ld hl,$ff58
    ld sp,hl            ;THIS IS NEEDED !
    ld hl,SCREEN_COLOR
    ld a,$00
    ;ld (hl),a
   ; call wait
    ld a,$38
    ld (hl),a
    call shear
    call wait
    ld (hl),a
    jp loop
    ret


translation:
    ld b,$01
    ld c,$00        ; shearing factor
    ld d,$00
    ld e,$01
    ld h,5
    ld l,5
    call matrix
    call place_square
    ret
shear:                  ; fix this 
    ld b,$02
    ld c,$01
    ld d,$00
    ld e,$02
    ld h,2
    ld l,0
    call matrix
    call place_square
    ld hl,$24
    call matrix
    call place_square
    ld hl,$60
    call matrix
    call place_square
    ld hl,$64
    call matrix
    call place_square
    ld hl,xTwo
    ld a,(hl)
    ld b,a
    inc hl
    ld a,(hl)   ;;load xOne
    jp loop
    ret
place_square:       ;; moves square accross screen     
    ld hl,xTwo
    ld a,(hl)    ;load Y 
    and $1F
    ld hl,SCREEN_COLOR
    ld bc,$20
    call y_cord_loop
    push hl
    ld hl,xOne
    ld a,(hl)
    pop hl
    and $1F
    call x_cord_loop    ;hl now has correct address
    ld (hl),$00
    ret
y_cord_loop:
    cp $00
    ret z       ;stop if 0
    add hl,bc
    dec a
    jp y_cord_loop
x_cord_loop:
    cp $00
    ret z
    inc hl
    dec a
    jp x_cord_loop
matrix:
    call loadMatrix
    call solveMatrix
    ret
loop:
    nop
    jp loop
    ret

    include twodmatrixreglib.asm
    SAVESNA"demo.sna", start