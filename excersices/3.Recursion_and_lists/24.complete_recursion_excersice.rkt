;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |24.Ejercicio mas completo de recursión con listas - pero con errores queda pendiente|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Dada una lista de numeros (no se sabe cuantos) se requiere una función
;que reciba dicha lista y retorne una estructura con los siguientes datos
;(campos) respecto a la lista: numero de elementos, suma de todos los elemento y
;promedio de todos los elementos, el menor de todos los elementos y el mayor de todos
;los elementos
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Definción de datos
;listas de pruebas
(define lista1 (list 10 34 51 24.7 21))
(define lista2 (list 32 9 45 34))
(define lista3 (list 3 4 5))
(define lista4 (list empty))

;estructura que retorna la función
(define-struct datosLista (numElementos sumaElementos promElementos minimo maximo))
;Quedan disponibles las operaciones
;(make datosLista ...) para crear la lista
;(datosLista-... ...) para seleccionar elementos. Ej: (datosLista-numElementos ..)
;(datosLista? ...) para probar si es una estructura datosListas
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;; Funciones auxiliares ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;------------------------------------------------------------------------------
;A) Contar lista
;contrato contarLista: list -> number
;Proposito: contar elementos de una lista
;plantilla: (define (contarLista lis)...)
;ejemplo
;      contarLista lista3) debe retornar 3
;cuerpo
(define (contarLista lis)
  (cond
    [(empty? lis) 0]
    [else (+ 1 (contarLista (rest lis)))]
   )
  )
;pruebas
(check-expect (contarLista lista3) 3)
;------------------------------------------------------------------------------
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;------------------------------------------------------------------------------
;B) sumatoriaLista
;contrato: sumatoriaLista: list -> number
;proposito: sumar los elementos de la lista
;plantilla: (define (sumatoriaLista lis) ...)
;ejemplos
;(sumatoriaLista lista3) debe retornar 12
;cuerpo:
(define (sumatoriaLista lis)
  (cond
    [(empty? lis) 0]
    [else (+ (car lis) (sumatoriaLista (cdr lis)))]
    )
  )
;pruebas
(check-expect (sumatoriaLista lista3) 12)
;------------------------------------------------------------------------------
;------------------------------------------------------------------------------
;C)
;contrato: minimoLista: list -> number
;proposito: devolver el minimo de una lista
;plantilla (define minimoLista lis)...)
;ejemplos
;cuerpo
(define (minimoLista lis)
  (cond
    [(empty? (rest lis))  (first lis)]
    [(< (minimoLista (rest lis)) (first lis)) (minimoLista (rest lis))]
    [else (first lis)]
    )
)
;pruebas
(check-expect (minimoLista lista2) 9)
;------------------------------------------------------------------------------
;D)
(define (maximoLista lis)
  (cond
    [(empty? (rest lis)) (first lis)]
    [(> (maximoLista (rest lis)) (first lis)) (maximoLista (rest lis))]
    [else (first lis)]
    )
)
;pruebas
(check-expect (maximoLista lista2) 45)
;------------------------------------------------------------------------------
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;contrato: lista -> datosLista
;proposito: seguir el enunciado
;plantilla: (define (procesaLista lis) ...)
;ejemplos:
;(procesaLista lista3) debe retornar (make-datosLista 3 12 4 3 5)
;cuerpo:
(define (procesaLista lis)
  (make-datosLista
      (contarLista lis)
      (sumatoriaLista lis)
      (/ (sumatoriaLista lis)(contarLista lis))
      (minimoLista lis)
      (maximoLista lis)
   )
  )
;pruebas
(check-expect (procesaLista lista3) (make-datosLista 3 12 4 3 5))
;(define lista3 (list 3 4 5))