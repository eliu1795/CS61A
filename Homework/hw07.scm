(define (cddr s)
  (cdr (cdr s)))

(define (cadr s)
  (car (cdr s))
)

(define (caddr s)
  (car (cdr (cdr s)))
)

(define (sign num)
  (cond
    ((= num  0) 0)
    ((< num  0) -1)
    ((> num 0) 1))
)


(define (square x) (* x x))

(define (pow x y)
  (cond
    ((= y 0) 1)
    ((= y 1) x)
    ((even? y)
    (square(pow x(/ y 2))))
    (else 
    (* x (square (pow x(/ (- y 1) 2)))))
  )
)


(define (unique s)
  (if
  (null? s) ()
  (cons (car s)
  (filter(lambda (b) (not (equal? b (car s))))
  (unique (cdr s)))))
)


(define (replicate x n)

  (define (reverse-tail x n lst)
  (cond((equal? n 0) lst) 
      (else (reverse-tail x (- n 1)(cons x lst)))))
      (reverse-tail x n ())
)

(define (accumulate combiner start n term)
  (if (< n 1) start 
    (combiner (term n) 
              (accumulate combiner 
                    start(- n 1) 
                    term))
  )
)

(define (accumulate-tail combiner start n term)
  (define (helper n value)
   (if 
      (<= n 0) value
      (helper (- n 1) 
            (combiner (term n) 
                        value
                        )
                        )
    ))
  (helper n start)
)

(define-macro (list-of map-expr for var in lst if filter-expr)
  `(map 
        (lambda (,var) ,map-expr) 
        (filter (lambda (,var) ,filter-expr) ,lst)
        )
)

