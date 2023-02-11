;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |37.Entendiendo el concepto de acomulador - Ejercicio con listas,|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;hacer una función que retorne un elemento especificado de una lista, de acuerdo
;con su posición, si la lista tiene menos elementos del solicitado debe retornar
;el ultimo

;defincipon de los daots
(define lista1 (list 9 8 7 6 5 4 3 2 1 2 3 4 5 6 7 8 9 8 7 6 5 4 3 2 1 2 3 4 5 6 7 8 9))



;contrato: recoverElement: list n -> elmento
;proposito: seguir el enunciado
;plantilla: (define (recoverElement lista n)...)
;ejemplos
;      (recoverElement lista1 33) debe retornar 9
;cuerpo
(define (recuperarElemento lista n)
  (local
    ;Fución auxiliar
    (
     (define (contador lista)
       (cond
        [(empty? lista) 0]
        [else (+ 1 (contador (rest lista)))]
        )
       )
     )
    ;Función principal
    (cond
      [(empty? lista) empty]
      [(= n (contador lista)) (first lista)]
      [else (recuperarElemento (rest lista) n)]
    )
    )
  )
;pruebas
(check-expect (recuperarElemento lista1 33) 9)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;Podemos ver que tenemos otra solución que es mas eficiente por que no requiere
;de tanta recursión
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Solución mas eficiente:
(define (posicionEn lista n)
  (cond
    [(empty? lista)  empty]
    [(= n 1) (first lista)]
    [else (posicionEn (rest lista) (- n 1))]
    )
  )
;pruebas
(check-expect (posicionEn lista1 33) (recuperarElemento lista1 33))