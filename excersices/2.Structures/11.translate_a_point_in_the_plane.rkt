;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |11. Transladar un punto en el plano cartesiano|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Definicion de datos: no es necesario definir la estructura,
;   puesto que vamos a trabajar con una estructura posn que ya esta
(define p1 (make-posn -4 2))
(define p2 (make-posn 1 3))
;1.Proposito
;  1.1.Contrato: moverPunto: posn symbolo numero-> posn
;  1.2.Objetivo: Hacer una estructura que va despalazar el punto
;    Segun las indicaciones que haga el usuario
;  1.3.plantilla: (define (moverPunto punto tipo valor))
;2. Ejemplos
; (mover p1 'h -9) debe retornar (make-posn -13 2)
; (mover p1 'v 5) debe retornar (make-posn 1 8)
;3.Cuerpo
(define (moverPunto punto tipo valor)
  (cond
   [#|En caso de que sea horizontal (eje x)|#
    (symbol=? tipo 'h)(make-posn (+ (posn-x punto) valor) (posn-y punto))]
   [#|En caso de que sea vertical (eje y)|#
    else (make-posn (posn-x punto) (+ (posn-y punto) valor))]
   )
  )
;4.pruebas
(check-expect (moverPunto p1 'h -9) (make-posn -13 2))
(check-expect (moverPunto p1 'v 1) (make-posn -4 3))