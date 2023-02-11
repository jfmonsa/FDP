;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |1.Ejercio - Teorema pitagoras|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Ejercicios -- Clase 1

|# 1. Desarrolle un programa que calcule la hipotenusa de un
triángulo rectángulo.#|

(define (teoremaPitagoras c1 c2)
  (sqrt (+ (expt c1 2) (expt c2 2)))
)

|# 2. Desarrolle un programa que calcule el perímetro de un
cuadrado. #|

(define (perimetroRectangulo ancho largo)
  (+ (* 2 ancho)(* 2 largo))
)


#|
Desarrolle un programa que determine si un numero es par o no

Las opciones para hacer esto es con 
    1.Dividir por el modulo 2 y tiene que ser igual a 0
    2.Dividir por 2 y el residuo tiene que ser numero 0
    3.Con la funcion (odd? <numero>) o (even? <numero>)) 
|#
(define (isEvenNumber? num)
  (cond
   [ (even? num) "el numero es par"]
   [else "el numero es impar"] 
  ))