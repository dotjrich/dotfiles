;
; init.el - Emacs configuration file
; dotjrich
;

; Load package.el.
(require 'package)

; MELPA.
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))

; Init package.el.
(package-initialize)

; Disable splash screen.
(setq inhibit-splash-screen t)

; Disable tool-bar and menu-bar.
(if (fboundp 'tool-bar-mode)
    (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode)
    (menu-bar-mode -1))

; Set theme.
(load-theme 'cyberpunk t)

; Show column numbers.
(setq column-number-mode t)

; Handle tabs... use 4 spaces, not tab characters.
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq-default c-basic-offset 4) ; C, C++, Java.

; Disable automatic backups.
(setq make-backup-files nil)

; C-x t to move to top of buffer, C-x e to move to end of buffer.
(global-set-key "\C-xt" 'beginning-of-buffer)
(global-set-key "\C-xe" 'end-of-buffer)

;(global-set-key "\C-w" 'backward-kill-word)
;(global-set-key "\C-x\C-k" 'kill-region)

; Enable WindMove.
(windmove-default-keybindings)

; Enable auto-complete mode.
(ac-config-default)

; Delete trailing whitespace on save.
;(add-hook 'before-save-hook 'delete-trailing-whitespace)

; Function to open current buffer in an external program.
(defun jrich-open-in-external-program ()
  "Open current buffer in an external program."
  (interactive)
  (when buffer-file-name
    (shell-command (concat
                    "xdg-open"
                    " "
                    (shell-quote-argument buffer-file-name)))))

; C-c o to open buffer in external program.
(global-set-key "\C-co" 'jrich-open-in-external-program)

; C-c r to revert buffer.
(global-set-key "\C-cr" 'revert-buffer)
