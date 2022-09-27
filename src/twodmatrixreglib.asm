    include keolib.asm

    ;DEVICE ZXSPECTRUM128
;; start of where to put the data ;;


;; a1 = b, a2 = c, a3 = d, a4 = e h = x, l = y
;;change ALL ld label, a to ld hl, label, ld (hl), a
multiplier EQU $d000
numerator EQU $d001
denominator EQU $d002
xTwo EQU $d003

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
    call getSecondSolDen
    ;call getSolutions
    ret

;;bc = hl/e
;;hl = b * c
;; a1 = b, a2 = c, a3 = d, a4 = e h = x, l = y
getMultiplier:
    ld h,d
    ld e,b
    call div
    ld hl,multiplier  ;load multiplier address
    ld a,c             ;load mutliple into a (should be stored in c)
    ld (hl),a           ;store at address
    ret 
getSecondSolNum:        ;x2 numerator
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
    call c, negativeHandler  ;gets absolute value of negative if negative was created
    ld hl,numerator
    ld (hl),a       ;store in numerator    ;NEED to HANDLE NEGATIVES for now just reversed
    ret
getSecondSolDen:            ;x2 denominator
    ld hl, multiplier       ;lets get M*a2 first
    ld a,(hl)
    exx
    push bc
    exx
    pop bc                  ;a2 now in b
    ld c,a
    call slow_mult          ;hl now stores m*a2
    exx
    push de
    exx 
    pop de                  ;e now has a4
    ld a,e
    ld b,l
    sub b
    call c, negativeHandler  ;gets absolute value of negative if negative was created
    ld hl,denominator
    ld (hl),a       ;store in numerator    ;NEED to HANDLE NEGATIVES for now just reversed
    ret
    ;;bc = hl/e
getSecondSol:
    ld hl,denominator
    ld a,(hl)
    ld e,a
    ld hl,numerator
    ld a,(hl)
    ld l,a
    call div
    ld hl,xTwo
    ld a,b
    ld (hl),a
    ret
    
negativeHandler:
    xor $ff
    inc a           ;weird, may need to change
    ret