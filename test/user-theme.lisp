(ql:quickload :thread-party)

(setf thread-party::*party-plan* 6)

(thread-party::start-party)

(defun a (b)
  (if (<= b 1)
      nil
      (c b (1- b))))

(defun c (d e)
  (if (= e 1)
      (progn (push d f)
             (values t d))
      (if (= 0 (mod d e))
          nil
          (c d (1- e)))))

(defun a (b thread-number)
  (if (<= b 1)
      nil
      (c b (1- b))))

(thread-party:set-theme #'a)

(setf f nil)

(loop for i from 1 to 100 do
    (thread-party:send-message i))

(symbol-value 'f)
