
(defsystem #:mcclim-clx-fb
  :depends-on (#:mcclim-backend-common
               #:mcclim-clx/basic
               #:mcclim-clx/input
               #:mcclim-render
               #:mcclim-render/clx)
  :components
  ((:file "package")
   (:file "port" :depends-on ("package" "medium"))
   (:file "frame-manager" :depends-on ("port" "package" "mirrored-sheets"))
   (:file "medium" :depends-on ("package"))
   (:file "mirror" :depends-on ("port" "package"))
   (:file "mirrored-sheets" :depends-on ("port" "package" "mirror"))))


