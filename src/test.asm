    DEVICE ZXSPECTRUM128
;; meant to test compilation ;;
    
    include twodmatrixreglib.asm
   // include keolib.asm

    org $8000

start:
    ld b,#01
    ld c,#02
    ld d,#01
    ld e,#01
    ld h,#03
    ld l,#02
    ; answers should both be 1
    ; multiplier should be 2
    call loadMatrix
   ; call checkLoad
   ;; call solveMatrix
    ;ld hl,$d008
    ;ld a,(hl)
    ;ld b,a
    ;ld hl,$d009
    ;ld a,(hl)
    jp loop
    ret

checkLoad:
    ld hl,$d000
    ld a,(hl)
    ld b,a
    ld hl,$d001
    ld a,(hl)
    jp loop
    ret
loop:
   ;nop
    jp loop

    SAVESNA"test.sna", start