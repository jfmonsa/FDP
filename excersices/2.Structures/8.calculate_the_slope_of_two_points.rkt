;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname EjemploPlano) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Desarrollar una función que calcule la distancia entre dos puntos del
; plano cartesiano.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Definición de datos:
; Se utilizará la estructura posn, compuesta por campos x, y y que cuenta con
; las operaciones para construir, extraer y para verificar
(define punto1 (make-posn 2 1))
(define punto2 (make-posn 5 5))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Contrato: distancia: posn posn -> número
; Propósito: Resolver el enunciado
; Plantilla: (define (distancia p1 p2) ... )
; Ejemplos:
; (distancia punto1 punto2) debe retornar 5
; Cuerpo:
(define (distancia p1 p2)
  (sqrt (+ (sqr (- (posn-x p2) (posn-x p1)))
           (sqr (- (posn-y p2) (posn-y p1))))))
; Pruebas
(check-expect (distancia punto1 punto2) 5)




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Considerando la estructura posn, se solicitan funciones para:
; 1. Calcular la pendiente de una recta, dados dos puntos de la misma
; 2. Determinar si tres puntos del plano se encuentran sobre una recta o forman
;    un triángulo
; 3. Dados tres puntos del plano cartesiano, determinar si forman una recta o
;    un triangulo equilatero, isosceles o escaleno
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;PUNTO NUMERO 1 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;1. Contrato calcularPendiente: posn posn -> número
;2. Proposito: calcular las pendiente segun los datos de la coordenada que se
;             le ingresen a la funcion
;3. Plantilla
;    (define (calcularPendiente punto1 punto2) ... )
;4.Ejemplos
;  (calcularPendiente (make-posn 2 2) (make-posn 4 4)) debe retornar 1
;5. Cuerpo
     (define (calcularPendiente punto1 punto2)
       (/ (- (posn-y punto2) (posn-y punto1)) (- (posn-x punto2) (posn-x punto1)))
       )
;6. Pruebas
(check-expect (calcularPendiente (make-posn 2 2) (make-posn 4 4)) 1)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;PUNTO NUMERO 2 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;1. Contrato esTriangulo?: x1 y1 x2 y2 x1 y3 -> symbol
;2. Proposito: Determinar si dos puntos en el plano hacen parte de una recta o forman un triangulo
;3. Plantilla:     (define (esRecta? x1 y1 x2 y2 x1 y3))
;4.Ejemplos
;  (esRecta? (make-posn 2 2) (make-posn 4 4) (make-posn 6 6)) debe retornar 'recta
;  (esRecta? (make-posn 4 2) (make-posn 6 4) (make-posn 10 2)) debe retornar 'triangulo 
;5.Cuerpo
(define (esRecta? punto1 punto2 punto3)
  (if (= (calcularPendiente punto1 punto2) (calcularPendiente punto1 punto3))
      'recta
      'triangulo
      )
  )
;6.Pruebas
  (check-expect (esRecta? (make-posn 2 2) (make-posn 4 4) (make-posn 6 6)) 'recta)
  (check-expect (esRecta? (make-posn 4 2) (make-posn 6 4) (make-posn 10 2)) 'triangulo)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Funcion adicional ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;1. Contrato iguales: numero numero -> boolean
;2. Proposito: comparar dos numeros aceptando que son igules si su diferencia es menor
;            a 0.001
;3. Cuerpo:
(define (iguales n1 n2)
(if (< (abs (- n1  n2)) 0.001) true false)
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;PUNTO NUMERO 3 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;1. Contrato tipoDeTriangulo: posn posn posn -> string
;2. Proposito: Determinar el tipo de triangulo si es equilatero, isosceles o escaleno
;3. Plantilla     (define (tipoDeTriangulo punto1 punto2 punto3) ...)
;4.Ejemplos
; (tipoDeTriangulo (make-posn 4 2) (make-posn 6 4) (make-posn 10 2)) debe retornar "Es un trinagulo Escaleno"
; (tipoDeTriangulo (make-posn 2 1) (make-posn 5 5) (make-posn 5 -3) debe retornar "Es un trinagulo Isosceles"
; (tipoDeTriangulo (make-posn 2 2) (make-posn 4 4) (make-posn 6 6) debe retornar  "Segun los puntos que ingresastes la figura es una recta y no un triangulo")
; (tipoDeTriangulo (make-posn 2 2) (make-posn 7 2) (make-posn 4.5 6.333)) debe retornar "Es un trinagulo Equilatero"
;5.Cuerpo
(define (tipoDeTriangulo punto1 punto2 punto3)
  (if (equal? (esRecta? punto1 punto2 punto3) 'recta)
      ;En caso de que el punto ingresado no sea un triangulo
       "Segun los puntos que ingresastes la figura es una recta y no un triangulo"
      ;En caso de que si sea un triangulo
       (cond
         [(and (iguales (distancia punto1 punto2) (distancia punto1 punto3))
               (iguales (distancia punto1 punto3) (distancia punto3 punto2)))
          "Es un trinagulo Equilatero" ]
         [(or (iguales (distancia punto1 punto2) (distancia punto1 punto3))
              (iguales (distancia punto1 punto3) (distancia punto3 punto2))
              ) "Es un trinagulo Isosceles" ]
         [else "Es un trinagulo Escaleno"]
         )
      ))
#|
      
|#
;6.Pruebas:
(check-expect  (tipoDeTriangulo (make-posn 2 2) (make-posn 4 4) (make-posn 6 6))  "Segun los puntos que ingresastes la figura es una recta y no un triangulo")
(check-expect (tipoDeTriangulo (make-posn 2 1) (make-posn 5 5) (make-posn 5 -3)) "Es un trinagulo Isosceles")
(check-expect (tipoDeTriangulo (make-posn 4 2) (make-posn 6 4) (make-posn 10 2)) "Es un trinagulo Escaleno")
;(check-expect (tipoDeTriangulo (make-posn 2 2) (make-posn 7 2) (make-posn 4.5 6.333)) "Es un trinagulo Equilatero")
