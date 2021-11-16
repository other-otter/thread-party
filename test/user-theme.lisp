(ql:quickload :thread-party)

(thread-party::make-plan 2)

(thread-party::start-party)

(loop for i from 1 to 100 do 
    (lparallel.queue:push-queue i *party-queue*))
