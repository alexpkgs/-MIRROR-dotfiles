;; init.el -*- lexical-binding: t; -*-

(package-initialize)
(require 'use-package)

(add-to-list 'load-path (expand-file-name "./lisp" user-emacs-directory))

(setq user-full-name "nuxsh"
      user-mail-address "nuxshed@gmail.com")

(setq use-short-answers t
      frame-inhibit-implied-resize t
      initial-major-mode 'fundamental-mode
      file-name-handler-alist nil)

(setq inhibit-message t)
(defun suppress-errors (func)
  (ignore-errors (funcall func)))
(setq display-buffer-alist
      '(("*Messages*" display-buffer-no-window)))
(setq warning-suppress-log-types '((emacs)))



(use-package gcmh
  :init
  (gcmh-mode 1))

(recentf-mode 1)
(setq recentf-max-saved-items 25)

(require 'init-evil)
(require 'init-org)
(require 'init-layout)
(require 'ui)
(require 'prog)
(require 'completion)
(require 'prettify-symbols)

(use-package init-mail
  :ensure nil
  :load-path "~/.emacs.d/lisp/init-mail.el"
  :commands mu4e)

(use-package publish
  :ensure nil
  :load-path "~/.emacs.d/lisp/publish.el"
  :commands (org-publish-project org-publish-all))

;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(marginalia hotfuzz vertico company-box company-quickhelp company-statistics company format-all consult-flycheck flycheck cider lispy lua-mode nix-mode clojure-mode smartparens which-key vterm consult good-scroll doom-themes all-the-icons-ibuffer ace-window deft htmlize org-bullets org-contrib evil-leader evil-collection evil gcmh)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
