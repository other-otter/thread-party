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
(thread-party:send-message '(* 1 2))

```

## party-theme
```common-lisp
;define your function handle the message in thread-pool
(defun the-list-length (the-message thread-number)
    (let ((the-value (length the-message))) ;the length of message
        (log:info "~%<~A>~t~A~%" thread-number the-value)))
        
(thread-party:set-theme #'the-list-length)

(thread-party:send-message '(* 1 2))

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

