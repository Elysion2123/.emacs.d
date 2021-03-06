;;; init-shell.el --- All about shell -*- lexical-binding: t -*-

;;; Commentary:
;;

;;; Code:

(require 'init-core)

;; Beautiful term mode & friends
(use-package vterm
  :ensure t
  :when (bound-and-true-p module-file-suffix)
  :custom
  (vterm-always-compile-module t)
  (vterm-use-vterm-prompt nil)
  (vterm-kill-buffer-on-exit t)
  (vterm-clear-scrollback-when-clearing t)
  :hook (vterm-mode . (lambda ()
                        (setq-local evil-insert-state-cursor 'box)
                        (setq-local global-hl-line-mode nil)
                        (setq-local truncate-lines t)
                        ;; Dont prompt about processes when killing vterm
                        (setq confirm-kill-processes nil)
                        (evil-insert-state)))
  :config
  ;; Directory synchronization (linux-only)
  (defun my/vterm-directory-sync ()
    "Synchronize current working directory."
    (when vterm--process
      (let* ((pid (process-id vterm--process))
             (dir (file-truename (format "/proc/%d/cwd/" pid))))
        (setq default-directory dir))))

  (when (eq system-type 'gnu/linux)
    (define-advice vterm-send-return (:after nil)
      "Synchronize current working directory."
      (run-with-idle-timer 0.1 nil 'my/vterm-directory-sync)))
  )

;; the Emacs shell
(use-package eshell
  :ensure nil
  :functions eshell/alias
  :custom
  (eshell-scroll-to-bottom-on-input 'all)
  (eshell-scroll-to-bottom-on-output 'all)
  (eshell-kill-on-exit t)
  (eshell-kill-processes-on-exit t)
  (eshell-hist-ignoredups t)
  (eshell-error-if-no-glob t)
  (eshell-glob-case-insensitive t)
  :hook (eshell-mode . (lambda ()
                         ;; Define aliases
                         (eshell/alias "ll"   "ls -lh --color=auto $*")
                         (eshell/alias "vi"   "find-file $1")
                         (eshell/alias "vim"  "find-file $1")
                         (eshell/alias "nvim" "find-file $1")))
  )

;; General term mode
(use-package term
  :ensure nil
  :hook ((term-mode . my/buffer-auto-close)
         (term-mode . (lambda ()
                        (setq-local global-hl-line-mode nil)
                        (setq-local truncate-lines t)
                        (setq-local scroll-margin 0)))))

;; Popup a shell
(use-package shell-pop
  :ensure t
  :bind ("M-=" . shell-pop)
  :custom
  (shell-pop-window-size 40)
  (shell-pop-full-span t)
  (shell-pop-shell-type (if (fboundp 'vterm) '("vterm" "*vterm*" #'vterm)
                          '("eshell" "*eshell*" #'eshell))))

(provide 'init-shell)

;;; init-shell.el ends here
