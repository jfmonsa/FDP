;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |clase de hoy|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Definción de los arboles
(define suma (list "+"
                   (list 3 empty empty)
                   (list 5 empty empty)))
(define division (list "/"
                       (list 8 empty empty)
                       (list 4 empty empty)))
(define operacion (list "/" suma (list 4 empty empty)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Operaciones basicas para recorrer
;Verificar si es una hoja:
(define (esHoja? nodo)
  (and (empty? (second nodo)) (empty? (third nodo))))
;Retornar el subarbol izquierdo
(define (izq nodo)
  (second nodo))
;Retornar el subarbol derecho
(define (der nodo)
  (third nodo))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Desarrolar una funcion en racket que permita mostrar la expresion que cada
;arbol representa
;------------------------------------------------------------------------------
;Contrato: mostrarExpresion: arbol -> string
;Proposito: resolver el enunciado
;Plantilla (define (mostrarExpresion arb)...)
;Ejemplo:
; (mostrarExpresion suma) debo esperar "3 + 5"
; (mostrarExpresion division) debo esperar "8 / 4"
; (mostrarExpresion operacion) debo esperar "(( 3 + 5 )/ 4 )"
;Cuerpo:
(define (mostrarExpresion arb)
  (cond
    [(esHoja? arb) (string-append " " (number->string (first arb)) " ")] ;si es numero
    [else (string-append "("
                         (mostrarExpresion (izq arb))
                         (first arb) ;Signo
                         (mostrarExpresion (der arb)) ")")]))

;Pruebas
(check-expect (mostrarExpresion suma) "( 3 + 5 )")
(check-expect (mostrarExpresion division) "( 8 / 4 )")
(check-expect (mostrarExpresion operacion) "(( 3 + 5 )/ 4 )")
;-------------------------------------------------------------------------------
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;se trata ahora de escribir una funcion que dado un arbol evalue y retorne el
;valor que representa la expresion aritmetica
;-------------------------------------------------------------------------------
;Definción de arbol para las pruebas
(define dificil (list "^"
                      (list "-"
                            (list "*"
                                  (list 3 empty empty)
                                  (list 4 empty empty)
                                  )
                            (list "/"
                                  (list 35 empty empty)
                                  (list 7 empty empty)
                                  )
                            )
                      (list "+"
                            (list 2 empty empty)
                            (list 1 empty empty)
                            )
                      ))
;-------------------------------------------------------------------------------
;-------------------------------------------------------------------------------
;Contrato: resuelveExpresion: arbol -> numero
;Proposito: resolver el enunciado
;Plantilla (define (resuelveExpresion arb)...)
;Ejemplo:
; (resuelveExpresion suma) debo esperar 8
; (resuelveExpresion division) debo esperar 2
; (resuelveExpresion operacion) debo esperar 2
;Cuerpo:
(define (evaluarExpresion arb)
  (cond
    [(esHoja? arb) (first arb)]
    [(string=? (first arb) "+")
       (+ (evaluarExpresion (izq arb))
          (evaluarExpresion (der arb))
          )
     ]
    [(string=? (first arb) "-")
       (- (evaluarExpresion (izq arb))
          (evaluarExpresion (der arb))
          )
     ]
    [(string=? (first arb) "*")
       (* (evaluarExpresion (izq arb))
          (evaluarExpresion (der arb))
          )
     ]
    [(string=? (first arb) "/")
       (/ (evaluarExpresion (izq arb))
          (evaluarExpresion (der arb))
          )
     ]
    [(string=? (first arb) "^")
       (expt (evaluarExpresion (izq arb))
          (evaluarExpresion (der arb))
          )
     ]
    )
  )
;pruebas
(check-expect (evaluarExpresion dificil) 343)
;-------------------------------------------------------------------------------
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Se trata de elaborar una funcion que reciba un arbol que represente una operación
;aritmetica y la muestre en notación prefija (o poloca) o en notación postfija
;(polaca inversa) la toma habitualmente conocemos como notación infija
;La expresión infija: "((3 * 4)-(35 / 7)^(2 + 1))" en prefija se escribiría como:
;" ^ - * 3 4 / 35 7 + 2 1" y en postfija como: "3 4 * 35 7 / - 2 1 + ^ "
;
;      prefija Se hace la operacion de derecha a izquierda (el operador va primero)
;      postfija se hace la operaciónn de izquierda a dercha (el operador va despues)
;en notación prefija y post fija no son necesarios parentesis
;-------------------------------------------------------------------------------


;-------------------------------------------------------------------------------
;contrato: prefija: arbol -> string
;proposito: Seguir el enunciado
;ejemplo:
;       (prefija dificil) debe retornar "^ - * 3 4 / 35 7 + 2 1"
;plantilla: (define (prefija arb)...)
;cuerpo
(define (prefija arb)
  (cond
    [(esHoja? arb) (number->string (first arb))] ;si es numero
    [else
     (string-append
      (first arb)
      " "(prefija (izq arb))" "
      (prefija (der arb))
      )
     ]
    )
  )
;pruebas
(check-expect (prefija dificil) "^ - * 3 4 / 35 7 + 2 1")
;-------------------------------------------------------------------------------
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;