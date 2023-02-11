;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 3.ejercicio) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Nombre: Juan Felipe Monsalve Vargas
;codigo Estudiante: 202160145
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;3)
;Un teatro necesita un programa que al ingresar el título de una película
;retorne los datos de la película
;•La película debe tener título, director, costo, hora, sala, clasificación
;(todos, adultos)y la dimensión.
;•Si la película es para adultos se debe agregar un mensaje que indique que
;la películano es apta para menores, esta clasificación solo se verá en horario
;nocturno (18:00).
;• Si la película se transmite en la mañana tendrá un 20% de descuento.
;• Si la película es en 3D se le sumara 7500 al costo.
;NOTA: El teatro cuenta con una lista de 4 películas
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;







;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;1 Definicion de datos
(define-struct teatroPeliculas (titulo director costo hora sala clasificacion dimension))
;1.1 Esta estructura almacenara cada pelicula que tenga el teatro
;La estructura teatroPeliculas tiene disponibles las siguientes operaciones
;1.1.1 Constructor (make-teatroPeliculas <str> <str> <num> <num> <str> <str> <str>)
;1.1.2 Selector: (teatroPeliculas-titulo) ... (teatroPeliculas-dimension)
;                Esta operacion esta disponible para todos los campos de la estructura
;1.1.3 Predicado: (teatroPeluclas? ...)
;-------------------------------------------------------------------------------
;1.1.4 estructuras de prueba para nuestro ejercicio:
     (define p1 (make-teatroPeliculas "Citizen Kane" "Orson welles" 50000 18.00 "A" "Adultos" "2D"))
     (define p2 (make-teatroPeliculas "Colombia Magia Salvaje" "ZZ" 20000 8.00 "B" "Todos " "3D"))
     (define p3 (make-teatroPeliculas "Rio Chiquito" "Jean-Pierre Sergent y Bruno Muel" 10000 13.00 "A" "Adultos" "2D"))
     (define p4 (make-teatroPeliculas "Matarife version documental" "Daniel Mendoza Leal" 10000 14.00 "B" "Adultos" "2D"))
;-------------------------------------------------------------------------------
(define-struct infoPeliculaParaUsuario (titulo director costo hora sala clasificacion dimension mensajeAdvertencia))
;1.2 Esta estructura "infoPeliculaParaUsuario" es la información que se mostrara al
;     usuario con todas las modificaciones que realiza el programa como descuentos
;     aumentos, cambios de horario y mensajes de advertencia
;Para la estructura infoPeliculaParaUsuario estaran disponibles las sgtes operaciones
; 1.2.1 Constructor: (make-infoPeliculaParaUsuario <str> <str> <num> <num> <str> <str> <str> <str>)
; 1.2.2 Selector: (infoPeliculaParaUsuario-titulo) ... (infoPeliculaParaUsuario-mensajeAdvertencia)
;       Este selector estara disponible para todos los usuarios
;1.2.3 predicado: (infoPeliculaParaUsuario? ...)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;2.Las siguientes son funciones auxiliares
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;2.1)
;;Contrato: calcularCostoPorHora: number number -> number 
;;Proposito: Calcular el costo de una pelicula teniendo en cuenta que si se
;;           Presenta entre las 6 y las 12 se hara un descuento del 20%
;;Plantilla: (define (calcularCostoPorHora costo hora)...)
;;Ejemplos:
;;  (calcularCostoPorHora 50000 18) debe retornar 50000
;;  (calcularCostoPorHora 20000 8) debe retornar 16000
;;Cuerpo:
(define (calcularCostoPorHora costo hora)
  (if (and (>= hora 6) (< hora 12))
      (- costo (* costo 0.20))
      costo
      )
  )
;;Pruebas:
(check-expect (calcularCostoPorHora 50000 18) 50000)
(check-expect (calcularCostoPorHora 20000 8) 16000)
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;2.2)
;;Contrato: calcularCostoPorDimension: number "string" -> number
;;Proposito: Si la dimension es igual a "3D" sumarle 7500 al costo
;;Plantilla: (define (calcularCostoPorDimension costo dimension)...)
;;Ejemplos:
;    (calcularCostoPorDimension 16000 "3D") debe retornar 23500
;    (calcularCostoPorDimension 50000 "2D") debe retornar 50000
;;Cuerpo:
(define (calcularCostoPorDimension costo dimension)
  (if (string=? dimension "3D")
      (+ costo 7500)
      costo
      )
  )
