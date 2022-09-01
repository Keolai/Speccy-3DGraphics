include keolib.asm

;; constants ;;
a1 = #d000
a2 = #d001
a3 = #d002
a4 = #d003
;; solutions ;;
cX = #d004
cY = #d005

;; a1 = b, a2 = c, a3 = d, a4 = d
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
pop a


