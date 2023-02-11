;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 1.ejercicio) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;1.
;. Escriba una función en Racket que reciba una lista de números enteros y retorne
;una estructura datosLista, que contenga la suma, la cantidad y el promedio de los
;números de la lista.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;definición de los datos
;Utilizaremos las siguientes listas para hacer las pruebas de escritorio
;para verificar que los programas que construyamos esten funcionando correctamente
(define lista1 (list 1 2 3 4 5 6 7 8 9 10))
(define lista2 (list 2 4 6 8 10))



;Utilizaremos la siguiente estructura que sera retornada por nuestra
;función
(define-struct datosLista (sumatoria cantidadDeDatos promedio))
;Esta estructura tendra disponibles las siguientes operaciones
;(make-datosLista <number> <number> <number>) para crear la estructura
;(datosLista-...  ...) para seleccionar elementos ej: (datosLista-sumatoria)
;(datosLista? ...) como predicar para comprobar la estructura


;Funciones auxiliares
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;sumatoria)
;------------------------------------------------------------------------------
;contrato: sumatoriaLista: list -> number
;proposito: sumar todos los elementos de una lista
;plantilla: (define (sumatoriaLista listt) ...)
;ejemplos:
;    (sumatoriaLista lista1) debe retornar 55
;cuerpo
(define (sumatoriaLista listt)
  (cond
    [(empty? listt) 0]
    [else (+ (first listt)(sumatoriaLista (rest listt)))]
    )
  )
;pruebas
(check-expect (sumatoriaLista lista1) 55)
;------------------------------------------------------------------------------
;cantidad de datos)
;------------------------------------------------------------------------------
;contrato: cantidadDatos: list -> number
;proposito: contar el numero de datos almacenados por una lista
;plantilla: (define (cantidadDatos listt)...)
;ejemplos
;    (cantidadDatos lista1) debe retornar 10
;cuerpos
(define (cantidadDatos listt)
  (cond
    [(empty? listt) 0]
    [else (+ 1 (cantidadDatos (rest listt)))]
    )
  )
;pruebas
(check-expect (cantidadDatos lista1) 10)
;------------------------------------------------------------------------------







;Funcion principal
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;contrato: procesarLista: list -> datosLista
;proposito: Seguir el enunciado
;plantilla: (define (procesarLista listt).. )
;ejemplos
;     (procesarLista lista1) debe retornar (make-datosLista 55 10 5.5)
;cuerpo
(define (procesarLista listt)
  (make-datosLista
   (sumatoriaLista listt)
   (cantidadDatos listt)
   (/ (sumatoriaLista listt) (cantidadDatos listt))
   )
)
;pruebas
(check-expect (procesarLista lista1) (make-datosLista 55 10 5.5))
