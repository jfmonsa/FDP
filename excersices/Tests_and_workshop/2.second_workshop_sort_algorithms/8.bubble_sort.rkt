;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |8. Ejercicio - Buble sort|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;8- 
;   Elabore una(s) función(es) para implementar algún otro método de ordenamiento
;   diferente al QuickSort y al SelectionSort.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;,

;Funciones auxiliares

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;-------------------------------------------------------------------------------

; contrato: contarElmenetos list -> number
; proposito: Funcion para contar la cantidad de elementos de una lista
; plantilla: (define (contarElementos list) ...)
; Ejemplos:
;           (contarElementos (list 1 2 3)) deberia retornar 3
; Cuerpo:

(define (contarElementos list)
  (cond
    [(empty? list) 0]
    [else (+ 1 (contarElementos (rest list)))]
    )
  )

;prueba

(check-expect (contarElementos (list 1 2 3)) 3)
;------------------------------------------------------------------------------

; contrato: bubbleSort-Algoritmo lista -> lista
; proposito: Funcion que utiliza el metodo de ordenamiento tipo bubble sort
; plantilla: (define (bubleSort-Algoritmo lista) ...)
; Ejemplos:
;           (bubbleSort-Algoritmo (list 3 2)) deberia retornar (list 2 3)
; Cuerpo:
 
(define (bubbleSort-Algoritmo lista)
  (cond
    [(empty? (rest lista)) lista]
    [(< (first lista) (second lista)) (cons (first lista) (bubbleSort-Algoritmo (rest lista)))]
    [else (cons (second lista) (bubbleSort-Algoritmo (cons (first lista) (rest (rest lista)))))]
    )
  )

;prueba

(check-expect (bubbleSort-Algoritmo (list 3 2)) (list 2 3))
;-------------------------------------------------------------------------------

; contrato: bubbleSortIterator lista numero -> lista
; proposito: Funcion que itera varias veces la funcion de buble Sort para lograr ordenar una lista
;            conociendo el numero de elementos
; plantilla: (define (bubbleSortIterator lista hasta) ...)
; Ejemplos:
;           (bubbleSortIterator (list 1 3 4 1 6 4 71 4) 8) deberia retornar (list 1 1 3 4 4 4 6 71)
; Cuerpo:

(define (bubbleSortIterator lista hasta)
  (cond
    [(equal? 1 hasta) (bubbleSort-Algoritmo lista)]
    [else (bubbleSortIterator (bubbleSort-Algoritmo lista) (- hasta 1))]
    )
  )
;prueba

(check-expect (bubbleSortIterator (list 1 3 4 1 6 4 71 4) 8) (list 1 1 3 4 4 4 6 71))

;------------------------------------------------------------------------------
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;Función principal
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; contrato: bubbleSort lista -> lista
; proposito: Funcion principal que invoca a todas las anteriores para lograr ordenar una lista
;            que el pasemos como argumento con el metodo bubble sort
; plantilla: (define (bubbleSort lista) ...)
; Ejemplos:
;           (bubbleSort (list 1 3 4 1 6 4 71 4) deberia retornar (list 1 1 3 4 4 4 6 71)
; Cuerpo:

(define (bubbleSort lista)
  (bubbleSortIterator lista (contarElementos lista))
  )

;pruebas

(check-expect (bubbleSort (list 1 3 4 1 6 4 71 4)) (list 1 1 3 4 4 4 6 71))

;------------------------------------------------------------------------------
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
