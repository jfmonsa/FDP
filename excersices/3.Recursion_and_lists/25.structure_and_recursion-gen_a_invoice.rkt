;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |25.Ejercicio de recursion y listas = facturación de una droguería|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Una drogueria cuenta con una lista precios con los productos disponibles para la venta
;cada producto tiene nombre y precio

;Definición de datos
(define-struct producto (nombre precio))
;Se tienen disponibles las siguientes operaciones
;(make-producto ...) crear productos
;(producto-.. ...) Seleccionar productos. Ej: (producto-precio ..)
;(producto? ...) Verificar estructura

(define listado (list (make-producto 'dolex 4000)
                      (make-producto 'Ibuprofeno 2500)
                      (make-producto 'asawin 2300)
                      (make-producto 'diclofenaco 3500)
                      (make-producto 'verapamilo 5100)
                      (make-producto 'betametasona 7200)
                      ))
;Cuando un cliente llega a la  drogueria y presenta la formula. la cual contiene una
;serie de medicamentos que especifica cada uno nombre y cantidad
(define-struct item (nombre cantidad))
;Quedan disponibles las operaciones
;(make-item ... ...) para crear items
;(item-... ...) para seleccionar campos ej: (item-nombre ...)

(define receta (list (make-item 'asawin 2)
                     (make-item 'verapamilo 4)
                     (make-item 'dolex 2)
                     ))
;se requiere una funcion que recibe el listado de precios y una receta y retorne
;el valor dela reseta
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Funcion auxiliar buscarPrecios
;contrato: buscarPrecio: simbolo lista(lista de productos) -> numero
;proposito: Consultar en la lista el precio de un producto
;plantilla: (define (buscarPrecio nom precios)...)
;ejemplos
;(buscarPrecio 'asawin listado) debe retornar 2300
;cuerpo
(define (buscarPrecio nom precios)
  (cond
    [(empty? precios) 0]
    [(symbol=? nom (producto-nombre (first precios))) (producto-precio (first precios))]
    [else (buscarPrecio nom (rest precios))]
    )
  )
;pruebas
;(buscarPrecio 'asawin listado) debe retornar 2300
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;contrato: cuenta: lista(lista de productos) lista(lista de items) -> numero
;proposito: resolver el enunciado
;plantilla: (define (cuenta precios receta)...)
;ejemplos
;(cuenta lista)
;cuerpo
(define (cuenta precios formula)
  (cond
    [(empty? formula) 0]
    [else (+ (* (item-cantidad (first formula)) (buscarPrecio (item-nombre (first formula))))
             (cuenta precios (rest formula))
             )
          ]
    )
  )
;pruebas
;(check-expect)