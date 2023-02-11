;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |ejercicio 2 - parcial f|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;. (60%) Dado un árbol binario de búsqueda con los productos que se venden en una tienda como, por
;ejemplo:
;-------------------------------------------------------------------------------



;-------------------------------------------------------------------------------
;Definción de datos para el ejercicio
(define-struct producto (codigo nombre precio))
;Esta estructura tipo producto tendrá definida las operaciones que tienen todas las
;estructuras: creación: (make-producto ...) los selectores ej: (producto-nombre ...)
;y el predicado para saber si estamos tratando con una estructura tipo producto (producto? ...)
(define p1 (make-producto 101 "Limpiador" 2300))
(define p2 (make-producto 102 "Desmanchador" 3700))
(define p3 (make-producto 103 "Cera" 8900))
(define p4 (make-producto 104 "Desengrasante" 6500))
(define p5 (make-producto 105 "Detergente" 14600))
(define p6 (make-producto 106 "Escoba" 6800))
(define p7 (make-producto 107 "Trapero" 8500))




;Definción del arbol
(define arbolProductos (list p4
                             (list p2
                                   (list p1 empty empty)
                                   (list p3 empty empty))
                             (list p6
                                   (list p5 empty empty)
                                   (list p7 empty empty))))
;-------------------------------------------------------------------------------
;Y una lista de compras de un cliente como, por ejemplo:
(define listaCompras (list 105 102 127 104 111 103 147))
#|
Escriba un programa en Racket que reciba tanto el árbol como la lista y retorne una estructura con dos
listas: una con los códigos de los artículos que están disponibles y otra con los códigos de los artículos que
no se venden en la tienda.
|#





;definición de datos para la función
(define-struct respuesta (productosDisponibles productosNoVendidos))




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;contrato: validarProductos: lista arbol -> respuesta(estructura)
;proposito: seguir el enunciado
;plantilla: (define (validarProductos lista arbol)...)
;ejemplos: (validarProductos listaCompras arbolProductos) debe retornar (make-respuesta (list 105 102 104 103) (list 127 111 147))
;cuerpo:
(define (validarProductos lista arbol)
  (local

    ;*************************************************************************************************
    ;###############################   fucniones auxiliares    #######################################
        (
        ;para esta estructura estarán disponibles todas las acciones disponibles para estructuras
        ;----Fuciones básicas de arboles
        (define (izq arb)
          (second arb)
          )
        (define (der arb)
          (third arb)
          )
        
        ;-------------------------------------------------------------------------------
        ;contrato: codigoExiste: numero arbol ->  boolean
        ;proposito: Hacer una función que pansandole un codigo (número) y un arbol como argumento
        ;       esta me devuelva true si el codigo ingresado existe como valor de algún nodo del
        ;       árbol, de lo contrario retornar false
        ;plantilla:
        ;ejemplo:
        ;    (codigoExiste? 147 arbolProductos) debe retornar false
        ;cuerpo
        (define (codigoExiste? cod arb)
          (cond
            [(empty? arb) false]
            [(= (producto-codigo (first arb)) cod) true]
            [(< cod  (producto-codigo (first arb))) (codigoExiste? cod (izq arb))]
            [else (codigoExiste? cod (der arb))]
            )
          )
        ;pruebas:
        ;(check-expect (codigoExiste? 147 arbolProductos) false)
        ;------------------------------------------------------------------------------
        ;contrato: listanEstan: lista arbol -> lista
        ;proposito: devolver los elementos de una lista que si se correspondan con los del
        ;arbol
        ;plantilla: (define (listaEstan lista arbol)...)
        ;ejemplos: (listaEstan listaCompras arbolProductos) debe retornar (list 105 102 104 103)
        (define (listaEstan lista arbol)
          (cond
            [(empty? lista) empty]
            [(codigoExiste? (first lista) arbol) (cons (first lista) (listaEstan (rest lista) arbol))]
            [else (listaEstan (rest lista) arbol)]
            )
          )
        ;-------------------------------------------------------------------------------
        ;-------------------------------------------------------------------------------
        ;contrato: listaNoEstan: lista arbol -> lista
        ;proposito: devolver los elementos de una lista que no se correspondan con los del
        ;arbol
        ;platilla: (define (listaNoEstan lista arbol)...)
        ;ejmeplos:  (listaNoEstan listaCompras arbolProductos) debe retornar (list 127 111 147)
        (define (listaNoEstan lista arbol)
           (cond
             [(empty? lista) empty]
            [(not (codigoExiste? (first lista) arbol)) (cons (first lista) (listaNoEstan (rest lista) arbol))]
            [else (listaNoEstan (rest lista) arbol)]
             )
          )
        ;-------------------------------------------------------------------------------
        ;*******************************************************************************
        )

        ;################################ CUERPO DE LA FUNCIÓN PRINCIPAL ################
        (make-respuesta
           (listaEstan lista arbol)
           (listaNoEstan lista arbol)
        )
        )  
    )
;prebas
(check-expect (validarProductos listaCompras arbolProductos) (make-respuesta (list 105 102 104 103) (list 127 111 147)))
;(validarProductos listaCompras arbolProductos)