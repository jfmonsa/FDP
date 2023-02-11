;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |10. Ejercicio|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
#|
10-
   Desarrolle un programa que reciba una lista de números enteros y retorne una estructura que incluya dos listas,
   una con los elementos pares y otra con los elementos impares de la lista original.
|#
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Definicion de datos

(define-struct respuesta (par impar))

#|
Para la  estructura estaran disponibles
  (make-respuesta # #) para crear estructura tipo respuesta
  (respuesta-par ...) (respuesta-impar ...)  como selectores
  (respuesta? ...) saber si la estructura es de tipo respuesta

|#

;La siguiente lista se crea con el objetivo de poner a prueba las respectivas funciones
(define lista1 (list 1 12 24 53 15 46 68))

#|
Se habilitan las funciones propias de las listas como:
(empty? lista) para saber si la lista se encuentra vacia
(first lista) (rest lista) Como selectores de los elementos de la lista *mismas funciones tiene cdr y car
|#

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Funciones auxiliares

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#|
Contrato: pares: lista -> lista
Proposito: Funcion con el proposito de recibir una lista de datos (numericos) y retornar una nueva lista solamente
           con quellos que sean pares
plantilla:
       (define (pares lista) ...)
Ejemplos:
       (pares lista1) deberia retornar (list 12 24 46 68)
Cuerpo:
|#

(define (pares lista)
  (cond
   [(empty? lista) empty]
   [(= (modulo (first lista) 2) 0) (cons (first lista) (pares (rest lista)))]
   [else (pares (rest lista))]
   )
  )

;Pruebas

(check-expect (pares lista1) (list 12 24 46 68))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#|
Contrato: impares: lista -> lista
Proposito: Funcion con el proposito de recibir una lista de datos (numericos) y retornar una nueva lista solamente
           con quellos que sean impares
plantilla:
       (define (impares lista) ...)
Ejemplos:
       (pares lista1) deberia retornar (list 1 53 15)
Cuerpo:
|#

(define (impares lista)
  (cond
   [(empty? lista) empty]
   [(not (= (modulo (first lista) 2) 0)) (cons (first lista) (impares (rest lista)))]
   [else (impares (rest lista))]
   )
  )

;Pruebas

(check-expect (impares lista1) (list 1 53 15))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Funcion principal

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#|
Contrato: recibeListaEnteros: lista -> estructura
Proposito: Desarrollar el enunciado anteriormente propuesto
plantilla:
       (define (recibeListaEnteros lista) ...)
Ejemplos:
       (recibeListaEnteros lista1) debería retornar (make-respuesta
                                                           (list 12 24 46 68) (list 1 53 15)))
       
Cuerpo:
|#

(define (recibeListaEnteros lista)
  (cond
    [(empty? lista) empty]
    [else (make-respuesta
           (pares lista)
           (impares lista))]
    )
  )

;Pruebas

(check-expect (recibeListaEnteros lista1) (make-respuesta
                                           (list 12 24 46 68) (list 1 53 15)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;