;;; init-lsp.el --- The completion engine and lsp client -*- lexical-binding: t -*-

;;; Commentary:
;;

;;; Code:

;; The completion engine
(use-package company
  :ensure t
  :diminish company-mode
  :defines (company-dabbrev-downcase company-dabbrev-ignore-case)
  :hook (prog-mode . company-mode)
  :bind (:map company-active-map
         ("C-p" . company-select-previous)
         ("C-n" . company-select-next)
         ("<tab>" . company-complete-common-or-cycle)
         :map company-search-map
         ("C-p" . company-select-previous)
         ("C-n" . company-select-next))
  :config
  ;; Use Company for completion
  (bind-key [remap completion-at-point] #'company-complete company-mode-map)
  (setq company-tooltip-align-annotations t
        company-show-numbers t  ;; Easy navigation to candidates with M-<n>
        company-idle-delay 0.05
        company-dabbrev-downcase nil
        company-dabbrev-ignore-case nil)
  :diminish company-mode)

(use-package lsp-mode
  :ensure t
  :hook (prog-mode . lsp-deferred)
  :init (setq flymake-fringe-indicator-position 'right-fringe)
  :custom
  (lsp-auto-guess-root t)
  (lsp-keep-workspace-alive nil) ;; auto kill lsp server
  (lsp-prefer-flymake nil)
  (lsp-enable-snippet nil)
  :bind (:map lsp-mode-map
         ("C-c f" . lsp-format-region))
  :commands lsp)

(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode
  :defines lsp-ui-sideline-code-action-prefix
  :hook (lsp-mode . lsp-ui-mode)
  :bind (:map lsp-ui-mode-map
         ([remap xref-find-definitions] . lsp-ui-peek-find-definitions)
         ([remap xref-find-references] . lsp-ui-peek-find-references)
         ("C-c C-a" . lsp-ui-sideline-apply-code-actions))
  :config
  (setq
    ;; doc
    lsp-ui-doc-enable nil
    lsp-ui-doc-max-height 30
    lsp-ui-doc-max-width 60
    lsp-ui-doc-header nil
    lsp-ui-doc-include-signature nil
    ;; sideline
    lsp-ui-sideline-enable t
    lsp-ui-sideline-ignore-duplicate t
    lsp-ui-sideline-show-hover nil
    lsp-ui-sideline-show-symbol nil
    lsp-ui-sideline-show-diagnostics t
    lsp-ui-sideline-show-code-actions t
    ;; flycheck
    lsp-ui-flycheck-enable t))

(use-package company-lsp
  :ensure t
  :after lsp-mode
  :config
  (setq company-transformers nil
        company-lsp-cache-candidates 'auto))

(use-package lsp-ivy
  :ensure t
  :after lsp-mode
  :bind (:map lsp-mode-map
         ([remap xref-find-apropos] . lsp-ivy-workspace-symbol)))

(provide 'init-lsp)

;;; init-lsp.el ends here
