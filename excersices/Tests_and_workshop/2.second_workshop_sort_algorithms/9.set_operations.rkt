;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |9.ejercicio - operaciones de conjuntos|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;9)
;Un conjunto, es una colección de objetos donde no importa el orden, y tampoco
;si están o no repetidos. Ejemplo A={1,2,3} y B={3,1,2,1,2,3}, es claro que A=B.
;Sobre los conjuntos se definen algunas operaciones como la intersección que
;consiste de un conjunto que incluye los elementos comunes; la unión que es el
;conjunto de los elementos comunes y no comunes y la diferencia (A-B) que
;consiste de un conjunto que incluye los elementos que pertenecen a A, pero que
;no pertenecen a B. Se requieren programas que reciban listas que representen a
;dos conjuntos A y B y permitan realizar las operaciones de conjunto descritas, es
;decir:
;     a. Verificar si los conjuntos son iguales
;     b. La unión entre los conjuntos
;     c. La intersección entre los conjuntos
;     d. La diferencia entre el primer conjunto y el segundo
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;Defincicion de datos
;Las siguientes listas nos serviran para desarrollar ejemplos
(define lista1 (list 32 52 89 21 0 99 32 25 28 31))
(define lista2 (list 52 89 32 21 0 52 0 99 31 25 28 99))
(define lista3 (list 1 2 3))
(define lista4 (list 2 3 4 5 6))




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;a) Verificar si los conjuntos son iguales
;dadas las condiciones del enunciado para que dos conjuntos sean iguales no importa
;el orden ni tampoco si estan repetidos o no. para cubrir esta necesidad utilizaremos
;algun metodo de ordenamiento que ademas me elimine elementos repetidos (solo dejar los originales),
;para poder comparar las dos listas. para ello necesitaremso de las siguientes funciones auxiliares
;
;
;Funciones auxiliares
;-------------------------------------------------------------------------------
;contrato: menores: list number -> list
;proposito: se recibe como argumento una lista y un numero y se devuelve una lista
;       con los numero menores a ese numero
;plantilla: (define (menores lista numero)...)
;ejemplos
;cuerpo
(define (menoresQue lista numero)
  (cond
    [(empty? lista) empty]
    [(< (first lista) numero) (cons (first lista) (menoresQue (rest lista) numero))]
    [else (menoresQue (rest lista) numero)]
    )
  )
;pruebas
(check-expect (menoresQue lista1 25) (list 21 0))
;-------------------------------------------------------------------------------
;-------------------------------------------------------------------------------
;contrato: mayoresQue: list number -> list
;proposito: se recibe como argumento una lista y un numero y se devuelve una lista con los
;      numeros mayores a ese numero
;plantilla (define (mayoresQue lista numero)...)
;ejemplos:
;       (mayoresQue lista1 25) debe retornar (list 32 52 89 0 99 32 28 31)
;cuerpo:
(define (mayoresQue lista numero)
  (cond
    [(empty? lista) empty]
    [(> (first lista)  numero) (cons (first lista) (mayoresQue (rest lista) numero))]
    [else (mayoresQue (rest lista) numero)]
    )
  )
;pruebas
(check-expect (mayoresQue lista1 25) (list 32 52 89 99 32 28 31))
;-------------------------------------------------------------------------------
;-------------------------------------------------------------------------------
;contrato: quickSortM: lista -> lista
;proposito: ordenar una lista siguiendo el algoritmo de quicksort. Con una pequeña
;           modificación es que aquellos elementos iguales se eliminan sus repeticiones
;plantilla: (define (quickSort lista)...)
;ejemplo:
;      (quickSortM lista1) debe retornar (list 0 21 25 28 31 32 52 89 99)
;cuerpo:
(define (quickSortM lista)
  (cond
    [(empty? lista) empty]
    [else (append
               (quickSortM (menoresQue lista (first lista)))
               (cons (first lista) empty)
               (quickSortM (mayoresQue lista (first lista))
           ))]
    )
  )
;pruebas
(check-expect (quickSortM lista1) (list 0 21 25 28 31 32 52 89 99))
;-------------------------------------------------------------------------------
;-------------------------------------------------------------------------------
;contrato: compararElementos: list list -> boolean
;proposito: comaprar los elementos de una lista para saber si se trata de listas
;          Iguales
;plantilla: (define (compararElementos list1 list2)...)
;ejemplos
;      (compararElementos (list 1 2 3 4 5 6 7 8) (list 1 2 3 4 5 6 7 8)) debe retornar true
;      (compararElementos (list 14 654 164) (list 8013 13481 548 140)) debe retornar false
;cuerpo
(define (compararElementos list1 list2)
  (cond
    [(and (empty? list1) (empty? list2)) true]
    [(equal? (first list1) (first list2))(compararElementos (rest list1) (rest list2))]
    [else false]
    )
  )
