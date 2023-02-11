;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 4.Ejercicio) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Nombre: Juan Felipe Monsalve Vargas
;codigo Estudiante: 202160145
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;4) (TIPO PARCIAL)
;Una empresa tiene el registro de los clientes que atiende con los siguientes
;datos: Documento de identidad, nombre, sexo, edad, peso (kilogramos), estatura (metros) y Última
;compra (valor y fecha).
;
;Teniendo en cuenta estos datos, la empresa necesita un programa que incluya lo siguiente:
;a. Definir variables para 4 clientes con sus respectivos datos
;b. Función para mostrar la fecha de última compra de un cliente
;c. Función para mostrar el valor de última compra de un cliente
;d. Función para ingresar documento de identidad de tres clientes y determinar cuál de ellos
;compro más
;e. Función para validar si dos estructuras clientes son iguales
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;0)Definicion de datos
;-------------------------------------------------------------------------------
(define-struct ultimaCompra (valor fecha))
;Para ultimaCompra estaran disponibles las siquientes operaciones
;constructor: (make-ultimaCompra <number> <string>)
;Selector: (ultimaCompra-valor ...)(ultimaCompra-fecha ...)
;predicado: (ultimaCompra? ...)
;-------------------------------------------------------------------------------
(define-struct registro (id nombre sexo edad pesoKG  estaturaMetros ultimaCompra))
;Para la estructura registro tenemos las siguientes operaciones
;constructor (make-registro <num> <str> <str> <num> <num> <num> ultimaCompra(estructura))
;Selector: (ultimaCompra-valor ...)... (ultimaCompra-estaturaMetros ...)
;predicado: (registro?)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;a) Definicion de variables
(define c1 (make-registro 1006493077 "Juan Felipe Monsalve Vargas" "Masculino" 18 63 1.78 (make-ultimaCompra 29000 "8/5/2021")))
(define c2 (make-registro 1006493079 "Hernan David Monsalve" "Masculino" 22 60 1.63 (make-ultimaCompra 10000 "8/8/2021")))
(define c3 (make-registro 32205676 "Maria Lucero Vargas" "Femenino" 60 63 1.65 (make-ultimaCompra 10000 "8/7/2021")))
(define c4 (make-registro 1 "Laureano Gomez" "Masculino" 66 66 1.65 (make-ultimaCompra 20000 "13/6/1965")))
(define c5 (make-registro 2 "Pepito Perez" "Masculino" 55 78 1.70 (make-ultimaCompra 10000 "10/10/2021")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;b)
;Contrato: fechaUltimaCompra: number -> string
;proposito: Mostrar la ultima compra de un cliente
;plantilla: (define (fechaUltimaCompra id)...)
;Ejemplos
;    (fechaUltimaCompra 1006493077) debe retornar "8/5/2021"
;    (fechaUltimaCompra 1006493079) debe retornar "8/8/2021"
;    (fechaUltimaCompra 32205676) debe retornar "8/7/2021"
;    (fechaUltimaCompra 1) debe retornar "13/6/1965"
;Cuerpo
(define (fechaUltimaCompra id)
  (cond
    [(= id (registro-id c1)) (ultimaCompra-fecha (registro-ultimaCompra c1))]
    [(= id (registro-id c2)) (ultimaCompra-fecha (registro-ultimaCompra c2))]
    [(= id (registro-id c3)) (ultimaCompra-fecha (registro-ultimaCompra c3))]
    [(= id (registro-id c4)) (ultimaCompra-fecha (registro-ultimaCompra c4))]
    )
  )
;Pruebas
(check-expect (fechaUltimaCompra 1006493077) "8/5/2021")
(check-expect (fechaUltimaCompra 1006493079) "8/8/2021")
(check-expect (fechaUltimaCompra 32205676) "8/7/2021")
(check-expect (fechaUltimaCompra 1) "13/6/1965")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;c)
;Contrato: valorUltimaCompra: number -> number
;proposito: Función para mostrar el valor de última compra de un cliente
;plantilla: (define (valorUltimaCompra id)...)
;ejemplos:
;    (valorUltimaCompra 1006493077) debe retornar 29000
;    (valorUltimaCompra 1006493079) debe retornar 10000
;    (valorUltimaCompra 32205676) debe retornar 100000
;    (valorUltimaCompra 1) debe retornar 20000
;Cuerpo
(define (valorUltimaCompra id)
  (cond
    [(= id (registro-id c1)) (ultimaCompra-valor (registro-ultimaCompra c1))]
    [(= id (registro-id c2)) (ultimaCompra-valor (registro-ultimaCompra c2))]
    [(= id (registro-id c3)) (ultimaCompra-valor (registro-ultimaCompra c3))]
    [(= id (registro-id c4)) (ultimaCompra-valor (registro-ultimaCompra c4))]
    )
  )
