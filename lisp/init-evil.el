;;; init-evil.el --- Bring vim back -*- lexical-binding: t -*-

;;; Commentary:
;;

;;; Code:

(use-package evil
  :ensure t
  :hook (after-init . evil-mode)
  :bind (:map evil-normal-state-map
         ("gs" . evil-avy-goto-char-timer)
         ("go" . evil-avy-goto-word-or-subword-1)
         ("gl" . evil-avy-goto-line))
  :custom
  ;; Switch to the new window after splitting
  (evil-split-window-below t)
  (evil-vsplit-window-right t)
  (evil-ex-complete-emacs-commands nil)
  (evil-ex-interactive-search-highlight 'selected-window)
  (evil-disable-insert-state-bindings t)
  (evil-insert-skip-empty-lines t)
  (evil-want-integration t)
  (evil-want-keybinding nil)
  (evil-want-fine-undo t)
  (evil-want-C-g-bindings t)
  (evil-want-Y-yank-to-eol t)
  (evil-want-abbrev-expand-on-insert-exit nil)
  (evil-symbol-word-search t)
  :config
  (evil-ex-define-cmd "q[uit]" 'kill-this-buffer))

(use-package evil-collection
  :ensure t
  :hook (evil-mode . evil-collection-init)
  :custom
  (evil-collection-company-use-tng nil)
  (evil-collection-outline-bind-tab-p t)
  (evil-collection-term-sync-state-and-mode-p nil)
  (evil-collection-setup-minibuffer nil)
  (evil-collection-setup-debugger-keys nil)
  :config
  ;; Disable `evil-collection' in certain modes
  (dolist (ig-mode '(mu4e
                     mu4e-conversion
                     vterm))
    (setq evil-collection-mode-list (remove ig-mode evil-collection-mode-list)))

  ;; Keybindings tweaks
  (evil-collection-define-key 'normal 'occur-mode-map
    ;; consistent with ivy
    (kbd "C-c C-e") 'occur-edit-mode)
  )

(use-package evil-leader
  :ensure t
  :custom (evil-leader/leader "<SPC>")
  :hook (after-init . global-evil-leader-mode)
  :config
  ;; prefix: <Leader> f, file
  (evil-leader/set-key
    "fj" 'dired-jump
    "fJ" 'dired-jump-other-window
    "ff" 'find-file
    "fo" 'counsel-find-file-extern
    "fF" 'find-file-other-window
    "fd" 'my/delete-current-file
    "fy" 'my/copy-current-filename
    "fc" 'copy-file
    "fr" 'counsel-recentf
    "fR" 'my/rename-current-file
    "fl" 'find-file-literally
    "fg" 'counsel-rg)

  ;; prefix: <Leader> b, bookmark
  (evil-leader/set-key
    "bb" 'switch-to-buffer
    "bm" 'bookmark-set
    "bd" 'bookmark-delete
    "bj" 'bookmark-jump
    "bJ" 'bookmark-jump-other-window
    "bl" 'bookmark-bmenu-list
    "bs" 'bookmark-save)

  ;; prefix: <Leader> b, bm
  (evil-leader/set-key
    "bp" 'bm-previous
    "bn" 'bm-next
    "bt" 'bm-toggle
    "ba" 'bm-show-all)

  ;; prefix: <Leader> w, window
  (evil-leader/set-key
    "w" 'evil-window-map)
  (evil-leader/set-key
    "w-" 'split-window-vertically
    "w/" 'split-window-horizontally)

  ;; prefix: <Leader> p, projectile
  (evil-leader/set-key
    "pp" 'projectile-switch-project
    "pb" 'projectile-switch-to-buffer
    "pc" 'projectile-compile-project
    "pC" 'projectile-configure-project
    "pP" 'projectile-test-project
    "pa" 'projectile-find-other-file
    "pf" 'projectile-find-file
    "pg" 'projectile-ripgrep)

  ;; prefix: <Leader> a, apps
  (evil-leader/set-key
    "am" 'mu4e
    "an" 'newsticker-show-news
    "ah" 'hyperbole
    "ad" 'deft
    "aa" 'org-agenda
    "ac" 'org-capture
    "al" 'org-store-link
    "at" 'org-todo-list)

  ;; prefix: <Leader> o, open
  (evil-leader/set-key
    "ot" 'vterm
    "oT" 'vterm-other-window
    "oe" 'eshell
    "oE" 'my/eshell-other-window
    "oo" 'my/term
    "oO" 'my/term-other-window)

  ;; frequently used keys
  (evil-leader/set-key
    "i" 'counsel-imenu
    "g" 'counsel-rg)

  ;; org-mode <Leader> m
  ;; Copy from doom-emacs
  (evil-leader/set-key-for-mode 'org-mode
    "m'" 'org-edit-special
    "m," 'org-switchb
    "m." 'counsel-org-goto
    "m/" 'counsel-org-goto-all
    "mA" 'org-archive-subtree
    "md" 'org-deadline
    "me" 'org-export-dispatch
    "mf" 'org-footnote-new
    "mh" 'org-toggle-heading
    "mi" 'org-toggle-item
    "mI" 'org-toggle-inline-images
    "mn" 'org-store-link
    "mo" 'org-set-property
    "mp" 'org-priority
    "mq" 'org-set-tags-command
    "ms" 'org-schedule
    "mt" 'org-todo
    "mT" 'org-todo-list
    "maa" 'org-attach
    "mad" 'org-attach-delete-one
    "maD" 'org-attach-delete-all
    "man" 'org-attach-new
    "mao" 'org-attach-open
    "maO" 'org-attach-open-in-emacs
    "mar" 'org-attach-reveal
    "maR" 'org-attach-reveal-in-emacs
    "mau" 'org-attach-url
    "mas" 'org-attach-set-directory
    "maS" 'org-attach-sync
    "mb-" 'org-table-insert-hline
    "mba" 'org-table-align
    "mbc" 'org-table-create-or-convert-from-region
    "mbe" 'org-table-edit-field
    "mbh" 'org-table-field-info
    "mcc" 'org-clock-in
    "mcC" 'org-clock-out
    "mcd" 'org-clock-mark-default-task
    "mce" 'org-clock-modify-effort-estimate
    "mcE" 'org-set-effort
    "mcl" 'org-clock-in-last
    "mcg" 'org-clock-goto
    "mcG" (lambda () (org-clock-goto 'select))
    "mcr" 'org-clock-report
    "mcx" 'org-clock-cancel
    "mc=" 'org-clock-timestamps-up
    "mc-" 'org-clock-timestamps-down
    "mgg" 'counsel-org-goto
    "mgG" 'counsel-org-goto-all
    "mgc" 'org-clock-goto
    "mgC" (lambda () (org-clock-goto 'select))
    "mgi" 'org-id-goto
    "mgr" 'org-refile-goto-last-stored
    "mgx" 'org-capture-goto-last-stored
    "mll" 'org-insert-link
    "mlL" 'org-insert-all-links
    "mls" 'org-store-link
    "mlS" 'org-insert-last-stored-link
    "mli" 'org-id-store-link
    "mr" 'org-refile)

  ;; org-agenda-mode <Leader> m
  ;; Copy from doom-emacs
  (evil-leader/set-key-for-mode 'org-agenda-mode
    "md" 'org-agenda-deadline
    "mcc" 'org-agenda-clock-in
    "mcC" 'org-agenda-clock-out
    "mcg" 'org-agenda-goto
    "mcr" 'org-agenda-clockreport-mode
    "mcs" 'org-agenda-show-clocking-issues
    "mcx" 'org-agenda-clock-cancel
    "mq" 'org-agenda-set-tags
    "mr" 'org-agenda-refile
    "ms" 'org-agenda-schedule
    "mt" 'org-agenda-todo)

  ;; Replace with correct prefix names
  (with-eval-after-load 'which-key
    (which-key-add-key-based-replacements
      "SPC a" "apps"
      "SPC b" "bookmark"
      "SPC f" "files"
      "SPC o" "open"
      "SPC p" "project")
    )
  )

(use-package evil-nerd-commenter
  :ensure t
  :bind ("M-;" . evilnc-comment-or-uncomment-lines))

(use-package evil-surround
  :ensure t
  :hook (after-init . global-evil-surround-mode))

(use-package evil-magit
  :ensure t
  :after evil magit)

(provide 'init-evil)

;;; init-evil.el ends here
