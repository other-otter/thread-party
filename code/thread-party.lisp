(in-package :thread-party)

(defvar *party-plan* 2)
(defvar *party-queue* (lparallel.queue:make-queue))
(defvar *party-list* '())

(defun make-plan (the-number)
    (let ((core-number (cpus:get-number-of-processors)))
        (if (<= the-number 0)
            nil
            (setf *party-plan* (floor (* the-number core-number))))))

;(defvar *party-theme* nil)
(defun set-theme (the-function-symbol)
    (setf *party-theme* the-function-symbol))

(defun default-theme (the-message thread-number)
    (let ((the-value (eval the-message)))
        (log:info "~%~t[thread:~6<~A~;~>]~t~A~%" thread-number the-value)))

(set-theme #'default-theme)

(defun send-message (the-message)
    (lparallel.queue:push-queue the-message *party-queue*))

(defun start-party ()
    (loop for i from 1 to *party-plan* do 
        (let ((i i))
            (push 
                (bordeaux-threads:make-thread (lambda () 
                    (loop 
                        (let ((the-message (lparallel.queue:pop-queue *party-queue*)))
                            (funcall *party-theme* the-message i)))))
                *party-list*))))

(defun close-party ()
    (mapcar #'bordeaux-threads:destroy-thread *party-list*)
    (setf *party-list* nil))

(defun list-thread ()
    (bordeaux-threads:all-threads))

(defun main ()
    (start-party))

(defun plan-party (party-symbol-quote &key  (party-plan (cpus:get-number-of-processors))
                                            (party-list nil)
                                            (party-theme #'thread-party:default-theme) 
                                            (party-queue (lparallel.queue:make-queue)))
    (set party-symbol-quote (list   :party-plan     party-plan
                                    :party-list     party-list
                                    :party-theme    party-theme
                                    :party-queue    party-queue)))

(defun hold-party (party-symbol)
    (loop for i from 1 to (getf party-symbol :party-plan) do
        (let ((i i))
            (push 
                (bordeaux-threads:make-thread 
                    (lambda () 
                        (loop 
                            (let ((the-message (lparallel.queue:pop-queue (getf party-symbol :party-queue))))
                                (funcall (getf party-symbol :party-theme) the-message i)))))
                (getf party-symbol :party-list)))))

(defun sure-party (party-symbol party-theme)
    (setf (getf party-symbol :party-theme) party-theme))

(defun take-party (party-symbol the-message)
    (lparallel.queue:push-queue the-message (getf party-symbol :party-queue)))

(defun shut-party (party-symbol)
    (mapcar #'bordeaux-threads:destroy-thread (getf party-symbol :party-list))
    (setf (getf party-symbol :party-list) nil))
