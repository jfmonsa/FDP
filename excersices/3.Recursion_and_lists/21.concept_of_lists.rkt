;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |21.Listas = primer ejercicio con el concepto de listas|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Escirbir una funcio n que reciba un numero natural y retorne
;una lista de datos con tantos sumbolos 'Hola como se lo indique el
;numero

;contrato listaHola: numero -> lista
;proposito: seguir el enunciado
;plantilla
;ejemplos
; (listaHola 0) debe retornar empty
; (listaHola 5) debe retornar (cons ('Hola (cons 'Hola (cons 'Hola (cons 'Hola (cons 'Hola empty))

(define (listaHola n)
  (cond
    [(= n 0) empty]
    [else (cons 'Hola (listaHola (- n 1)))]
    )
  )
;pruebas
(check-expect (listaHola 0) '())
(listaHola 5)