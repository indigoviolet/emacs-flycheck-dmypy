;;; flycheck-dmypy.el --- Support dmypy in flycheck


;;; Commentary:

;; This package adds support for dmypy to flycheck.  To use it, add
;; to your init.el:

;; (require 'flycheck-dmypy)
;; (add-hook 'python-mode-hook 'flycheck-mode)


;;; License:

;; This file is not part of GNU Emacs.
;; However, it is distributed under the same license.

;; GNU Emacs is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; GNU Emacs is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Code:
(require 'flycheck)


(defun flycheck-dmypy--find-project-root (_checker)
  (locate-dominating-file (or buffer-file-name default-directory) "mypy.ini"))

(flycheck-define-checker python-dmypy
  "Dmypy syntax checker.

See URL `http://mypy-lang.org/'."

  :command ("dmypy"
            "--status-file"
            "/tmp/flycheck-dmypy"
            "run"
            "--"
            source-original)            ;; source-inplace will make a copy
  :working-directory flycheck-dmypy--find-project-root
  :error-patterns
  ((error line-start (file-name) ":" line (optional ":" column) ": error:" (message) line-end)
   (warning line-start (file-name) ":" line (optional ":" column) ": warning:" (message) line-end)
   (info line-start (file-name) ":" line (optional ":" column) ": note:" (message) line-end))
  :modes python-mode)

(add-to-list 'flycheck-checkers 'python-dmypy t)

(provide 'flycheck-dmypy)
;;; flycheck-dmypy.el ends here
