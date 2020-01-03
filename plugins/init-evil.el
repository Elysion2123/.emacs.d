;;; init-evil.el --- Bring vim back

;;; Commentary:
;;

;;; Code:

(use-package evil
  :ensure t
  :hook (after-init . evil-mode)
  :config
  (setcdr evil-insert-state-map nil)
  :bind (:map evil-motion-state-map
         ("C-u" . scroll-down-command)
         :map evil-insert-state-map
         ([escape] . evil-normal-state)
         :map evil-normal-state-map
         ("M-." . xref-find-definitions)
         ))

(use-package evil-surround
  :ensure t
  :hook (prog-mode . evil-surround-mode))

(use-package evil-magit
  :ensure t)

(provide 'init-evil)

;;; init-evil.el ends here
