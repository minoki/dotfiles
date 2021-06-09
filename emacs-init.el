(global-set-key "\C-h" 'backward-delete-char-untabify)
(setq column-number-mode t)
(setq show-trailing-whitespace t)
(setq inhibit-startup-screen t)
(setq-default indent-tabs-mode nil)

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
	    ))

(add-hook 'lua-mode-hook
	  (lambda ()
	    (setq lua-indent-level 2)
	    ))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(lsp-haskell-server-path "~/.ghcup/bin/haskell-language-server-wrapper")
 '(package-selected-packages
   '(dumb-jump smartparens flycheck-pos-tip flycheck company-quickhelp company el-get leaf-keywords leaf lua-mode sml-mode proof-general yaml-mode lsp-ui lsp-haskell lsp-mode haskell-mode)))
 '(safe-local-variable-values '((buffer-file-coding-system . utf-8-unix))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

; haskell-mode
(setenv "PATH" (concat (getenv "HOME") "/.local/bin" path-separator (getenv "PATH")))
(setenv "PATH" (concat (getenv "HOME") "/.ghcup/bin" path-separator (getenv "PATH")))
(set-variable 'haskell-mode-stylish-haskell-path "~/.local/bin/stylish-haskell")

; https://github.com/emacs-lsp/lsp-haskell#emacs-configuration
(require 'lsp)
(require 'lsp-haskell)
(add-hook 'haskell-mode-hook #'lsp)
(add-hook 'haskell-literate-mode-hook #'lsp)
