;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 6.Ejercicio) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;6)
;Elabore una función que reciba una lista y un número y retorne una lista que
;corresponda a la original, pero de la cual se haya removido la primera aparición
;del número recibido si este estuviera presente en la lista original.



;Definición de los datos
;Las siguientes listas las utilizaremos como ejemplos
(define lista1 (list 4 3 2 5 6 3 6))
(define lista2 (list 1 3 6 4 5))
(define lista3 (list empty))




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;contrato: quitarElemento: list number -> list
;proposito: dada una lista y un numero como argumentos de la función, hacer una función
;           que retorne la lista sin la primera aparicion numero del elemento que le indiquemos
;plantilla: (define (quitarElemento lista elemento)...)
;ejemplos:
;      (quitarElemento lista2 6) debe retornar (list 1 3 4 5)
;      (quitarElemento lista1 6) debe retornar (list 4 3 2 5 3 6)
;      (quitarElemento lista2 4) debe retornar (list 1 3 6 5)
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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;