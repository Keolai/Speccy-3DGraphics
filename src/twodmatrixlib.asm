    include keolib.asm

    DEVICE ZXSPECTRUM128
;; start of where to put the data ;;
adrStart EQU #d000

;; constants ;;
a1 EQU adrStart
a2 EQU adrStart + #01
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
    ld a1, a
    ld a, c
    ld a2, a
    ld a, d
    ld a3, a
    ld a, e
    ld a4, a
    ld a,h
    ld cX, a
    ld pX, a
    ld a, l
    ld cY, a
    ld pY, a
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
    ld a, a1
    ld e,a
    ld hl, a3
    call div
    ld a,c
    ld Mult,a
    ld b, a
    ld a, a2
    ld c, a
    call slow_mult
    ld a, a4
    sub a, l        ;;need to handle possible negatives
    ld a4, a
    ld a, cX
    ld b, a
    ld a, Mult
    ld c, a
    call slow_mult
    ld a, cY
    sub a, l
    ld cY, a
    pop af
    ret


getSolutions:
    push af
    ld a,cY
    ld hl,a
    ld a, a4
    ld e,a
    call div
    ld a, c
    ;;ld a, sX2
    ld b, a2
    call slow_mult
    ld a, cX
    sub a, hl
    ld hl,a
    ld a,a1
    ld e,a
    call div
    ld a,c
    ld sX1,a
    pop af
    ret