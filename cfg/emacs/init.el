(add-to-list 'default-frame-alist '(font . "Cartograph CF 10"))
(set-face-attribute 'default t :font "Cartograph CF 10")
(set-face-attribute 'default nil :font "Cartograph CF 10")
(set-frame-font "Cartograph CF 10" nil t)

(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)

(use-package evil :ensure t :init
  (evil-mode +1))

  (load "~/.config/emacs/syntax.el")
