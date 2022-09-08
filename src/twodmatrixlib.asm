include keolib.asm

;; start of where to put the data ;;
adrStart = #d000

;; constants ;;
a1 = adrStart
a2 = adrStart + #01
a3 = adrStart + #02
a4 = adrStart + #03
;; coordinates ;;
cX = adrStart + #04
cY = adrStart + #05
;; preserve coordinates;;
pX = adrStart + #06
pY = adrStart + #07

;; solutions ;;
sX1 = adrStart + #08
sX2 = adrStart + #09

;; constants needed ;;
Mult = adrStart + #0a


;; a1 = b, a2 = c, a3 = d, a4 = e h = x, l = y
loadMatrix:
push a 
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
pop a
ret

solveMatrix:
call getMultiplier
call getSolutions
ret

;;bc = hl/e
;;hl = b * c
getMultiplier:
push a
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
pop a
ret


getSolutions:
push a
ld a,cY
ld hl,a
ld a, a4
ld e,a
call div
ld a, c
ld sX2
ld b, a2
call slow_mult
ld a, cX
sub a,hl
ld hl,a
ld a,a1
ld e,a
call div
ld a,c
ld sX1,a
pop a
ret