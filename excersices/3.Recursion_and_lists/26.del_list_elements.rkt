;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |26.Eliminar elementos de una lista|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Elimina elementos de una lista
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;definición de datos
;Las siguientes listas las utilizaremos como ejemplos
(define lista1 (list 4 3 2 5 6 3 6))
(define lista2 (list 1 3 6 4 5))
(define lista3 (list empty))





;1. elimina todos los elemento de una lista que correspondan con el numero dado
(define (quitar2 lista elemento)
  (cond
    [(empty? lista) empty]
    [(equal? (first lista) elemento) (quitar2 (rest lista) elemento)]
    [else (cons (first lista) (quitar2 (rest lista) elemento))]
    )
  )
;pruebas:
(check-expect (quitar2 lista1 6) (list 4 3 2 5 3))








;2. elimina solo la primera coincidencia de una lista que coincida con el argumento dado
;---------------------------------------------------------------------------------
;contrato: quitarElemento: list number -> list
;proposito: dada una lista y un numero como argumentos de la función, hacer una función
;           que retorne la lista sin el numero que le indiquemos
;plantilla: (define (quitarElemento lista elemento)...)
;ejemplos:
;      (quitarElemento lista2 6) debe retornar (list 1 3 4 5)
;cuerpo:
(define (quitarElemento lista elemento)
  (cond
    [(empty? lista) empty]
    [(equal? (first lista) elemento) (rest lista)]
    [else (cons (first lista) (quitarElemento (rest lista) elemento))]
    )
  )


;prueba:
(check-expect (quitarElemento lista2 6) (list 1 3 4 5))
(check-expect (quitarElemento lista1 6) (list 4 3 2 5 3 6))
(check-expect (quitarElemento lista2 4) (list 1 3 6 5))
;---------------------------------------------------------------------------------