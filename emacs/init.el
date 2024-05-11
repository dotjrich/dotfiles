;;
;; init.el - Emacs configuration file
;; dotjrich
;;

;; Load package.el.
(require 'package)

;; MELPA.
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/"))

(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))

(when (and
       (= emacs-major-version 26)
       (< emacs-minor-version 3))
  ;; Seen issues with gnutls compatibility on older emacs installs (Debian and CentOS).
  ;; This seems to fix it up.
  (setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3"))

;; Init package.el.
(package-initialize)

;; Set Consolas font and start Emacs server on Windows.
(when (string-equal system-type "windows-nt")
  (set-face-attribute 'default nil :family "Consolas" :height 110)
  (server-start))

;; Disable splash screen.
(setq inhibit-splash-screen t)

;; Disable tool-bar and menu-bar.
(if (fboundp 'tool-bar-mode)
    (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode)
    (menu-bar-mode -1))

;; Set Firefox as the browser to use.
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "firefox")

;; Ido Mode
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

;; Set theme.
;(load-theme 'cyberpunk t)

;; Show column numbers.
(setq column-number-mode t)

;; Handle tabs... use 4 spaces, not tab characters.
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq-default c-basic-offset 4) ; C, C++, Java.

;; Disable automatic backups.
(setq make-backup-files nil)

;; C-x t to move to top of buffer, C-x e to move to end of buffer.
(global-set-key "\C-xt" 'beginning-of-buffer)
(global-set-key "\C-xe" 'end-of-buffer)

;;(global-set-key "\C-w" 'backward-kill-word)
;;(global-set-key "\C-x\C-k" 'kill-region)

;; Enable WindMove.
(windmove-default-keybindings)

;; Enable Winner mode.
(winner-mode)

;; Enable auto-complete mode.
;(ac-config-default)

;; Delete trailing whitespace on save.
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Enable company mode.
(require 'company)
(add-hook 'after-init-hook #'global-company-mode)

;; eglot stuff
(add-hook 'go-mode-hook 'eglot-ensure)
(add-hook 'python-mode-hook 'eglot-ensure)

(global-set-key "\C-cp" 'flymake-show-project-diagnostics)

;; Function to open current buffer in an external program.
(defun jrich-open-in-external-program ()
  "Open current buffer in an external program."
  (interactive)
  (when buffer-file-name
    (shell-command (concat
                    "xdg-open"
                    " "
                    (shell-quote-argument buffer-file-name)))))

;; C-c o to open buffer in external program.
(global-set-key "\C-co" 'jrich-open-in-external-program)

;; C-c r to revert buffer.
(global-set-key "\C-cr" 'revert-buffer)

;; C-c n to open Neotree.
(global-set-key "\C-cn" 'neotree-toggle)

;; Try to keep init.el pristine... especially from package-selected-packages in custom-set-variables.
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file :noerror)

;; Leave timestamp when closing TODOs in Org Mode.
(setq org-log-done 'time)

;; Open with all headings collapsed.
(setq org-startup-folded t)

;; C-c a a to open Org Mode Agenda view (with n option).
(defun jrich-org-show-agenda-and-all-todos (&optional arg)
  "Show Org Mode agent with all TODOs."
  (interactive)
  (org-agenda arg "n"))
(global-set-key "\C-caa" 'jrich-org-show-agenda-and-all-todos)

;; C-c a t to open todo.org.
(defun jrich-org-open-todo-file()
  "Open todo.org."
  (interactive)
  (find-file "~/Documents/todo.org"))
(global-set-key "\C-cat" 'jrich-org-open-todo-file)