;pruebas
(check-expect (valorUltimaCompra 1006493077) 29000)
(check-expect (valorUltimaCompra 1006493079) 10000)
(check-expect (valorUltimaCompra 32205676) 10000)
(check-expect (valorUltimaCompra 1) 20000)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;d)
;contrato: quienComproMas: number number number -> string
;proposito: Función para ingresar documento de identidad de tres clientes y
;           determinar cuál de ellos compro más. Nota: para cumplir este objetivo
;           vamos a usar como funcion auxiliar a valorUltimaCompra (función del punto c)
;plantilla (define (quienComproMas id1 id2 id3 id4)...)
;ejercicios
;     (quienComproMas 1006493077 1006493079 32205676) debe retornar "El cliente con cedula 1006493077 compro más"
;     (quienComproMas 1006493079 1006493077 32205676) debe retornar "El cliente con cedula 1006493077 compro más"
;     (quienComproMas 1006493079 32205676 1006493077) debe retornar "El cliente con cedula 1006493077 compro más"
;     (quienComproMas 1006493079 32205676 2) debe retornar "Todos los clientes ingresados han gastado la misma cantidad de dinero"
;cuerpo
(define (quienComproMas id1 id2 id3)
  (cond
    [
      (and (> (valorUltimaCompra id1) (valorUltimaCompra id2))
           (> (valorUltimaCompra id1) (valorUltimaCompra id3)
           ))
     (string-append "El cliente con cedula " (number->string id1) " compro más")]
    [
      (and (> (valorUltimaCompra id2) (valorUltimaCompra id1))
           (> (valorUltimaCompra id2) (valorUltimaCompra id3)
           ))
     (string-append "El cliente con cedula " (number->string id2) " compro más")]
    [
      (and (> (valorUltimaCompra id3) (valorUltimaCompra id1))
           (> (valorUltimaCompra id3) (valorUltimaCompra id2)
           ))
     (string-append "El cliente con cedula " (number->string id3) " compro más")]
    ;[else "Todos los clientes ingresados han gastado la misma cantidad de dinero"]
    )
  )
;pruebas
(check-expect (quienComproMas 1006493077 1006493079 32205676) "El cliente con cedula 1006493077 compro más")
(check-expect (quienComproMas 1006493079 1006493077 32205676) "El cliente con cedula 1006493077 compro más")
(check-expect (quienComproMas 1006493079 32205676 1006493077) "El cliente con cedula 1006493077 compro más")
;(check-expect (quienComproMas 1006493079 32205676 2) "Todos los clientes ingresados han gastado la misma cantidad de dinero")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;e)
;contrato: registro=?: registro registro -> boolean
;proposito: Función para validar si dos estructuras clientes son iguales
;plantilla (define (registro=? reg1 reg2)...)
;ejemplos
;(registro=? c1 c1) debe retornar true
;(registro=? c1 c2) debe retornar false
;cuerpo
;(define-struct registro (id nombre sexo edad pesoKG  estaturaMetros ultimaCompra))
(define (registro=? reg1 reg2)
   (cond
    [(not (and (registro? reg1) (registro? reg2))) false]
    [else
     (cond
    [(and
      (= (registro-id reg1) (registro-id reg2))
      (string=? (registro-nombre reg1) (registro-nombre reg2))
      (string=? (registro-sexo reg1) (registro-sexo reg2))
      (= (registro-edad reg1) (registro-edad reg2))
      (= (registro-pesoKG reg1) (registro-pesoKG reg2))
      (= (registro-estaturaMetros reg1) (registro-estaturaMetros reg2))
      (= (ultimaCompra-valor (registro-ultimaCompra reg1))
         (ultimaCompra-valor (registro-ultimaCompra reg2))
         )
      (string=? (ultimaCompra-fecha (registro-ultimaCompra reg1))
         (ultimaCompra-fecha (registro-ultimaCompra reg2))
         )
     )
     true]
    [else false]
    )
     ]
    )
  )
;pruebas
(check-expect (registro=? c1 c1) true)
(check-expect (registro=? c1 c2) false)
(check-expect (registro=? c1 "false") false)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;