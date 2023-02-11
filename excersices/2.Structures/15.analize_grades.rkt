;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |15.Ejercicio complicado= Estructuras comparar tres notas|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Un profesor desea ver el despeño de un esptudiante segun la nota final del
;peridodo. Los datos de un estudiante vienen en una estructura con:
;nombre, codigo y nota final
;El desempeño del estudiante se calsifica de la siguiente manera:
;superior para la nota de 4.6
;Alto para la nota 4 a 4.5
;Basico para la nota de 3 a 3.9
;Bajo para las notas de 1 a 2.9
;Se trata entonces de escribir un programa donde:
; 1. Se definan al menos 3 variables para estudiantes
; 2. Una fución para que, dado un estudiante se indique el desempeño
; 3. Una función que reciba tres estudiantes y retorne una estructura con el
;    nombre de los estudiantes con más alta y más baja nota final
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;1)
;Definicion de datos
(define-struct estudiante (nombre codigo notaFinal))
;Para la estructura estudiante estaran disponiles;
;(make-fecha <string>(nombre) <number>(codigo) <number>(notaFinal) ) constructor de la estructura fecha
;(estudiante-nombre ...)(estudiante-codigo ...) (estudiante-notaFinal ...) para selecionar los campos
;(estudiante? variable) Para determinar si la variable es de tipo estudiante
(define e1 (make-estudiante "Pepito" 202101 4.5))
(define e2 (make-estudiante "Jose" 202102 2.5))
(define e3 (make-estudiante "Rosa" 202103 5))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;2) Funcion para el desempeño
;Contrato: performanceEstudiante: estudiante (estructura) ->  "su desempeño fue" (string)
;proposito: Seguier el enunciado en el numeral 2
;plantilla: (define (performanceEstudiante est)...)
;ejemplos
;    (performanceEstudiante e1) debe retornar "Desempeño Alto"
;    (performanceEstudiante e2) debe retornar "Desempeño Bajo"
;    (performanceEstudiante e3) debe retornar "Desempeño Superior"
;Cuerpo
(define (performanceEstudiante est)
  (cond
    [(>= (estudiante-notaFinal est) 4.6) "Desempeño Superior"]
    [(and (>= (estudiante-notaFinal est) 4) (<= (estudiante-notaFinal est) 4.5)) "Desempeño Alto"]
    [(and (>= (estudiante-notaFinal est) 3)(<= (estudiante-notaFinal est) 3.9)) "Desempeño Basico"]
    [else "Desempeño Bajo"]
    )
  )
;pruebas
(check-expect (performanceEstudiante e1) "Desempeño Alto")
(check-expect (performanceEstudiante e2) "Desempeño Bajo")
(check-expect (performanceEstudiante e3) "Desempeño Superior")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;







;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;Mejor Estudiantes
;Contrato: mejorEstudiante: estudiante estudiante estudiante -> string
;Proposito: Saber cual es el mejor estudiante
;plantillas (define (mejorEstudiante est1 est2 est3)...)
;ejemplos
;    (mejorEstudiante est1 est2 est3) debe retornar "Rosa"
;Cuerpo
(define (mejorEstudiante est1 est2 est3)
 (cond
   [(=(max
       (estudiante-notaFinal est1)
       (estudiante-notaFinal est2)
       (estudiante-notaFinal est3)
       )
    (estudiante-notaFinal est1)
    )
    (estudiante-nombre est1)
   ]
   [(=(max
       (estudiante-notaFinal est1)
       (estudiante-notaFinal est2)
       (estudiante-notaFinal est3)
       )
    (estudiante-notaFinal est2)
    )
    (estudiante-nombre est2)
   ]
   [else (estudiante-nombre est3)]
   )
 )
;Prueba
(check-expect (mejorEstudiante e1 e2 e3) "Rosa")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;peor Estudiantes
;Contrato: mejorEstudiante: estudiante estudiante estudiante -> string
;Proposito: Saber cual es el mejor estudiante
;plantillas (define (mejorEstudiante est1 est2 est3)...)
;ejemplos
;    (mejorEstudiante est1 est2 est3) debe retornar "Rosa"
;Cuerpo
(define (peorEstudiante est1 est2 est3)
 (cond
   [(=(min
       (estudiante-notaFinal est1)
       (estudiante-notaFinal est2)
       (estudiante-notaFinal est3)
       )
    (estudiante-notaFinal est1)
    )
    (estudiante-nombre est1)
   ]
   [(=(min
       (estudiante-notaFinal est1)
       (estudiante-notaFinal est2)
       (estudiante-notaFinal est3)
       )
    (estudiante-notaFinal est2)
    )
    (estudiante-nombre est2)
   ]
   [else (estudiante-nombre est3)]
   )
 )
;Prueba
(check-expect (peorEstudiante e1 e2 e3) "Jose")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;3)
;Definicion de datos
(define-struct top (nombreCalificacionMasAlta  nombreCalificacionMasBaja))
;contrato: topEstudiante: estudiante estudiante estudiante -> top
;proposito: Una función que reciba tres estudiantes y retorne una estructura con el
;    nombre de los estudiantes con más alta y más baja nota final
;Plantilla: (define (topEstudiante est1 est2 est3)...)
;ejemplos
; (topEstudiante e1 e2 e3) debe retornar (make-top "El mejor estudiante fue: Rosa" "El peor estudiante fue: Jose")
;cuerpo
(define (topEstudiante est1 est2 est3)
  (make-top 
             (string-append "El mejor estudiante fue: " (mejorEstudiante est1 est2 est3))
             (string-append "El peor estudiante fue: " (peorEstudiante est1 est2 est3)
  )))
  
;pruebas
(check-expect (topEstudiante e1 e2 e3)  (make-top "El mejor estudiante fue: Rosa" "El peor estudiante fue: Jose"))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;