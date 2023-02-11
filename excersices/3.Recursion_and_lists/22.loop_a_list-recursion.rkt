;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |22.Listas y recursividad|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Vamos a realizar varios ejercicios para recorrer una lista, para ello
;ultilizaremos las dos siguientes listas
;Definción de datos
(define lista1 (cons 20 (cons 21 (cons 22 (cons 23 (cons 24(cons 25 empty)))))))
(define lista2 (cons 1 (cons 2 (cons 3 empty))))

;===============================================================================
;Funcion que suma todos los elementos de una lista
(define (sumarElementosLista lista)
  (cond
    [(empty? lista) 0]
    [else (+ (first lista) (sumarElementosLista (rest lista)))]
    )
  )
;pruebas
(check-expect (sumarElementosLista lista1) 135)
;===============================================================================





;===============================================================================
;Funcion que cuenta los elelemtos de una lista
(define (numberOfElements lista)
  (cond
    [(empty? lista) 0]
    [else (+ 1 (numberOfElements (rest lista)))]
    )
  )
(check-expect (numberOfElements lista1) 6)
;===============================================================================





;===============================================================================
;Función para buscar los elementos en una lista
(define (search lista elemento)  
  (cond
    [(empty? lista) false]
    [(= (first lista) elemento) true]
    [else  (search (rest lista) elemento)]
    )
)
;pruebas
(check-expect (search lista1 25) true)
;===============================================================================




;===============================================================================
;Funcion que le ingrese un lista de numeros y me devuelva el resultado de elevar
;cada elemento al cuadrado
(define (alCuadrado lista)
  (cond
    [(empty? lista) empty]
    [else
     (cons (sqr (first lista)) (alCuadrado (rest lista)))
     ]
    )
  )
;pruebas
(check-expect (alCuadrado lista2) (cons 1 (cons 4 (cons 9 empty))))
;===============================================================================