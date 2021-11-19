(global-set-key "\C-h" 'backward-delete-char-untabify)
(setq column-number-mode t)
(setq inhibit-startup-screen t)
(setq-default show-trailing-whitespace t)
(setq-default indent-tabs-mode nil)
(setq-default c-basic-offset 4)
(setq-default lua-indent-level 2)
(setq-default css-indent-offset 2)
(show-paren-mode 1)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(when (file-exists-p "/opt/local/share/emacs/site-lisp")
  (add-to-list 'load-path "/opt/local/share/emacs/site-lisp/")
  )

(unless (package-installed-p 'leaf)
  (package-refresh-contents)
  (package-install 'leaf))

(leaf leaf-keywords
  :ensure t
  :init
  (leaf el-get :ensure t)
  :config
  (leaf-keywords-init))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(lsp-haskell-server-path "~/.ghcup/bin/haskell-language-server-wrapper")
 '(package-selected-packages
   '(dockerfile-mode tuareg tide rainbow-delimiters dumb-jump smartparens flycheck-pos-tip flycheck company-quickhelp company el-get leaf-keywords leaf lua-mode sml-mode proof-general yaml-mode lsp-ui lsp-haskell lsp-mode haskell-mode))
 '(safe-local-variable-values '((buffer-file-coding-system . utf-8-unix))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

; haskell-mode
(leaf haskell-mode :ensure t)
(setenv "PATH" (concat (getenv "HOME") "/.local/bin" path-separator (getenv "PATH")))
(setenv "PATH" (concat (getenv "HOME") "/.ghcup/bin" path-separator (getenv "PATH")))
(if (file-exists-p "~/.local/bin/stylish-haskell")
    (set-variable 'haskell-mode-stylish-haskell-path "~/.local/bin/stylish-haskell")
  (if (file-exists-p "~/.cabal/bin/stylish-haskell")
      (set-variable 'haskell-mode-stylish-haskell-path "~/.cabal/bin/stylish-haskell")
    nil
  )
  )

; https://github.com/emacs-lsp/lsp-haskell#emacs-configuration
(leaf lsp-mode :ensure t)
(leaf lsp-haskell :ensure t)
(add-hook 'haskell-mode-hook #'lsp)
(add-hook 'haskell-literate-mode-hook #'lsp)

(leaf yaml-mode :ensure t)

(leaf lua-mode :ensure t)

(leaf rainbow-delimiters :ensure t)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

(leaf tide :ensure t)
(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  (company-mode +1))
(add-hook 'typescript-mode-hook #'setup-tide-mode)

;; Based on https://github.com/yonta/sml-emacs/blob/main/.emacs.d/init.el
;; See also https://qiita.com/keita44_f4/items/b15c3af240914345d0d3

;; company-mode
;; https://company-mode.github.io/
(leaf company :ensure t
  :defvar company-backends
  :global-minor-mode global-company-mode
  :custom
  (company-selection-wrap-around . t)      ; 補完候補で上下をループする
  (company-tooltip-align-annotations . t)) ; 補完リストの型を右揃えで整列する

;; company-quickhelp
;; https://github.com/company-mode/company-quickhelp
(leaf company-quickhelp :ensure t
  :config
  (company-quickhelp-mode))

;; flycheck
;; https://www.flycheck.org/en/latest/
(leaf flycheck :ensure t
  :defvar flycheck-checkers flycheck-checker
  :global-minor-mode global-flycheck-mode)

;; flycheck-pos-tip
;; https://github.com/flycheck/flycheck-pos-tip
(leaf flycheck-pos-tip :ensure t
  :after flycheck
  :custom
  (flycheck-pos-tip-timeout . 0) ; pos-tipを自動で消さない
  :config
  (flycheck-pos-tip-mode))

;; sml-mode
;; https://www.smlnj.org/doc/Emacs/sml-mode.html
(leaf sml-mode :ensure t
  ;; :hook (sml-mode-hook . (lambda () (setq-local flycheck-checker 'smlsharp)))
  :defun sml-prog-proc-proc sml-prog-proc-send-string
  :init
  (defun sml-prog-proc-send-region-by-string (begin end)
    (interactive "r")
    (let ((proc (sml-prog-proc-proc))
          (code (buffer-substring begin end)))
      (sml-prog-proc-send-string proc code)))
  :bind (:sml-mode-map
         ("C-c C-r" . sml-prog-proc-send-region-by-string))
  :custom ((sml-electric-pipe-mode . nil)))

;; company-mlton
;; https://github.com/MatthewFluet/company-mlton
(leaf company-mlton
  :el-get (company-mlton
           :url "https://github.com/MatthewFluet/company-mlton.git")
  :config
  (push
   '(company-mlton-keyword company-mlton-basis :with company-dabbrev-code)
   company-backends)
  :hook
  (sml-mode-hook . company-mlton-basis-autodetect))

;; flycheck-smlsharp
;; https://github.com/yonta/flycheck-smlsharp
(leaf flycheck-smlsharp
  :if (executable-find "smlsharp")
  :el-get (flycheck-smlsharp
           :url "https://github.com/yonta/flycheck-smlsharp.git")
  :after sml-mode
  :require t)

;; flycheck-mlton
;; https://gist.github.com/yonta/80c938a54f4d14a1b75146e9c0b76fc2
(leaf flycheck-mlton
  :if (executable-find "mlton")
  :el-get gist:80c938a54f4d14a1b75146e9c0b76fc2:flycheck-mlton
  :after sml-mode
  :require t
  :config
  (add-to-list 'flycheck-checkers 'mlton))

;; smartparens
;; https://github.com/Fuco1/smartparens
;(leaf smartparens :ensure t
;  :defun sp-local-pair
;  :global-minor-mode smartparens-global-mode
;  :config
;  (sp-local-pair 'sml-mode "(*" "*)")
;  (sp-local-pair 'sml-mode "'" nil :actions nil)
;  (sp-local-pair 'sml-mode "`" nil :actions nil)
;  (sp-local-pair 'inferior-sml-mode "(*" "*)")
;  (sp-local-pair 'inferior-sml-mode "'" nil :actions nil)
;  (sp-local-pair 'inferior-sml-mode "`" nil :actions nil))

;; dumb-jump
;; https://github.com/jacktasia/dumb-jump
(leaf dumb-jump :ensure t
  :hook (xref-backend-functions . dumb-jump-xref-activate))

;; OCaml: tuareg-mode
(leaf tuareg :ensure t)

;; Dockerfile
(leaf dockerfile-mode :ensure t)

;;; emacs-init.el ends here
