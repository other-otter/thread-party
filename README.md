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
;first, plan the number of threads in the thread pool

(setf thread-party:*party-plan* 6) ;threads count 6

;or

(thread-party:make-plan 2) ;thread-count = 2 * your-cpu-core-number 

```

## start-party
```common-lisp
;create the thread pool
(thread-party:start-party) 

;or

(thread-party:main)

```

## have-party
```common-lisp
;send your message to the thread pool
;the default theme will evaluate the expression in the message
(thread-party:send-message '(* 1 2))

(let ((a 1))
    (thread-party:send-message `(* ,a 2)))

```

## party-theme
```common-lisp
;define your function handle the message in thread-pool
;all threads in pool is running this function
```
```common-lisp
;;theme-example-list
(defun list-length (the-message thread-number)
    (let ((the-value (length the-message))) ;the length of message
        (log:info "~%<~A>~t~A~%" thread-number the-value)))
        
(thread-party:set-theme #'list-length)

(thread-party:send-message '(* 1 2))
```
```common-lisp
;;theme-example-string
(defun reverse-string (the-message thread-number)
    (log:info "~%~A~t~A~%" thread-number (reverse the-message)))
  
(thread-party:set-theme #'reverse-string)

(thread-party:send-message "hi")
(thread-party:send-message "there")
```
```common-lisp
;;theme-example-number
(setf message-list '(100 200 300))
(setf value-list nil)

(defun add-hundred (the-message thread-number)
    (push (cons thread-number (+ 100 the-message)) value-list))

(thread-party:set-theme #'add-hundred)

(mapcar (lambda (a) (thread-party:send-message a)) message-list)

value-list
```
```common-lisp
;;define your more complex single function
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
