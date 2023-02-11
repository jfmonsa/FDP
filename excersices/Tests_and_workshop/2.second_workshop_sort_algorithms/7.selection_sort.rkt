;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |7.ejercicio - Selection sort|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;7)
;Implemente el algoritmo de ordenamiento por selección (SelectionSort, que debe
;investigar) para retornar, ordenada ascendentemente, una lista recibida. Considere
;utilizar funciones ya elaboradas como auxiliares.


;definición de datos
;Las siguientes listas las utilizaremos como ejemplos
(define lista1 (list 4 3 2 5 6 3 6))
(define lista2 (list 1 3 6 4 5))
(define lista3 (list empty))





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Funciones auxiliares
;a)
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
(check-expect (minimoLista lista1) 2)
(check-expect (minimoLista lista2) 1)
;---------------------------------------------------------------------------------
;b)
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;contato: selectionSort: list -> list
;proposito: construir una función que ordene los elementos de una lista de menor a
;        mayor siguiendo el algoritmo de selection sort.
;plantilla:  (define (selectionSort lista)...)
;ejemplos:
;       (selectionSort lista2) debe retornar (list 1 3 4 5 6)
;       (selectionSort lista1) debe retornar (list 2 3 3 4 5 6 6)
;       (selectionSort lista3) debe retornar (list empty)
;cuerpo:
(define (selectionSort lista)
(cond
  [(empty? lista) empty]
  [else (cons (minimoLista lista) (selectionSort (quitarElemento lista (minimoLista lista))))]
  )
)
;prueba
(check-expect (selectionSort lista2) (list 1 3 4 5 6))
(check-expect (selectionSort lista1) (list 2 3 3 4 5 6 6))
(check-expect (selectionSort lista3) (list empty))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;