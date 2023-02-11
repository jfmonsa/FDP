;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Revisar posn racket lo mas pronto posible|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Ahora se trata de definir una estructura para representar
;un triangulo en el plano cartesiano y cree una variable triangulito
;con los datos de un triangulo

;En este caso aprovechamos la estructura existente posn para alamacenar pares ordenados
;(cordenadas en el plano cartesiano)

(define vertice1 (make-posn) 1 1)
(define vertice2 (make-posn) 1 5)
(define vertice3 (make-posn) 5 1)

(define-struct triangulito (vertice1 vertice2 vertice3)
(define (make-triangulito vertice1 vertice2 vertice3))