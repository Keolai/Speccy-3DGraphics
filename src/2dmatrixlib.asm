include keolib.asm

;; constants ;;
a1 = #d000
a2 = #d001
a3 = #d002
a4 = #d003
;; coordinates ;;
cX = #d004
cY = #d005
;; preserve coordinates;;
pX = #d006
pY = #d007

;; solutions ;;
sX1 = #d00a
sX2 = #d00b

;; constants needed ;;
Mult = #d010


;; a1 = b, a2 = c, a3 = d, a4 = d h = x, l = y
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
