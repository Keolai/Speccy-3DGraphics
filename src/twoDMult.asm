    include keolib.asm

S1 EQU $d000
S2 EQU $d001
Xm EQU $d003
Ym EQU $d004
A1 EQU $d005
A2 EQU $d006
A3 EQU $d007
A4 EQU $d008
NEG EQU $d009
X1 EQU $d00a
X2 EQU $d00b

;; a1 = b, a2 = c, a3 = d, a4 = e h = x, l = y
loadMatrix:
    ld a, h
    ld hl, Xm
    ld a,(hl)   ;x
    inc hl
    ld a,l
    ld a,(hl)
    inc hl
    ld a, b
    ld a,(hl)   ;;a1
    inc hl
    ld a,c
    ld a,(hl)   ;;a2
    inc hl
    ld a,d
    ld a,(hl)   ;;a3
    inc hl
    ld a,e
    ld a,(hl)   ;;a4

;;bc = hl/e
;;hl = b * c
solveMatrix: 
    push bc
    ld c,h
    call slow_mult      ;; a1 * x
    ld hl,X1
    ld (hl),l
    pop bc
    ld a,c
    call negative_handler
    jp loop
    ld b,h
    call slow_mult      ;; a2 * y
    ld hl,X2
    ld (hl),l
    ;; add or subtract
    ld hl,NEG           ;;negative?
    ld a,(hl)
    cp $ff
    jp loop
    jp z, sub_res
    jp nz, add_res
done_first:
    jp loop
    ld hl,S1
    ld (hl),a           ;; store away
    jp loop             ;;STOP

    ld b,d
    ld hl,Xm
    ld a,(hl)
    ld c,a
    call slow_mult
    push hl             ;;store away
    ld b,e
    ld hl,Ym
    ld a,(hl)
    ld c,a
    call slow_mult
    ld a,l
    pop hl
    add a,l
    ld hl,S2
    ld (hl),a
    
negative_handler:
    push af
    and $80
    cp $80
    jp z, set_neg
    xor $ff
    inc a
    pop af
    ret

set_neg:
    ld hl,NEG
    ld a,$ff
    ld (hl),a
    ret
    
sub_res:
    ld hl,X1
    ld a,(hl)
    ld b,a
    inc hl
    ld a,(hl)
    sub b
    jp done_first

add_res:
    ld hl,X1
    ld a,(hl)
    ld b,a
    inc hl
    ld a,(hl)
    add b
    jp done_first
