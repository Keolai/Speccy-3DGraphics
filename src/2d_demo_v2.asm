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
  ;;  ld (hl),a
    ;;call start_block
    ;;call wait
    call rotate
    ;;ld a,$38
    ;;call wait
    ;;ld (hl),a
    jp loop
    ret
start_block:
    ld hl,S1
    ld a, #02
    ld a,(hl)
    inc hl
    ld a,(hl)       ;;(2,2)
    call place_square
    ret

;; a1 = b, a2 = c, a3 = d, a4 = e h = x, l = y
rotate:
    ; ld bc,$01ff
    ; ld de,$0101
    ; ld hl,$20
    ; call loadMatrix
    ; call solveMatrix
    ; call place_square

    ld bc,$01ff
    ld de,$0101
    ld hl,$0202       ;;0,6
    call loadMatrix
    call solveMatrix
    call place_square

    ld bc,$01ff
    ld de,$0101
    ld hl,$40
    call loadMatrix
    call solveMatrix
    call place_square

    ld bc,$01ff
    ld de,$0101
    ld hl,$42
    call loadMatrix
    call solveMatrix
    call place_square
    ret

place_square:       ;; moves square accross screen     
    ld hl,S2
    ld a,(hl)    ;load Y 
    and $1F
    ld hl,SCREEN_COLOR
    ld bc,$20
    call y_cord_loop
    push hl
    ld hl,S1
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


    include twoDMult.asm
    SAVESNA"demo2.sna", start