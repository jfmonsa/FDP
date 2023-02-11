;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |12. Generar una factura - Estructuras|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;desarrollar una funcion que reciba una estructura del vehiculo,
;  el cual fue atendio en nuestra vulcanizadora y para el cual debe
;  retornarse una factura con los datos del vehiculo. EL vehicula podra
;  ser una moto (placa, numero de llantas) o podra ser un auto (placa cilindraje
;  numero de llantas) o camion (placa numeroDeEjes numeroLLantas) al cobrar
;  los valores son así: para motos se cobra $7000, para los autos se cobra a
;  $8000 por llanta si el cilindraje es hasta 1600 y $8500 por llanta para cilindrajes
;  mayores; y para los camiones se cobra $10000 por llanta si el carro tiene hasta 3 ejes
;  y a $11000 si tiene mas ejes
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;1. Definicion de datos
(define-struct moto (placa llantas))
(define-struct auto (placa cilindraje llantas))
(define-struct camion (placa ejes llantas))
(define-struct factura (placa valor))

(define m1 (make-moto "NH95C" 1))
(define a1 (make-auto "CNC726" 1200 2))
(define c1 (make-camion "TTW321" 4 2))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;2.Proposito (Fucion para facturar una moto)
;  2.1 contrato: facturarMoto: estructura (moto) -> estructura (factura)
;  2.2 Proposito: Crear una funcion que genere estructura con la factura de
;     de un servicio para moto segun el enunciado
; 2.3 Plantilla: (define (facturarMoto m)...)
;3.Ejemplo
;(facturarMoto m1) debe retornar (make-factura "NH95C" 7000)
;4.Cuerpo
(define (facturarMoto vehiculo)
  (make-factura (moto-placa vehiculo) (* 7000 (moto-llantas vehiculo)))
  )
;5.Pruebas
(check-expect (facturarMoto m1) (make-factura "NH95C" 7000))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;2.Proposito
;  2.1.Contrato: facturarAuto: auto -> factura
;  2.2.Proposito: Crear la factura del servicio de un carro segun el enunciado
;  2.3. Plantilla: (define (facturarAuto a)...)
;3.Ejemplos
;(facturarServicio a1) debe retornar (make-factura "CNC726" 16000)
;4.Cuerpo
(define (facturarAuto vehiculo)
(make-factura (auto-placa vehiculo)
              (if (< 1600(auto-cilindraje vehiculo))
                  (* 8500 (auto-llantas vehiculo))
                  (* 8000 (auto-llantas vehiculo))))
  )
;5.Pruebas
(check-expect (facturarAuto a1) (make-factura "CNC726" 16000))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;2.Proposito
; 2.1.Contrato: facturarCamion: camion -> auto
; 2.2.Objetivo: Generar la factura de un servicio de carro segun el enunciado
; 2.3.Plantilla: (define (facturarCamion camion)...)
;3.Ejemplos
;4.Cuerpo
(define (facturarCamion vehiculo)
  (make-factura (camion-placa vehiculo) (if (< (camion-ejes vehiculo) 3)
                                            (* (camion-llantas vehiculo) 10000)
                                            (* (camion-llantas vehiculo) 11000)
                                            ))
  )
;5.Pruebas
(check-expect (facturarCamion c1) (make-factura "TTW321" 22000)) 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;2.Proposito (Fucicion principal)
;  2.1 contrato: facturarServicio: estructura (vehiculo) -> estructura (factura)
;  2.2 Objetivo: Hacer una funcion que me genere una estructura factura teniendo en
;   Cuenta las condiciones del enunciado anterior
;  2.3 Plantilla: (define (facturarServicio estructura))
;3. Ejemplos:
;  (facturarServicio m1) debe retornar (make-factura "NH95C" 7000)
;  (facturarServicio a1) debe retornar (make-factura "CNC726" 16000)
;  (facturarServicio c1) debe retornar (make-factura "TTW321" 22000)
;4.Cuerpo
(define (facturarServicio vehiculo)
  (cond
    [(moto? vehiculo) (facturarMoto vehiculo)]
    [(auto? vehiculo) (facturarAuto vehiculo)]
    [else (facturarCamion vehiculo)]
    )
  )
;5.Pruebas
(check-expect (facturarServicio m1) (make-factura "NH95C" 7000))
(check-expect (facturarServicio a1) (make-factura "CNC726" 16000))
(check-expect (facturarServicio c1) (make-factura "TTW321" 22000))