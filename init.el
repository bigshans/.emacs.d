(global-display-line-numbers-mode)
(show-paren-mode 1)
(defalias 'yes-or-no-p 'y-or-n-p)
(tool-bar-mode -1)
(setq inhibit-startup-message t)
(setq make-backup-files nil)
(setq auto-save-default nil)

(require 'package)
(setq package-enable-at-start nil)
(setq package-archives '(("gnu"   . "https://elpa.emacs-china.org/gnu/")
                           ("melpa" . "https://elpa.emacs-china.org/melpa/")))

(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(use-package company
  :ensure t
  :config
  (progn
    (company-mode 1)
    (add-hook 'after-init-hook 'global-company-mode)))

(use-package tide
  :ensure t
  :after (typescript-mode company flycheck)
  :hook ((typescript-mode . tide-setup)
         (typescript-mode . tide-hl-identifier-mode)
         (before-save . tide-format-before-save)
	 ))

(use-package flycheck
  :ensure t
  :config
  (global-flycheck-mode t))

(use-package smartparens
  :ensure t
  :config
  (smartparens-global-mode 1))

(use-package projectile
  :ensure t
  :config
  (progn
    (projectile-mode +1)
    (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
    (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)))

(use-package try
  :ensure t)

(use-package which-key
  :ensure t
  :config
  (which-key-mode))

(use-package evil
  :ensure t
  :config
  (evil-mode))

(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(use-package evil-leader
  :ensure t
  :config
  (global-evil-leader-mode))

(use-package counsel
  :ensure t
  :config
  (counsel-mode 1))

(use-package swiper
  :ensure t
  :config
  (progn
    (ivy-mode 1)
    (setq ivy-use-virtual-buffers t)
    (setq enable-recursive-minibuffers t)
    ;; enable this if you want `swiper' to use it
    ;; (setq search-default-mode #'char-fold-to-regexp)
    (global-set-key "\C-s" 'swiper)
    (global-set-key (kbd "C-c C-r") 'ivy-resume)
    (global-set-key (kbd "<f6>") 'ivy-resume)
    (global-set-key (kbd "M-x") 'counsel-M-x)
    (global-set-key (kbd "C-x C-f") 'counsel-find-file)
    (global-set-key (kbd "<f1> f") 'counsel-describe-function)
    (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
    (global-set-key (kbd "<f1> l") 'counsel-find-library)
    (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
    (global-set-key (kbd "<f2> u") 'counsel-unicode-char)
    (global-set-key (kbd "C-c g") 'counsel-git)
    (global-set-key (kbd "C-c j") 'counsel-git-grep)
    (global-set-key (kbd "C-c k") 'counsel-ag)
    (global-set-key (kbd "C-x l") 'counsel-locate)
    (global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
    (define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)
    (define-key ivy-minibuffer-map [escape] 'minibuffer-keyboard-quit)
    (define-key ivy-minibuffer-map (kbd "") 'minibuffer-keyboard-quit)
    ))

(use-package neotree
  :ensure t
  :config
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow)))

(use-package dashboard
  :ensure t
  :diminish dashboard-mode
  :config
  (progn
    (setq dashboard-set-heading-icons t)
    (setq dashboard-set-file-icons t)
    (setq dashboard-set-navigator t)
    (setq dashboard-banner-logo-title "This is Aerian's emacs")
    (setq dashboard-center-content t)
    (setq dashboard-show-shortcuts nil)
    (setq dashboard-items '(
			    (recents . 10)
			    (projects . 5)
			    ))
    (dashboard-setup-startup-hook)
   )
  )

(use-package go-mode
  :ensure t)

(use-package eglot
  :ensure t
  :config
  (progn
    (add-hook 'python-mode-hook 'eglot-ensure)
    (add-hook 'js-mode-hook 'eglot-ensure)
    (add-hook 'c++-mode-hook 'eglot-ensure)
    (add-hook 'go-mode-hook 'eglot-ensure)
    ))

;;(use-package lsp-mode
;;  :config
;;  (add-hook 'c++-mode-hook #'lsp)
;;  (add-hook 'python-mode-hook #'lsp))

(use-package yasnippet
  :ensure t)

(use-package doom-themes
  :ensure t
  :config
  (progn
    ;; Global settings (defaults)
    (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
	  doom-themes-enable-italic t) ; if nil, italics is universally disabled

    ;; Load the theme (doom-one, doom-molokai, etc); keep in mind that each theme
    ;; may have their own settings.
    (load-theme 'doom-one t)

    ;; Enable flashing mode-line on errors
    (doom-themes-visual-bell-config)

    ;; Enable custom neotree theme (all-the-icons must be installed!)
    (doom-themes-neotree-config)
    ;; or for treemacs users
    (setq doom-themes-treemacs-theme "doom-colors") ; use the colorful treemacs theme
    (doom-themes-treemacs-config)

    ;; Corrects (and improves) org-mode's native fontification.
    (doom-themes-org-config)
    )
  )

(use-package doom-modeline
  :ensure t
  :hook (after-init . doom-modeline-mode)
  :config
  (progn
    ;; How tall the mode-line should be. It's only respected in GUI.
    ;; If the actual char height is larger, it respects the actual height.
    (setq doom-modeline-height 25)

    ;; How wide the mode-line bar should be. It's only respected in GUI.
    (setq doom-modeline-bar-width 3)

    ;; Determines the style used by `doom-modeline-buffer-file-name'.
    ;;
    ;; Given ~/Projects/FOSS/emacs/lisp/comint.el
    ;;   truncate-upto-project => ~/P/F/emacs/lisp/comint.el
    ;;   truncate-from-project => ~/Projects/FOSS/emacs/l/comint.el
    ;;   truncate-with-project => emacs/l/comint.el
    ;;   truncate-except-project => ~/P/F/emacs/l/comint.el
    ;;   truncate-upto-root => ~/P/F/e/lisp/comint.el
    ;;   truncate-all => ~/P/F/e/l/comint.el
    ;;   relative-from-project => emacs/lisp/comint.el
    ;;   relative-to-project => lisp/comint.el
    ;;   file-name => comint.el
    ;;   buffer-name => comint.el<2> (uniquify buffer name)
    ;;
    ;; If you are expereicing the laggy issue, especially while editing remote files
    ;; with tramp, please try `file-name' style.
    ;; Please refer to https://github.com/bbatsov/projectile/issues/657.
    (setq doom-modeline-buffer-file-name-style 'truncate-upto-project)

    ;; Whether display icons in mode-line or not.
    (setq doom-modeline-icon t)

    ;; Whether display the icon for major mode. It respects `doom-modeline-icon'.
    (setq doom-modeline-major-mode-icon t)

    ;; Whether display color icons for `major-mode'. It respects
    ;; `doom-modeline-icon' and `all-the-icons-color-icons'.
    (setq doom-modeline-major-mode-color-icon t)

    ;; Whether display icons for buffer states. It respects `doom-modeline-icon'.
    (setq doom-modeline-buffer-state-icon t)

    ;; Whether display buffer modification icon. It respects `doom-modeline-icon'
    ;; and `doom-modeline-buffer-state-icon'.
    (setq doom-modeline-buffer-modification-icon t)

    ;; Whether display minor modes in mode-line or not.
    (setq doom-modeline-minor-modes nil)

    ;; If non-nil, a word count will be added to the selection-info modeline segment.
    (setq doom-modeline-enable-word-count nil)

    ;; Whether display buffer encoding.
    (setq doom-modeline-buffer-encoding t)

    ;; Whether display indentation information.
    (setq doom-modeline-indent-info nil)

    ;; If non-nil, only display one number for checker information if applicable.
    (setq doom-modeline-checker-simple-format t)

    ;; The maximum displayed length of the branch name of version control.
    (setq doom-modeline-vcs-max-length 12)

    ;; Whether display perspective name or not. Non-nil to display in mode-line.
    (setq doom-modeline-persp-name t)

    ;; Whether display icon for persp name. Nil to display a # sign. It respects `doom-modeline-icon'
    (setq doom-modeline-persp-name-icon nil)

    ;; Whether display `lsp' state or not. Non-nil to display in mode-line.
    (setq doom-modeline-lsp t)

    ;; Whether display github notifications or not. Requires `ghub` package.
    (setq doom-modeline-github nil)

    ;; The interval of checking github.
    (setq doom-modeline-github-interval (* 30 60))

    ;; Whether display mu4e notifications or not. Requires `mu4e-alert' package.
    (setq doom-modeline-mu4e t)

    ;; Whether display irc notifications or not. Requires `circe' package.
    (setq doom-modeline-irc t)

    ;; Function to stylize the irc buffer names.
    (setq doom-modeline-irc-stylize 'identity)

    ;; Whether display environment version or not
    (setq doom-modeline-env-version t)
    ;; Or for individual languages
    (setq doom-modeline-env-enable-python t)
    (setq doom-modeline-env-enable-ruby t)
    (setq doom-modeline-env-enable-perl t)
    (setq doom-modeline-env-enable-go t)
    (setq doom-modeline-env-enable-elixir t)
    (setq doom-modeline-env-enable-rust t)

    ;; Change the executables to use for the language version string
    (setq doom-modeline-env-python-executable "python") ; or `python-shell-interpreter'
    (setq doom-modeline-env-ruby-executable "ruby")
    (setq doom-modeline-env-perl-executable "perl")
    (setq doom-modeline-env-go-executable "go")
    (setq doom-modeline-env-elixir-executable "iex")
    (setq doom-modeline-env-rust-executable "rustc")

    ;; What to dispaly as the version while a new one is being loaded
    (setq doom-modeline-env-load-string "...")

    ;; Hooks that run before/after the modeline version string is updated
    (setq doom-modeline-before-update-env-hook nil)
    (setq doom-modeline-after-update-env-hook nil)))

(defun next-code-buffer ()
  (interactive)
  (let (( bread-crumb (buffer-name) ))
    (next-buffer)
    (while
        (and
         (string-match-p "^\*" (buffer-name))
         (not ( equal bread-crumb (buffer-name) )) )
      (next-buffer))))
(defun prev-code-buffer ()
  (interactive)
  (let (( bread-crumb (buffer-name) ))
    (previous-buffer)
    (while
        (and
         (string-match-p "^\*" (buffer-name))
         (not ( equal bread-crumb (buffer-name) )) )
      (previous-buffer))))

;; evil config
;;
(add-hook 'neotree-mode-hook
              (lambda ()
                (define-key evil-normal-state-local-map (kbd "TAB") 'neotree-enter)
                (define-key evil-normal-state-local-map (kbd "SPC") 'neotree-quick-look)
                (define-key evil-normal-state-local-map (kbd "q") 'neotree-hide)
                (define-key evil-normal-state-local-map (kbd "RET") 'neotree-enter)
                (define-key evil-normal-state-local-map (kbd "g") 'neotree-refresh)
                (define-key evil-normal-state-local-map (kbd "n") 'neotree-next-line)
                (define-key evil-normal-state-local-map (kbd "p") 'neotree-previous-line)
                (define-key evil-normal-state-local-map (kbd "A") 'neotree-stretch-toggle)
                (define-key evil-normal-state-local-map (kbd "H") 'neotree-hidden-file-toggle)))
(define-key evil-normal-state-map (kbd "C-u") 'evil-scroll-up)
(define-key evil-visual-state-map (kbd "C-u") 'evil-scroll-up)
(define-key evil-insert-state-map (kbd "C-u")
  (lambda ()
    (interactive)
    (evil-delete (point-at-bol) (point))))
(evil-leader/set-leader "<SPC>")
(define-key evil-normal-state-map (kbd "wj") 'evil-window-bottom)
(define-key evil-normal-state-map (kbd "wk") 'evil-window-up)
(define-key evil-normal-state-map (kbd "wh") 'evil-window-left)
(define-key evil-normal-state-map (kbd "wl") 'evil-window-right)
(evil-leader/set-key
  "ff" 'counsel-find-file
  "ft" 'neotree-toggle
  "fs" 'save-buffer
  "bb" 'ivy-switch-buffer
  "bd" 'kill-this-buffer
  "bn" 'next-code-buffer
  "bp" 'prev-code-buffer
  "bo" 'delete-other-windows
  "hk" 'counsel-descbinds
  "q" 'evil-quit
  "Q" 'evil-quit-all
  "x" 'eval-last-sexp
  "ss" 'swiper)
;; evil config end

(set-default-font "-*-Fira Code-normal-normal-normal-*-14-*-*-*-m-0-iso10646-1")
(setq lsp-language-id-configuration '(
				      (python-mode . "python3")
				      (go-mode . "go")
				      ))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (eglot lsp-imenu yasnippet js2-mode smartparens smartparens-config lsp-python lsp-ui tide company-lsp company neotree projectile doom-modeline dashboard counsel evil-leader org-bullets which-key use-package try evil))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
