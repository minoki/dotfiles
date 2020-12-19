(global-set-key "\C-h" 'backward-delete-char-untabify)
(setq column-number-mode t)
(setq show-trailing-whitespace t)
(setq inhibit-startup-screen t)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(when (file-exists-p "/opt/local/share/emacs/site-lisp")
  (add-to-list 'load-path "/opt/local/share/emacs/site-lisp/")
  )

(add-hook 'css-mode-hook
	  (lambda ()
	    (setq css-indent-offset 2)
	    ))

(add-hook 'c-mode-common-hook
	  (lambda ()
	    (setq c-basic-offset 4)
	    (setq indent-tabs-mode nil)
	    ))

(add-hook 'js-mode-hook
	  (lambda ()
	    (setq indent-tabs-mode nil)
	    ))

(add-hook 'typescript-mode-hook
	  (lambda ()
	    (setq indent-tabs-mode nil)
	    ))

(add-hook 'lua-mode-hook
	  (lambda ()
	    (setq lua-indent-level 2)
	    (setq indent-tabs-mode nil)
	    ))
