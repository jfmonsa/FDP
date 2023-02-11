;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |3.Ejercicio - Calcular distancia recorrida (Teorema de Pitagoras y MRU)|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; TRABAJO REALIZADO POR: JUAN FELIPE MONSALVE VARGAS
#|
EJERCICIO
    Desarrolla una función que calcule la distancia que recorre una nadadora a través de un río,
    dada la anchura del río, la velocidad de la nadadora perpendicular al río y la velocidad del río.
    La velocidad es distancia/tiempo, y el teorema de Pitágoras es  c2 = a2 + b2.




ESTRATEGIA DE DISEÑO
1.Proposito (Entender)
   1.1. Contrato:   calcularDistanciaRecorrida: anchuraRio -> velocidadRio -> velocidadNadadora
   1.2. Proposito: El objetivo del programa es calcular cual fue la distancia que recorrio la nadadora
        tratando de cruzar hasta el otro lado del rio cuando fue desvida por este mismo
   1.3. Plantilla:
      (define (dRecorrida anchuraRio velocidadNadadora velocidadRio)
        ;Cuerpo de nuestro programa
       )
2.Ejemplo
 (dRecorrida 45 3 5) debo esperar #i87.46427842267951     <--- Ejemplo propuesto por el profe en la clase
 (dRecorrida 10 5 7) debo esperar #i17.204650534085253    <--- Mi ejemplo
3.Codigo |#

   (define (dRecorrida anchuraRio velocidadNadadora velocidadRio)
     (sqrt (+ (sqr anchuraRio) (sqr (* velocidadRio (/ anchuraRio velocidadNadadora) ))))
   )
   
#|4.Pruebas
En este caso la prueba es la del ejemplo. debido a que con la funcion (checkexpect) no podemos comparar valores
inexactos. entonces coloco lo mismo que en el ejemplo

 (dRecorrida 10 5 7) debo esperar #i17.204650534085253    <--- Mi ejemplo
|#