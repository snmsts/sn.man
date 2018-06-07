(uiop/package:define-package :sn.man/main (:nicknames :sn.man) (:use :cl)
                             (:shadow) (:export :man) (:intern))
(in-package :sn.man/main)
;;don't edit above

(defun which (command)
  ;;tbd test on windows.
  (string-right-trim
   (format nil "~%")
   (with-output-to-string (o)
     (uiop:run-program (format nil (or #+windows "cmd /c where ~A"
                                       "command -v ~A")
                               command) :ignore-error-status t :output o))))

(defparameter *which-man* nil)

(defun man (entry &key output-format section)
  (declare (ignore output-format))
  (when (or *which-man*
            (setf *which-man* (which "man")))
    (with-output-to-string (o)
      (uiop:run-program (format nil "man ~A ~S"
                                (or section "")
                                entry)
                        :ignore-error-status t
                        :output o))))
