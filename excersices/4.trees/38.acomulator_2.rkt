;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |38. Ejercicio - Concepto de acomulador|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Dada una lista con las ventas de los 12 meses del año de un almacén
(define ventas-mes (list 2340 1220 1580 4350 1295 5432 2340 1220 1580 4350 1295 5432))
;Se requiere una función que reciba esa lsita y retorne otra lista con las ventas comuladas
;mes a mes


;contrato: ventasAcomuladas: list -> list
;proposito: Seguir el enunciado
;plantilla:
;    (define (ventasAcomuladas lista)...)
;Ejemplos:
;cuerpo
(define (ventasAcomuladas lista acomulador)
  (cond
    [(empty? lista) empty]
    [else
     (cons
      (+ acomulador (first lista))
      (ventasAcomuladas (rest lista) (+ (first lista) acomulador))
           )]
    )
  )
;pruebas
(ventasAcomuladas ventas-mes 0)

