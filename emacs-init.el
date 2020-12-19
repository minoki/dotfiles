(global-set-key "\C-h" 'backward-delete-char-untabify)
(setq column-number-mode t)
(setq show-trailing-whitespace t)
(setq inhibit-startup-screen)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
