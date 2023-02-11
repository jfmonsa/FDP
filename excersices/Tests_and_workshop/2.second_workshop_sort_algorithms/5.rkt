;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 5.Ejercicio) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;5)
;Elabore una función que reciba una lista y retorne el menor elemento de la lista.


;Definción de datos
;La siguiente lista la utilizaremos para nuestras pruebas
(define lista1 (list 1 2 3 4 5 6 7 8 9 10 11))
(define lista2 (list  3 5 7 9 11 0 13 15 17 19 21))





;---------------------------------------------------------------------------------
;contato: minimoLista: list -> number
;proposito: Devolver el numero menor de toda la lista que le pasemos como argumento
;           a la función
;plantilla: (define (minimoLista lis)...)
;ejemplos
;      (minimoLista lista1) debe retornar 2
;      (minimoLista lista2) debe retornar 1
;cuerpo
(define (minimoLista lis)
  (cond
    [(empty? (rest lis))  (first lis)]
    [(> (first lis) (minimoLista (rest lis))) (minimoLista (rest lis))]
    [else (first lis)]
    )
)
;prueba
(check-expect (minimoLista lista1) 1)
(check-expect (minimoLista lista2) 0)
;---------------------------------------------------------------------------------

