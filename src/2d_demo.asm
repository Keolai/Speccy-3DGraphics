    DEVICE ZXSPECTRUM128
;; meant to test compilation ;;
   // include keolib.asm

SCREEN_COLOR EQU $5800

    org $8000

start:  
    ld hl,$ff58
    ld sp,hl            ;THIS IS NEEDED !
    ; answers should both be 1 if hl = $0302
    ; multiplier should be 1
    ld hl,SCREEN_COLOR
    ld a,$00
    ld (hl),a
    call wait
    ld a,$38
    ld (hl),a
    call translation
    call wait
    ld (hl),a
    jp loop
    ret
translation:
    ld b,$01
    ld c,$00
    ld d,$00
    ld e,$01
    ld h,10
    ld l,0
    call matrix
    call place_square
    ret


place_square:       ;; moves square accross screen     
    ld hl,xTwo
    ld a,(hl)    ;load Y
    ld hl,SCREEN_COLOR
    ld bc,#20
    call y_cord_loop
    ld hl,xOne
    ld a,(hl)
    ld hl,SCREEN_COLOR
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