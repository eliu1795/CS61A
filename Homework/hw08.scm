(define (rle s)
  (define (tracking elem s len)
    (cond 
        ((null? s) 
        (cons-stream ;(cons-stream (arg1) (arg2))!! piazza~
                (list elem len) () ))

        ((= elem (car s))
            (tracking elem 
                (cdr-stream s) 
                    (+ 1 len) )) 

    (else 
        (cons-stream 
            (list elem len) 
            (rle s)) )
        ))

    (cond(
        (null? s) ())
        (else(tracking (car s) 
                    (cdr-stream s) 1) )  
    ))


(define (group-by-nondecreasing s)

    (define (stream-maker item str)
        (cond 
            ((null? str)
            (cons-stream item () ))
            (else(cons-stream item (group-by-nondecreasing str) )) )
            )

    (define (listing lst i prev)
        (cond 
            ((or (null? i ) (> prev (car i )))
            (stream-maker lst i ))
            (else(listing (append lst (list (car i ))) (cdr-stream i ) (car i )) ) )
            )

    (listing 
            (list (car s)) 
            (cdr-stream s) 
            (car s))
    )


(define finite-test-stream
    (cons-stream 1
        (cons-stream 2
            (cons-stream 3
                (cons-stream 1
                    (cons-stream 2
                        (cons-stream 2
                            (cons-stream 1 nil))))))))

(define infinite-test-stream
    (cons-stream 1
        (cons-stream 2
            (cons-stream 2
                infinite-test-stream))))

