# thread-party
```text
easy thread pool with package bordeaux-threads and lparallel.queue, has fashionable symbol name

```

## load-package
```common-lisp
(load "~/quicklisp/setup.lisp")

(ql:quickload :thread-party)

```

## party-plan
```common-lisp
;plan the number of threads in the thread pool
(setf thread-party:*party-plan* 6) ;threads count 6

;or according to the multiple of cpu core count
(thread-party:make-plan 2) ;thread-count = 2 * your-cpu-core-number 

```

## start-party
```common-lisp
;create the thread pool
(thread-party:start-party) 

;or use main function
(thread-party:main)

```

## have-party
```common-lisp
;send your message to the thread pool
;the default theme will evaluate the expression in the message

;;numerical value
(thread-party:send-message '(* 1 2))

;;local value
(let ((a 1))
    (thread-party:send-message `(* ,a 2)))

;;use in function
(defun the-multiplication (a b)
    (thread-party:send-message `(* ,a ,b)))
    
(the-multiplication 1 2)

```

## party-theme
```common-lisp
;default-theme will eval the form in the message
;you can define your function handle the message in thread-pool
;all threads in pool is running this function

```
```common-lisp
;;theme-example-list-length
(defun list-length (the-message thread-number)
    (let ((the-value (length the-message))) ;the length of message
        (log:info "~%<~A>~t~A~%" thread-number the-value)))
        
(thread-party:set-theme #'list-length)

(thread-party:send-message '(* 1 2))

```
```common-lisp
;;theme-example-reverse-string
(defun reverse-string (the-message thread-number)
    (log:info "~%~A~t~A~%" thread-number (reverse the-message)))
  
(thread-party:set-theme #'reverse-string)

(thread-party:send-message "hi")
(thread-party:send-message "lisp")

```
```common-lisp
;;theme-example-number-addition
(setf message-list '(100 200 300))
(setf value-list nil)

(defun add-hundred (the-message thread-number)
    (push (list :thread thread-number :message the-message :vaule (+ 100 the-message)) 
          value-list))

(thread-party:set-theme #'add-hundred)

(mapcar (lambda (a) (thread-party:send-message a)) message-list)

value-list

```
```common-lisp
;;define your more powerful function
;;;for example a function to determine whether it is a prime number
(defun a (b)
  (if (<= b 1)
      nil
      (c b (1- b))))

(defun c (d e)
  (if (= e 1)
      (progn (push d f)
             (values d t))
      (if (= 0 (mod d e))
          nil
          (c d (1- e)))))
          
;;;use-default-theme-example
(thread-party:set-theme #'thread-party:default-theme)

(setf f nil)

(loop for i from 1 to 100 do
    (thread-party:send-message `(a ,i)))

(symbol-value 'f)

;;;use-function-as-party-theme-example
(defun a (b thread-number) ;redefine function #'a that take the parameter
  (if (<= b 1)
      nil
      (c b (1- b))))

(thread-party:set-theme #'a)

(setf f nil)

(loop for i from 1 to 100 do
    (thread-party:send-message i))

(symbol-value 'f)

```

## thread-list
```common-lisp
;show all the threads 
(thread-party:list-thread)

;show the threads in thread-pool
thread-party:*party-list*

;check thread count
(equal (length thread-party:*party-list*) thread-party:*party-plan*)

```

## close-party
```common-lisp
(thread-party:close-party)

```

## usage
```common-lisp
;;parameter
;thread-party::*party-queue*
;thread-party::*party-list*
;;function
;thread-party::make-plan core-multiple
;thread-party::set-theme function-symbol
;thread-party::send-message message-form
;thread-party::start-party
;thread-party::close-party
;thread-party::list-thread
;thread-party::main
```

## more
```common-lisp
;https://lparallel.org/api/queues/
;https://sionescu.github.io/bordeaux-threads/
;https://github.com/7max/log4cl
;https://github.com/muyinliu/cl-cpus
;https://lispcookbook.github.io/cl-cookbook/
```
