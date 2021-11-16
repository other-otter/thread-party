(ql:quickload :thread-party)

(setf thread-party::*party-plan* 6)

(thread-party::start-party)

(loop for i from 1 to 100 do 
    (lparallel.queue:push-queue i thread-party::*party-queue*))
