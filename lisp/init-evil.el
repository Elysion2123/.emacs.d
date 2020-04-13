;;; init-evil.el --- Bring vim back -*- lexical-binding: t -*-

;;; Commentary:
;;

;;; Code:

(use-package evil
  :ensure t
  :hook (after-init . evil-mode)
  :bind (:map evil-normal-state-map
         ("M-." . xref-find-definitions))
  :custom
  (evil-ex-interactive-search-highlight 'selected-window)
  (evil-disable-insert-state-bindings t)
  (evil-want-fine-undo t)
  (evil-want-C-u-scroll t)
  (evil-want-Y-yank-to-eol t)
  (evil-want-abbrev-expand-on-insert-exit nil)
  (evil-symbol-word-search t))

;; See https://github.com/emacs-evil/evil/issues/1074
(use-package undo-fu
  :ensure t
  :bind (([remap undo] . undo-fu-only-undo)
         ([remap redo] . undo-fu-only-redo))
  :config
  (with-eval-after-load 'undo-tree
    (global-undo-tree-mode -1))
  )

(use-package evil-leader
  :ensure t
  :custom (evil-leader/leader "<SPC>")
  :hook (after-init . global-evil-leader-mode))

(use-package evil-nerd-commenter
  :ensure t
  :bind ("M-;" . evilnc-comment-or-uncomment-lines))

(use-package evil-surround
  :ensure t
  :hook ((prog-mode markdown-mode conf-mode) . evil-surround-mode))

(use-package evil-magit
  :ensure t
  :after evil magit)

(provide 'init-evil)

;;; init-evil.el ends here
