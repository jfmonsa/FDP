;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 2.ejercicio) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Nombre: Juan Felipe Monsalve Vargas
;codigo Estudiante: 202160145
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;2)
;Una fábrica de calzado, realizó un estudio del rendimiento de sus trabajadores;
;como resultado de esa investigación se llegó a las siguientes conclusiones:
;• Entre las 6:00 y las 10:00 cada trabajador produce 30 pares por hora
;• Entre las 10:01 y las 14:00 cada trabajador produce 40 pares por hora
;• Entre las 14:01 y las 18:00 cada trabajador produce 46 pares por hora
;Se requiere una función que tome como entrada una estructura con la hora
;(represente la hora como un número entre 1 y 24) y la cantidad de trabajadores.
;La función debe retornar la cantidad de pares que la empresa textil produce en
;esa hora, dado el número de trabajadores
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;






;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;1.Definicion de datos
(define-struct inicial (hora trabajadores))
;Para la estructura inicial estaran disponibles las operaciones
;     make-inicial <number> <number>) como constructor para crear la estructura
;     (inicial-hora <estructura>) (inicial-trabajadores <estructura>) para extraer información
;     (incial? <estructura>) para saber si es una estructura de tipo inical
;Estructuras para probar en el ejercicio
(define d1 (make-inicial 15 10))
(define d2 (make-inicial 12 10))
(define d3 (make-inicial 8 10))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;2.contrato producion: inical -> string
;3.proposito: Seguir el enunciado
;4. Plantilla (define (producion inicial)...)
;5.Ejemplos
;(producion d1) debe retornar 460
;(producion d2) debe retornar 400
;(producion d3) debe retornar 300
;6.Cuerpo
(define (producion datos)
    (cond
      [(and (<= (inicial-hora datos) 10) (> (inicial-hora datos) 6))
        (* 30 (inicial-trabajadores datos))
       ]
      [(and (<= (inicial-hora datos) 14) (> (inicial-hora datos) 10))
        (* 40 (inicial-trabajadores datos))
       ]
      [(and (<= (inicial-hora datos) 18) (> (inicial-hora datos) 14))
        (* 46 (inicial-trabajadores datos))
       ]
    )
  )
;7.Pruebas
(check-expect  (producion d1) 460)
(check-expect (producion d2) 400)
(check-expect (producion d3) 300)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;