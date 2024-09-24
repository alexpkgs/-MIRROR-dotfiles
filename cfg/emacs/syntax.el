;; Ensure use-package is installed
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; Enable syntax highlighting globally
(global-font-lock-mode 1)

;; Lua
(use-package lua-mode
  :mode "\\.lua\\'")

;; Nix
(use-package nix-mode
  :mode "\\.nix\\'")

;; TypeScript
(use-package typescript-mode
  :mode "\\.tsx?\\'")

;; HTML
(use-package web-mode
  :mode "\\.html?\\'")

;; JSON and JSONC
(use-package json-mode
  :mode "\\.json\\'"
  :config
  (setq json-mode-show-console t))
;; CSS
(use-package css-mode
  :mode "\\.css\\'")


;; C/C++
(use-package cc-mode
  :mode ("\\.c\\'" . c-mode)
  :mode ("\\.cpp\\'" . c++-mode)
  :mode ("\\.h\\'" . c-mode)
  :mode ("\\.hpp\\'" . c++-mode))

;; C#
(use-package csharp-mode
  :mode "\\.cs\\'")


;; Perl
(use-package perl-mode
  :mode "\\.pl\\'")

;; PHP
  :mode "\\.php\\'"
  :config
  (setq php-mode-coding-style 'psr2) ;; Optional: Set PHP coding style

;; Roff
  :mode "\\.[1-9]\\'"
  :mode "\\.man\\'"
  :mode "\\.mdoc\\'"
  :config
  (setq nroff-mode-fill-column 72) ;; Optional: Set fill column for nroff

;; Markdown
(use-package markdown-mode
  :mode ("\\.md\\'" . markdown-mode)
  :config
  (setq markdown-command "pandoc")) ;; Optional: Set the command for Markdown processing

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)