;pruebas
(check-expect (compararElementos (list 1 2 3 4 5 6 7 8) (list 1 2 3 4 5 6 7 8)) true)
(check-expect (compararElementos (list 14 654 164) (list 8013 13481 548 140)) false)
;-------------------------------------------------------------------------------
;
;
;
;Funcion principal
;###############################################################################
;contrato: conjuntosIguales?: list list -> boolean
;proposito: Verificar si dos listas o cojuntos son iguales
;plantilla: (define (conjuntosIguales? list1 list2)...)
;ejemplos:
;      (conjuntosIguales? lista1 lista2) debe retornar true
;      (conjuntosIguales? lista2 lista3) debe retornar false
;cuerpo:
(define (conjuntosIguales? list1 list2)
  (compararElementos (quickSortM list1) (quickSortM list2))
  )
;pruebas
(check-expect (conjuntosIguales? lista1 lista2) true)
(check-expect (conjuntosIguales? (list 3 7 2472590 24802 18410 1308) (list 0814 313 43 13)) false)
;###############################################################################
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;









;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;b) La unión entre los conjuntos
;nota: para fines educativos se utiliza recursión, ya que podriamos hacer mas sencillo
;este programa utilizando la función (append <list1> ... <list-n>) para cocatenar
;n-listas
;-------------------------------------------------------------------------------
;contrato: union: list list -> list
;proposito: realizar la union de dos conjuntos, es decir concatenar listas
;plantilla: (define (union list1 list2)...)
;ejemplos
(define (union list1 list2)
  (cond
    [(empty? list1)
     (cond
       [(empty? list2) empty]
       [else (cons (first list2) (union list1 (rest list2)))]
       )
     ]
    [else (cons (first list1) (union (rest list1) list2))]
    )
  )
;pruebas
(check-expect (union lista3 lista4) (list 1 2 3 2 3 4 5 6))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;








;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;c) La intersección entre los conjuntos

;Funciones auxiliares
;------------------------------------------------------------------------------
;contrato: pertenece?: number list -> boolean
;proposito: hacer una funcion que reciba como argumentos un numero y una lista
;         y devolver true si el numero pertenece a la lista, si no no
;plantilla: (define (pertenece? elemento lista)...)
;ejemplos:
;       (pertenece? empty (list empty)) debe retornar true
;       (pertence? 2 (list 1 2 3 4)) debe retornar true
;       (pertenece? 32 (list 1 2) debe retornar false
;cuerpo:
(define (pertenece? elemento lista)
  (cond
    [(empty? lista) false]
    [(equal? elemento (first lista)) true]
    [else (pertenece? elemento (rest lista))]
    )
  )
;pruebas
(check-expect (pertenece? empty (list empty)) true)
(check-expect (pertenece? 2 (list 1 2 3 4)) true)
(check-expect (pertenece? 32 (list 1 2)) false)
;------------------------------------------------------------------------------
;
;
;Funcion principal
;###############################################################################
;contrato: intersection: list list -> list
;proposito: Hacer una funcion que se le igresen dos listas (onjuntos) y me retorne
;          la interseccion de estas mismas
;plantilla:  (define (intersection list1 list2)...)
;ejemplos:
;       (intersection (list 1 2 3 4) (list 3 4 5 6)) debe retornar (list 3 4)
;cuerpo
(define (intersection list1 list2)
  (cond
    [(or (empty? list1) (empty? list2)) empty]
    [(pertenece? (first list1) list2) (cons (first list1) (intersection (rest list1) list2))]
    [else (intersection (rest list1) list2)]
    )
  )
;pruebas
(check-expect (intersection (list 1 2 3 4) (list 3 4 5 6)) (list 3 4))
;###############################################################################
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;






;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;d) La diferencia entre el primer conjunto y el segundo
;contrato: diferencia: list list -> list
;proposito: Hacer una funcion que efectue la diferencia entre dos conjuntos (listas)
;          que le pasamos como argumeno. Utilizaremos una función auxiliar llamda
;          (pertenece? ) que ya habiamos declarado en este archivo para otro ejercicio
;          de operacion de conjuntos
;plantilla: (define (diferencia list1 list2)....)
;ejemplos
;        (diferencia (list 1 2 3 4) (list 3 4 5 6 7 8)) debe retornar (list 1 2)
;contrato
(define (diferencia list1 list2)
  (cond
    [(empty? list1) empty]
    [(not (pertenece? (first list1) list2)) (cons (first list1) (diferencia (rest list1) list2))]
    [else (diferencia (rest list1) list2)]
    )
  )
;pruebas
(check-expect (diferencia (list 1 2 3 4) (list 3 4 5 6 7 8)) (list 1 2))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;