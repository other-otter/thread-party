(in-package :thread-party)

(setf *party-queue* (lparallel.queue:make-queue))

(defvar *party-list* '())

(defun make-plan (the-number)
	(let ((core-number (cpus:get-number-of-processors)))
		(if (<= the-number 0)
			(setf *party-plan* 2)
			(setf *party-plan* (floor (* the-number core-number))))))

(defun set-theme (the-function-symbol)
    (setf *party-theme* the-function-symbol))

(defun default-theme (the-message thread-number)
    (eval the-message))

(set-theme #'default-theme)

(defun send-message (the-message)
    (lparallel.queue:push-queue the-message *party-queue*))

(defun start-party ()
    (loop for i from 1 to *party-plan* do (eval 
        `(push 
            (bordeaux-threads:make-thread (lambda () 
                (loop 
                    (let ((the-message (lparallel.queue:pop-queue *party-queue*)))
                        (funcall *party-theme* the-message ,i)))))
            *party-list*))))

(defun close-party ()
    (mapcar (lambda (a) (bordeaux-threads:destroy-thread a)) *party-list*))

(defun list-thread ()
    (bordeaux-threads:all-threads))

(defun main ()
    (start-party))
