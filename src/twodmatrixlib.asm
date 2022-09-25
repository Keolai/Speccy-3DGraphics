    include keolib.asm

    DEVICE ZXSPECTRUM128
;; start of where to put the data ;;
adrStart EQU #d000

;; constants ;;
a1 EQU #d000
a2 EQU #d001
a3 EQU adrStart + #02
a4 EQU adrStart + #03
;; coordinates ;;
cX EQU adrStart + #04
cY EQU adrStart + #05
;; preserve coordinates;;
pX EQU adrStart + #06
pY EQU adrStart + #07

;; solutions ;;
sX1 EQU adrStart + #08
sX2 EQU adrStart + #09

;; constants needed ;;
Mult EQU adrStart + #0a


;; a1 = b, a2 = c, a3 = d, a4 = e h = x, l = y
;;change ALL ld label, a to ld hl, label, ld (hl), a
loadMatrix:
    push af
    ld a, b
   ; ld h,$d0
    ld hl,#d000
    ld (hl), a
    ld a, c
    ld hl,#d001
    ld (hl), a
    ret     ;temp
    ld a, d
    ld l,a3
    ld (hl), a
    ld a, e
    ld l,a4
    ld (hl), a
    ld a,h
    ld l,cX
    ld (hl), a
    ld l,pX
    ld (hl), a
    ld a, l
    ld l,cY
    ld (hl), a
    ld l,pY
    ld (hl),a
    pop af
    ret

solveMatrix:
    call getMultiplier
    call getSolutions
    ret

;;bc = hl/e
;;hl = b * c
getMultiplier:
    push af
    ld a, #d000
    ld e,a
    ld h,$d0
    ld l, a3
    call div
    ld a,c
    ld l,Mult
    ld (hl),a
    ld b, a
    ld a, #d001
    ld c, a
    call slow_mult
    ld a, a4
    sub a, l        ;;need to handle possible negatives
    ld l,a4
    ld (hl), a
    ld a, cX
    ld b, a
    ld a, Mult
    ld c, a
    call slow_mult
    ld a, cY
    sub a, l
    ld l,cY
    ld (hl), a
    pop af
    ret

;; fix this
getSolutions:
    push af
    ld a,cY
    ld (hl),a
    ld a, a4
    ld e,a
    call div
    ld a, c
    ld h,$d0
    ld l,sX2
    ld (hl),a
    ld b, #d001
    call slow_mult
    push hl
    ld l,cX
    ld h,$d0
    ld a,(hl)
    pop hl
    sub l       ;;fix
    ld (hl),a
    ld h,$d0
    ld hl,#d000
    ld a,(hl)
    ld e,a
    call div
    ld a,c
    ld h,$d0
    ld l,sX1
    ld (hl),a
    pop af
    ret