;; init load path
(add-to-list 'load-path "~/.emacs.d/src")

;; init melpa
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/") t)
(add-to-list 'package-archives '("org" .  "http://orgmode.org/elpa/") t)

;; install use package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(unless (package-installed-p 'diminish)
  (package-refresh-contents)
  (package-install 'diminish))

;; Enable use-package
(eval-when-compile
  (require 'use-package))
(require 'diminish)                ;; if you use :diminish
(require 'bind-key)                ;; if you use any :bind variant

;; hide system bars
(menu-bar-mode -1)
(tool-bar-mode -1)
(toggle-scroll-bar -1)
(set-fringe-mode 10)

;; add top breathing room
(setq scroll-margin 6)

;; make emacs listen to bspwm
(setq frame-resize-pixelwise t)

;; setup theme (https://github.com/Theory-of-Everything/everforest-emacs)
(add-to-list 'custom-theme-load-path "~/.emacs.d/everforest-theme")
(load-theme 'everforest-hard-dark t)

;; setup fonts
(set-face-attribute 'default nil
		    :family "FantasqueSansMonoNerdFontAAE Nerd Font Mono" ; nerd-patched Fantasque Sans Mono
		    :height 160
		    :weight 'normal
		    :width 'normal)

;; highlight matching parentheses
(show-paren-mode 1)

;; don't store temp files in work folders
(setq auto-save-file-name-transforms
          `((".*" ,(concat user-emacs-directory "auto-save") t)))

(setq backup-directory-alist
      `(("." . ,(expand-file-name
                 (concat user-emacs-directory "backups")))))

;; move lines
(defun move-line-up ()
  "Move up the current line."
  (interactive)
  (transpose-lines 1)
  (forward-line -2)
  (indent-according-to-mode))

(defun move-line-down ()
  "Move down the current line."
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1)
  (indent-according-to-mode))

(global-set-key [(meta n)]  'move-line-down)
(global-set-key [(meta p)]  'move-line-up)

;; Infinite Scroll
(setq next-line-add-newlines t)

;; auto close parentheses
(electric-pair-mode 1)

;; remove trailing whitespace on save
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Start Screen
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-project-backend 'projectile)
  (setq dashboard-items '((projects . 5)
			  (recents . 5)
			  (agenda . 10)))
  (setq dashboard-startup-banner 'logo)
  (setq dashboard-banner-logo-title "Welcome back <3")
  (setq dashboard-footer-messages '("Happy coding!"
				    "I showed you my source code, pls respond"
				    "A monad is just a monoid in the category of endofunctors, what's the problem?"
				    "(λxy.y(xxy))(λxy.y(xxy))")))

;; Window Management
(use-package ace-window
  :ensure t
  :init
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  (setq aw-background nil)
  :bind ("C-o" . ace-window))

;; Discovery
(use-package which-key
  :ensure t
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 1))

;; Display Hex-Colors
(use-package rainbow-mode
  :ensure t)

;; Language Support
(use-package lsp-mode
  :ensure t
  :commands (lsp lsp-deferred)
  :init
  (setq lsp-keymap-prefix "C-c l")
  :config
  (lsp-enable-which-key-integration t)
  (setq lsp-enable-symbol-highlighting nil)
  (setq lsp-headerline-breadcrumb-enable nil)
  (setq lsp-auto-configure t))

;;; TypeScript
(use-package typescript-mode
  :ensure t
  :config
  (setq typescript-indent-level 2)
  :mode "\\.tsx?\\'"
  :hook (typescript-mode . lsp-deferred))

;;; JavaScript
(add-hook 'js-mode-hook 'lsp-deferred)
(setq-default js-indent-level 2)
(setq-default indent-tabs-mode nil)

;;; JSX/TSX
(use-package web-mode
  :ensure t
  :mode (("\\.[jt]sx\\'" . web-mode)
	 ("\\.html\\'" . web-mode))
  :hook (web-mode . lsp-deferred)
  :commands web-mode
  :config (setq web-mode-enable-auto-quoting nil))

;;; Kotlin
(use-package kotlin-mode
  :ensure t
  :init
  (setenv "ANDROID_HOME" "/home/lucalabs/android")
  (setenv "ANDROID_SDK_ROOT" "/home/lucalabs/android")
  :config
  (setq kotlin-tab-width 2)
  :hook (kotlin-mode . lsp-deferred))

; Unfortunately no package for this yet, so this has to do
(defun ktlint-fix-file ()
  (interactive)
  (shell-command (concat "ktlint -F " (file-name-nondirectory (buffer-file-name))))) ; requires ktlint to be installed and in path

(defun ktlint-fix-file-and-revert ()
  (interactive)
  (message (concat "ktlint fixing file " (file-name-nondirectory (buffer-file-name))))
  (ktlint-fix-file)
  (revert-buffer t t))

(add-hook 'kotlin-mode-hook
	  (lambda ()
	    (add-hook 'after-save-hook 'ktlint-fix-file-and-revert nil 'local)))

;;; Groovy (mainly for gradle files)
(use-package groovy-mode
  :ensure t
  :mode "\\.gradle\\'"
  :init
  (setq groovy-indent-offset 2))

;;; YAML
(use-package yaml-mode
  :ensure t)

;;; Haskell
(use-package lsp-haskell
  :ensure t
  :hook (haskell-mode . lsp-deferred)
  (haskell-literate-mode . lsp-deferred))

;;; Rust
(use-package rust-mode
  :ensure t
  :hook (rust-mode . lsp-deferred))

;;; C
(use-package ccls
  :ensure t
  :hook ((c-mode c++-mode objc-mode cuda-mode) . lsp-deferred))

;;; Python
(add-hook 'python-mode-hook #'lsp-deferred)
(setq lsp-pylsp-plugins-pydocstyle-enabled nil)

;;; Matlab
(use-package matlab
  :ensure matlab-mode
  :config
  (add-to-list
   'auto-mode-alist
   '("\\.m\\'" . matlab-mode))
  (setq matlab-indent-function t)
  (setq matlab-shell-command "matlab"))

;;; Terraform (without LSP)
(use-package terraform-mode
  :ensure t
  :config
  (setq terraform-indent-level 2))

;; Linting
;;; Java- and Typescript
(use-package eslintd-fix
  :ensure t
  :init
  (setq eslintd-fix-executable "/home/lucalabs/n/bin/eslint_d")
  :hook (js-mode . eslintd-fix-mode)
        (typescript-mode . eslintd-fix-mode)
        (web-mode . eslintd-fix-mode))

;; Frameworks & SDKs
;;; Android
(use-package android-env
  :ensure t)

(use-package elogcat
  :ensure t)

;; Autocomplete
(use-package company
  :ensure t
  :after lsp-mode
  :hook (lsp-mode . company-mode)
  :bind (:map company-active-map
	      ("<tab>" . company-complete-selection))
        (:map lsp-mode-map
	      ("<tab>". company-indent-or-complete-common))
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0))

;; Projects and Files
(use-package ivy
  :ensure t
  :diminish
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)
         ("C-l" . ivy-alt-done)
         ("C-n" . ivy-next-line)
         ("C-p" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-p" . ivy-previous-line)
         ("C-f" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-p" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

(use-package projectile
  :ensure t
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap ("C-c p" . projectile-command-map)
  :init
  (when (file-directory-p "~/Projects")
    (setq projectile-project-search-path '("~/Projects")))
  (setq projectile-switch-project-action #'projectile-dired))

(use-package hl-todo
  :ensure t
  :hook (lsp-mode . hl-todo-mode)
  :config
  (setq hl-todo-keyword-faces
        '(("TODO" warning bold)
          ("FIXME" error bold)
          ("TESTME" warning bold)
          ("REVIEW" warning bold)
          ("NOTE" success bold)))
  (define-key hl-todo-mode-map (kbd "C-c t p") 'hl-todo-previous)
  (define-key hl-todo-mode-map (kbd "C-c t n") 'hl-todo-next)
  )

(use-package swiper
  :ensure t)

(use-package ag
  :ensure t)

;; git
(use-package magit
    :ensure t
    :defer t
    :config)

;; TeX
(use-package tex
  :ensure auctex
  :hook ((tex . (TeX-fold-mode))
         (tex . (TeX-source-correlate-mode)))
  :config
  (setq-default TeX-master nil)
  (setq TeX-parse-self t)
  (setq TeX-auto-save t)
  (setq TeX-PDF-mode t)
  (setq TeX-source-correlate-method 'synctex)
  (setq TeX-view-program-selection '((output-pdf "Zathura"))
	TeX-source-correlate-start-server t))

;; Orgmode
(defun org-mode-setup ()
  (org-indent-mode)
  (visual-line-mode 1)
  (font-lock-add-keywords 'org-mode
                          '(("^ *\\([-]\\) "
                             (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•")))))))

(use-package org
  :ensure t
  :hook (org-mode . org-mode-setup)
  :config
  (setq org-hide-emphasis-markers t)
  (setq org-ellipsis " ▾")
  (setq org-todo-keywords
	'((sequence "TODO" "ACTIVE" "|" "DONE" "CANCELED")))
  (setq org-todo-keyword-faces
	'(("ACTIVE" . "magenta")))
  (setq org-format-latex-options
	(plist-put org-format-latex-options :scale 2.0))
  (setq org-agenda-files (list "~/org/work.org"
                             "~/org/home.org"))
  (setup-orgmode-export))

(use-package org-bullets
  :ensure t
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

;; Orgmode TeX outlining
(defun setup-orgmode-export ()
  (setq org-latex-default-class "org-article")
  (setq org-export-with-toc nil)
  (setq org-export-with-creator nil)
  (setq org-export-with-author nil)
  (setq org-export-with-title nil)
  (setq org-export-with-date nil)
  (setq org-latex-with-hyperref nil))

(with-eval-after-load 'ox-latex
    (add-to-list 'org-latex-classes
		 '("org-article"
		   "\\include{preamble}
                [NO-PACKAGES]
                [NO-DEFAULT-PACKAGES]
                [NO-EXTRA]"
		   ("\\section{%s}" . "\\section*{%s}")
		   ("\\subsection{%s}" . "\\subsection*{%s}")
		   ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
		   ("\\paragraph{%s}" . "\\paragraph*{%s}")
		   ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))))
(put 'downcase-region 'disabled nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auth-source-save-behavior nil)
 '(package-selected-packages
   '(lsp-haskell yaml-mode which-key web-mode use-package typescript-mode swiper projectile org-bullets org nord-theme magit lsp-mode load-env-vars langtool kotlin-mode gruvbox-theme groovy-mode flycheck-vale flycheck-grammarly eslintd-fix elogcat diminish dashboard company auctex android-env))
 '(warning-suppress-types
   '((comp)
     (comp)
     (comp)
     (comp)
     (comp)
     (comp)
     (comp)
     (comp)
     (comp))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
