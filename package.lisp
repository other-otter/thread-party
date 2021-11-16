(in-package :cl-user)

(defpackage #:thread-party
    (:use :cl :cl-user)
    (:export *party-queue*
             *party-list*
             *party-plan*
             *party-theme*
             make-plan
             default-theme
             set-theme
             send-message
             start-party
             close-party
             list-thread
             main))
