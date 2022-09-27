    DEVICE ZXSPECTRUM128
;; meant to test compilation ;;
   // include keolib.asm

    org $8000

start:  
    ld hl,$ff58
    ld sp,hl            ;THIS IS NEEDED !
    ld b,$01
    ld c,$02
    ld d,$01
    ld e,$01
    ld h,$05
    ld l,$03
    ; answers should both be 1 if hl = $32
    ; multiplier should be 2
    call loadMatrix
    call solveMatrix
    ;ld hl,$d008
    ;ld a,(hl)
    ;ld b,a
    ;ld hl,$d009
    ;ld a,(hl)
    jp loop
    ret

loop:
    nop
    jp loop
    ret

    include twodmatrixreglib.asm
    SAVESNA"test.sna", start