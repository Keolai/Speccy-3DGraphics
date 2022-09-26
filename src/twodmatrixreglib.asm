    include keolib.asm

    ;DEVICE ZXSPECTRUM128
;; start of where to put the data ;;


;; a1 = b, a2 = c, a3 = d, a4 = e h = x, l = y
;;change ALL ld label, a to ld hl, label, ld (hl), a
multiplier EQU $d000

loadMatrix:
    push af
    push bc
    push de
    push hl
    exx             ;move contents of matrix into shadow registers
    pop hl
    pop de
    pop bc
    pop af
    ret
    

solveMatrix:
    call getMultiplier
    call getSecondSolNum
    ;call getSolutions
    ret

;;bc = hl/e
;;hl = b * c
;; a1 = b, a2 = c, a3 = d, a4 = e h = x, l = y
getMultiplier:
   ; push af
    ld h,d
    ld e,b
    call div
    ld hl,multiplier  ;load multiplier address
    ld a,c             ;load mutliple into a (should be stored in c)
    ld (hl),a           ;store at address
   ; pop af
    ret 
getSecondSolNum:
    ld hl,multiplier
    ld a,(hl)
    exx
    push hl         ;restore old hl, (xy)
    exx 
    pop hl
    ld b,a
    ld c,l
    push hl         ;load current hl values into stack
    call slow_mult  ;hl now stores MX
    ld a,l
    ld b,a
    pop hl
    ld a,l          ;move Y into a
    sub b           ;now a = Y-MX
    call c,negativeHandler  ;check flag
    ld hl,numerator
    ld (hl),a       ;store in numerator    ;NEED to HANDLE NEGATIVES for now just reversed
    ret
negativeHandler:
    xor $ff
    ret

numerator: db $00
denominator: db $00