;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |4.Ejercicio - quicksort|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;definicion de datos
;La siguiente lista la utilizaremos para hacer las respectivas pruebas a cada
;función
(define lista1 (list 32 52 89 21 0 99 32 25 28 31))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Funciones auxiliares
;-------------------------------------------------------------------------------
;contrato: menores: list number -> list
;proposito: se recibe como argumento una lista y un numero y se devuelve una lista
;       con los numero menores a ese numero
;plantilla: (define (menores lista numero)...)
;ejemplos
;cuerpo
(define (menoresQue lista numero)
  (cond
    [(empty? lista) empty]
    [(< (first lista) numero) (cons (first lista) (menoresQue (rest lista) numero))]
    [else (menoresQue (rest lista) numero)]
    )
  )
;pruebas
(check-expect (menoresQue lista1 25) (list 21 0))
;-------------------------------------------------------------------------------


;-------------------------------------------------------------------------------
;contrato: mayoresQue: list number -> list
;proposito: se recibe como argumento una lista y un numero y se devuelve una lista con los
;      numeros mayores a ese numero
;plantilla (define (mayoresQue lista numero)...)
;ejemplos:
;       (mayoresQue lista1 25) debe retornar (list 32 52 89 0 99 32 28 31)
;cuerpo:
(define (mayoresQue lista numero)
  (cond
    [(empty? lista) empty]
    [(> (first lista)  numero) (cons (first lista) (mayoresQue (rest lista) numero))]
    [else (mayoresQue (rest lista) numero)]
    )
  )
;pruebas
(check-expect (mayoresQue lista1 25) (list 32 52 89 99 32 28 31))
;-------------------------------------------------------------------------------


;-------------------------------------------------------------------------------
;contrato: igualesQue: lista numero -> numero
;proposito: se recibe como argumento una lista y un numero y se devuelve un lista con los
;          numeros que sean iguales al numero dado
;plantilla: (define (igualesQue lista numero)...)
;ejemplos:
;    (igualesQue lista1 32) debe retornar (list 32 32)
;cuerpo:
(define (igualesQue lista numero)
  (cond
    [(empty? lista) empty]
    [(= numero (first lista)) (cons (first lista) (igualesQue (rest lista) numero))]
    [else (igualesQue (rest lista) numero)]
    )
  )
;pruebas:
(check-expect (igualesQue lista1 32) (list 32 32))       
;-------------------------------------------------------------------------------
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;contrato: quickSort: lista -> lista
;proposito: ordenar una lista siguiendo el algoritmo de quicksort
;plantilla: (define (quickSort lista)...)
;ejemplo:
;      (quickSort lista1) debe retornar (list 0 21 25 28 31 32 32 52 89 99)
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
;pruebas
(check-expect (quickSort lista1) (list 0 21 25 28 31 32 32 52 89 99))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;