;;Pruebas
(check-expect (calcularCostoPorDimension 16000 "3D") 23500)
(check-expect (calcularCostoPorDimension 50000 "2D") 50000)
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;2.3)
;;Contrato: constructorPelicula: teatroPeliculas -> infoPeliculaParaUsuario
;;Proposito: devolver la estructura infoPeliculaParaUsuario segun la pelicula que
;;           Se requiera
;;Plantilla: (define (constructorPelicula pelicula)...)
;;Ejemplos:
;;     (constructorPelicula p1) debe retornar (make-infoPeliculaParaUsuario "Citizen Kane" "Orson welles" 50000 18 "A" "Adultos" "2D")
;;Cuerpo:
(define (constructorPelicula pelicula)
  (make-infoPeliculaParaUsuario
      (teatroPeliculas-titulo pelicula)
      (teatroPeliculas-director pelicula)
      ;costo
      (calcularCostoPorHora
        (calcularCostoPorDimension (teatroPeliculas-costo pelicula)
                                   (teatroPeliculas-dimension pelicula))
        (if (string=? (teatroPeliculas-clasificacion pelicula) "Adultos")
          18
          (teatroPeliculas-hora pelicula)
          ))
      ;hora
      (if (string=? (teatroPeliculas-clasificacion pelicula) "Adultos")
          18
          (teatroPeliculas-hora pelicula)
          )
      (teatroPeliculas-sala pelicula)
      (teatroPeliculas-clasificacion pelicula)
      (teatroPeliculas-dimension pelicula)
      (if (string=? (teatroPeliculas-clasificacion pelicula) "Adultos")
          "Pelicula no apta para menores"
          "Pelicula para toda la familia"
          )
    )
  )
;;Pruebas
(check-expect (constructorPelicula p1) (make-infoPeliculaParaUsuario "Citizen Kane" "Orson welles" 50000 18 "A" "Adultos" "2D" "Pelicula no apta para menores"))
(check-expect (constructorPelicula p2) (make-infoPeliculaParaUsuario "Colombia Magia Salvaje" "ZZ" 22000 8 "B" "Todos " "3D" "Pelicula para toda la familia"))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;3.La siguiente es la funcion principal que usa las demas funciones auxiliares
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;2.Contrato: infoPelicula: string -> infoPeliculaParaUsuario
;3.Proposito: Seguir el enunciado
;4.plantilla (define (infoPelicula titulo)...)
;5.ejemplos
;(infoPelicula "Citizen Kane") debe retornar (make-infoPeliculaParaUsuario "Citizen Kane" "Orson welles" 50000 18 "A" "Adultos" "2D" "Pelicula no apta para menores")
;(infoPelicula)
;6.Cuerpo
(define (infoPelicula titulo)
  (cond
    [(string=? titulo (teatroPeliculas-titulo p1)) (constructorPelicula p1)]
    [(string=? titulo (teatroPeliculas-titulo p2)) (constructorPelicula p2)]
    [(string=? titulo (teatroPeliculas-titulo p3)) (constructorPelicula p3)]
    [else (constructorPelicula p4)]
    )
  )
;pruebas
(check-expect (infoPelicula "Citizen Kane") (make-infoPeliculaParaUsuario "Citizen Kane" "Orson welles" 50000 18 "A" "Adultos" "2D" "Pelicula no apta para menores"))
(check-expect (infoPelicula "Colombia Magia Salvaje") (make-infoPeliculaParaUsuario "Colombia Magia Salvaje" "ZZ" 22000 8 "B" "Todos " "3D" "Pelicula para toda la familia"))
(check-expect (infoPelicula "Rio Chiquito") (make-infoPeliculaParaUsuario "Rio Chiquito" "Jean-Pierre Sergent y Bruno Muel" 10000 18 "A" "Adultos" "2D" "Pelicula no apta para menores"))
(check-expect (infoPelicula "Matarife version documental") (make-infoPeliculaParaUsuario "Matarife version documental" "Daniel Mendoza Leal" 10000 18 "B" "Adultos" "2D" "Pelicula no apta para menores"))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;