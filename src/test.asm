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
    ld h,30
    ld l,20
    ; answers should both be 1 if hl = $0302
    ; multiplier should be 1
    call loadMatrix
    call solveMatrix
    ld hl,xTwo
    ld a,(hl)
    jp loop
    ret

loop:
    nop
    jp loop
    ret

    include twodmatrixreglib.asm
    SAVESNA"test.sna", start