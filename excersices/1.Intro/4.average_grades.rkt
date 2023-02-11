;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Revisar lo antes posible - ultimo ejercicio|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
   #|
        1.Proposito 
            1.1. Contrato =   notasPromedio: numero numero numero numero -> numero
                                             codMateria parcial1 parcial2 quiz -> notaFinal
            1.2. Proposito = Calcular la nota final de una materia de un alumno, para esto se le debe ingresar el numero
                            De la materia, nota1, nota2 y nota del quizz
            1.3. Plantilla:
                (define (notasPromedio codMateria parcial1 parcial2 quiz) 
                    (cond
                    [(= codMateria) (+ (* parcial1 <porcentaje>) (* parcial2 <porcentaje>) (* quiz <porcentaje>))]
                    [(= codMateria) (+ (* parcial1 <porcentaje>) (* parcial2 <porcentaje>) (* quiz <porcentaje>))]
                    [(= codMateria) (+ (* parcial1 <porcentaje>) (* parcial2 <porcentaje>) (* quiz <porcentaje>))]
                    [(= codMateria) (+ (* parcial1 <porcentaje>) (* parcial2 <porcentaje>) (* quiz <porcentaje>))]
                    [else -1]
                    )
                )
            2.Ejemplo
                (notasPromedio 1 4 3 3.5) debe retornar 3.5
                (notasPromedio 2 4 3 3.5) debe retornar 3.65
                (notasPromedio 3 4 3 3.5) debe retornar 3.4
                (notasPromedio 4 4 3 3.5) debe retornar 3.75
                (notasPromedio 6 4 3 3.5) debe retornar -1
            3.Codigo |#
                   (define (notasPromedio codMateria parcial1 parcial2 quiz) 
                    (cond
                    [(= codMateria 1) (+ (* parcial1 0.3) (* parcial2 0.3) (* quiz 0.4))]
                    [(= codMateria 2) (+ (* parcial1 0.5) (* parcial2 0.3) (* quiz 0.2))]
                    [(= codMateria 3) (+ (* parcial1 0.25) (* parcial2 0.45) (* quiz 0.30))]
                    [(= codMateria 4) (+ (* parcial1 0.7) (* parcial2 0.2) (* quiz 0.1))]
                    [else -1 #|Devuelve un condigo de error que retornara la funcion que la procese
                            para no romper el contrato al devolver un tipo de dato diferente a numero
                    |#]
                    )
                )
            ;4.pruebas
            (check-expect (notasPromedio 1 4 3 3.5) 3.5)
            (check-expect (notasPromedio 2 4 3 3.5) 3.6)
            (check-expect (notasPromedio 3 4 3 3.5) 3.4)
            (check-expect (notasPromedio 4 4 3 3.5) 3.75)
            (check-expect (notasPromedio 6 4 3 3.5) -1)
