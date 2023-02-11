;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 3.Ejercicio) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;3
;Escriba una función que reciba una lista de números enteros y otro número, y
;retorne una lista donde solo aparezcan los elementos de la lista que sean menores
;al otro número. Elabore otra función, similar a la anterior donde el retorno sea
;una lista con los elementos de la lista que sean mayores o iguales al otro número




;Definición de los datos
;La siguiente lista la utilizaremos para nuestras pruebas
(define lista1 (list 1 2 3 4 5 6 7 8 9 10 11))
(define lista2 (list 1 3 5 7 9 11 13 15 17 19 21))






;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;contrato: menoresQue: list number -> list
;proposito: Una función que reciba una lista con numeros y un numero y que retorne
;           Otra lista solamente con los numeros menores a los de la lista original
;plantilla:  (define (menoresQue lista menorQue)...)
;ejemplos
;      (menoresQue lista1 6) debe retornar (list 1 2 3 4 5)
;      (menoresQue lista2 11) debe retornar (list 1 3 5 7 9)
;cuerpo
(define (menoresQue lista numero)
  (cond
    [(empty? lista) empty]
    [(< (first lista)  numero) (cons (first lista) (menoresQue (rest lista) numero)) ]
    [else (menoresQue (rest lista) numero)]
    )
  )
;pruebas
(check-expect (menoresQue lista1 6) (list 1 2 3 4 5))
(check-expect (menoresQue lista2 11) (list 1 3 5 7 9))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;contrato: mayoresOIgualesQue: list number -> list
;proposito: Una función que reciba una lista con numeros y un numero y que retorne
;           Otra lista solamente con los numeros mayores o iguales a los de la lista original
;plantilla: (define (mayoresOIgualesQue lista numero)...)
;ejemplos
;      (mayoresOIgualesQue lista1 6) debe retornar (list 6 7 8 9 10 11)
;      (mayoresOIgualesQue lista2 11) debe retornar (list 11 13 15 17 19 21)
;cuerpo
(define (mayoresOIgualesQue lista numero)
  (cond
    [(empty? lista) empty]
    [(>= (first lista) numero) (cons (first lista) (mayoresOIgualesQue (rest lista) numero))]
    [else (mayoresOIgualesQue (rest lista) numero)]
    )
  )
;pruebas:
(check-expect (mayoresOIgualesQue lista1 6) (list 6 7 8 9 10 11))
(check-expect (mayoresOIgualesQue lista2 11) (list 11 13 15 17 19 21))