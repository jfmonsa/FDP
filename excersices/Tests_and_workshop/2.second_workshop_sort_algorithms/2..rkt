;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |2. Ejercicio|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
#|
2- Desarrolle una función que reciba una lista de símbolos y un símbolo, y retorne un true o un false dependiendo
   de si encuentra o no (respectivamente) el símbolo en la lista.|#
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Definicion de datos:
;Las siguientes listas se crean con el objetivo de poner a prueba las respectivas funciones

(define lista1 (list 'Juan 'Carlos 'Daniel))
(define lista2 (list 'Acetaminofen 'Dolex 'Noxpirin 'Aspirina 'Omeprazol))

#|
Se habilitan las funciones propias de las listas como:
(empty? lista) para saber si la lista se encuentra vacia
(first lista) (rest lista) Como selectores de los elementos de la lista *mismas funciones tiene cdr y car
|#

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#|
Contrato: existe?: lista symbol -> boolean
Proposito: Desarrollar el enunciado anteriormente propuesto
plantilla:
       (define (existe? lista elemento) ...)
Ejemplos:
       (existe? lista1 'Daniel) debe  retornar true
       (existe? lista2 'Amoxicilina) debe retornar false
Cuerpo:
|#

(define (existe? lista elemento)
  (cond
    [(empty? lista) #f]
    [(equal? elemento (first lista)) #t]
    [else (existe? (rest lista) elemento)]
    )
  )

;pruebas
(check-expect (existe? lista1 'Daniel) true)
(check-expect (existe? lista2 'Amoxicilina) false)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;,