DEVICE ZXSPECTRUM128
;; meant to test compilation ;;
    
    include twodmatrixlib.asm
    include keolib.asm

    org $8000

start:
    ld bc,#0f0f
    ld de,#0e0e
    ld hl,#0102
    call loadMatrix
    call solveMatrix
    ret


    SAVESNA"test.sna", start