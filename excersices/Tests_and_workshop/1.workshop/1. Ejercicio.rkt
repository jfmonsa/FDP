;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |1. Ejercicio|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Nombre: Juan Felipe Monsalve Vargas
;codigo Estudiante: 202160145
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;1)
;Una librería tiene a la venta 4 libros (titulo, autor y precio), con los datos presentes en
;la estructura, un cliente dice, que si dentro de sus libros está el título que busca, le compra
;los cuatro libros, si no, le compra el de menor valor. Se requiere entonces un programa que
;reciba las cuatro estructuras libro y el titulo que el cliente desea y retorne una estructura con
;un mensaje (todos o uno) y el valor a pagar.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;1.Definicion de datos
;1.1 Libro
     (define-struct libro (titulo autor precio))
     ;Para la estructura libro estaran disponibles las siguientes operaciones
     ;(make-libro <string> <string> <number>) constructor de la estructura fecha
     ;(libro-titulo ...), (libro-autor...) (libro-precio ...) para selecionar los campos
     ;(libro? variable) Para determinar si la estructura es de tipo libro
;1.2 Factura
     (define-struct factura (mensaje precioTotal))
     ;Para la estructura factura estaran disponibles las siguientes operaciones
     ;(make-factura <string> <number>) constructor de la estructura fecha
     ;(factura-mensaje ...), (factura-precioTotal...) para selecionar los campos
     ;(factura? variable) Para determinar si la estructura es de tipo factura

;Variables para probar en el ejercicio
(define l1(make-libro "Condores no entierran todos los días" "Gustavo Alvarez" 35000))
(define l2(make-libro "El Contrato social" "JJ Roseau" 55000))
(define l3(make-libro "ChuzaDAS" "Julian F Martinez" 45000))
(define l4(make-libro "How To Design Programs" "MIT Press" 10000))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;2.Contrato: comprarLibros: libro libro libro libro string -> factura
;3.proposito: El del enunciado
;4.Plantilla: (define (comprarLibros l1 l2 l3 l4 libroBuscado)...)
;5.Ejemplos
;      (comprarLibros l1 l2 l3 l4 "How To Design Programs") debe retornar (make-factura "Todos los libros seleccionados" 145000)
;      (comprarLibros l1 l2 l3 l4 "Viento Seco") debe retornar (make-factura "un libro seleccionado" 10000)
;6.Cuerpo
(define (comprarLibros l1 l2 l3 l4 libroBuscado)
  (cond
    ;Validando los tipos de datos ingresados
    [(and
          (libro? l1)
          (libro? l2)
          (libro? l3)
          (libro? l4)
          (string? libroBuscado)
          )
     (cond
       ;Siguiendo el enunciado
       [(or
         (string=? libroBuscado (libro-titulo l1))
         (string=? libroBuscado (libro-titulo l2))
         (string=? libroBuscado (libro-titulo l3))
         (string=? libroBuscado (libro-titulo l4)
        )) (make-factura "Todos los libros seleccionados" 145000)]
       [else (make-factura "un libro seleccionado" (min
                                                    (libro-precio l1)
                                                    (libro-precio l2)
                                                    (libro-precio l3)
                                                    (libro-precio l4)
                                                    ))]
       )
     ]
  ))
;7.Pruebas
(check-expect (comprarLibros l1 l2 l3 l4 "How To Design Programs") (make-factura "Todos los libros seleccionados" 145000))
(check-expect (comprarLibros l1 l2 l3 l4 "Viento Seco") (make-factura "un libro seleccionado" 10000))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;