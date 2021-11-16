(asdf:defsystem :thread-party
     :description "easy thread pool with fashionable name"
     :version "0.0.1"
     :author "@other-otter"
     :depends-on (:lparallel
                  :cl-cpus
                  :log4cl)
     :components ((:file "package")
                  (:module code
                   :serial t
                   :components ((:file "thread-party")))))
