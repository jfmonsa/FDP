;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |ejercicio1-parcial final|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;(40%) Dadas dos listas de números enteros, por ejemplo:
 (define lista1 (list -4 5 3 -1 6 9))
 (define lista2 (list 7 2 -6 1 8))

;Escriba un programa en Racket que reciba esas dos listas y retorne una lista que las unifique forma
;ordenada ascendentemente
;-------------------------------------------------------------------------------




;-------------------------------------------------------------------------------
;contrato: PegaYOrdena: lista lista -> lista
;proposito: seguir el enunciado propuesto por el ejercicio
;plantilla:   (define (pegaYOrdena lis1 lis2)...)
;ejemplos
;     (pegaYOrdena lista1 lista2) debe retornar (list -6 -4 -1 1 2 3 5 6 7 8 9)
;cuerpo:
(define (pegaYOrdena lis1 lis2)
  (local
    (
    ;#######################  FUNCIONES AUXILIARES ############################
    ;---------------------------------------------------------------------------
     ;contrato menoresQue: lista numero -> lista
     ;proposito: dada una lista y un numero hacer una función que devuelva una lista
     ;       con los numeros menores que le número dado
     ;plantilla: (define (menoresQue lista n)...)
     ;ejemplos: (menoresQue lista1 3) debe retornar (list -4 -1)
     (define (menoresQue lista n)
       (cond
         [(empty? lista) empty]
         [(> n  (first lista)) (cons (first lista) (menoresQue (rest lista) n))]
         [else (menoresQue (rest lista) n)]
         )
       )
     ;pruebas:
     ;(check-expect (menoresQue lista1 3) (list -4 -1))
     ;--------------------------------------------------------------------------
     ;contrato: mayoresQue: lista numero -> lista
     ;proposito:  se recibe como argumento una lista y un numero y se devuelve una lista con los
     ;     numeros mayores a ese numero
     ;plantilla.   (define (mayoresQue lista n)...)
     ;ejemplos:  (mayoresQue lista1 -4) debe retornar (list 5 3 -1 6 9)
     ;cuerpo:
     (define (mayoresQue lista n)
       (cond
         [(empty? lista) empty]
         [(< n (first lista)) (cons (first lista) (mayoresQue (rest lista) n))]
         [else (mayoresQue (rest lista) n)]
         )
       )
     ;pruebas:
     ;(check-expect (mayoresQue lista1 -4) (list 5 3 -1 6 9))
    ;---------------------------------------------------------------------------
    ;contrato: igualesQue lista numero -> lista
    ;proposito: se recibe como argumento una lista y un numero y se devuelve un lista con los
    ;      numeros que sean iguales al numero dado
    ;plantilla:
    ;ejemplos: (igualesQue (list 4 2 9 9 2 8 4 4 3 49 4 9) 4) debe retornar (list 4 4 4 4)
    ;cuerpo:
    (define (igualesQue lista numero)
      (cond
        [(empty? lista) empty]
        [(= numero (first lista)) (cons (first lista) (igualesQue (rest lista) numero))]
        [else (igualesQue (rest lista) numero)]
        )
      )
    ;pruebas
   ; (check-expect (igualesQue (list 4 2 9 9 2 8 4 4 3 49 4 9) 4) (list 4 4 4 4))
    ;---------------------------------------------------------------------------
    ;contrato: quickSort: lista -> lista
    ;proposito: ordenar una lista siguiendo el algoritmo de quicksort
    ;plantilla: (define (quickSort lista)...)
    ;ejemplo: (quickSort lista1) debe retornar (list -4 -1 3 5 6 9)
    ;cuerpo:
    (define (quickSort lista)
      (cond
        [(empty? lista) empty]
        [else (append
               (quickSort (menoresQue lista (first lista)))
               (igualesQue lista (first lista))
               (quickSort (mayoresQue lista (first lista))
                          ))]
        )
      )
    ;pruebas:
   ; (check-expect (quickSort lista1) (list -4 -1 3 5 6 9))
    
     ;CUERPO DE LA FUNCIÓN PRINCIPAL ############################################
    )
  (quickSort (append lis1 lis2))
  ))
;pruebas
(check-expect (pegaYOrdena lista1 lista2) (list -6 -4 -1 1 2 3 5 6 7 8 9))