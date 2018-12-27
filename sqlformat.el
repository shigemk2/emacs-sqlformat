;;; sqlformat.el --- Emacs Lisp using sqlformat to format SQL in the current buffer.
;; Author: shigemk2
;; URL: https://github.com/shigemk2/sqlformat
;; Package-Requires: (request)
;; Keywords: sqlformat
;; Version: 0.1
;; MIT License
;;
;; Copyright (c) 2017 Michihito Shigemura
;;
;; Permission is hereby granted, free of charge, to any person obtaining a copy
;; of this software and associated documentation files (the "Software"), to deal
;; in the Software without restriction, including without limitation the rights
;; to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
;; copies of the Software, and to permit persons to whom the Software is
;; furnished to do so, subject to the following conditions:
;;
;; The above copyright notice and this permission notice shall be included in all
;; copies or substantial portions of the Software.
;;
;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
;; IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
;; FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
;; AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
;; LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
;; OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
;; SOFTWARE.

;;; Summary:

;; Emacs Lisp using sqlformat to format SQL in the current buffer with sqlparse (https://github.com/andialbrecht/sqlparse).

;;; Require:
;; sql-format (https://github.com/andialbrecht/sqlparse)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; var-setting
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defvar sqlformat-command "sqlformat")
(defvar sqlformat-reindent "--reindent")
(defvar sqlformat-keywords "upper")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Command
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;###autoload
(defun sqlformat-buffer ()
  "Uses the \"sqlformat\" tool to reformat the current buffer."
  (interactive)
  (if (>= (string-to-number (shell-command-to-string "python -c \"import sys; sys.stdout.write(str(sys.version_info.major));\"")) 3)
      (setq sqlformat (concat sqlformat-command
                              " "
                              sqlformat-reindent
                              " --keywords "
                              sqlformat-keywords
                              " "
                              buffer-file-name))
    ;; for python 2
    (setq sqlformat (concat "export PYTHONIOENCODING=utf-8;"
                            sqlformat-command
                            " "
                            sqlformat-reindent
                            " --keywords "
                            sqlformat-keywords
                            " "
                            buffer-file-name)))
  (erase-buffer)
  (message sqlformat)
  (call-process-shell-command
   sqlformat
   nil t)
  (sql-mode)
  )

(provide 'sqlformat)
;;; sqlformat.el ends here
