;; (server-start)
(setq gc-cons-threshold (* 50 1000 1000))
(if (version<= "26.0.50" emacs-version )
    (global-display-line-numbers-mode)
  (global-linum-mode))
(toggle-truncate-lines 1)
(add-hook 'org-mode-hook (lambda () (setq truncate-lines nil)))
(show-paren-mode 1)
(defalias 'yes-or-no-p 'y-or-n-p)
(tool-bar-mode -1)
(setq inhibit-startup-message t)
(setq make-backup-files nil)
(setq auto-save-default nil)

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

(require 'package)
(setq package-enable-at-start nil)
(setq package-archives '(("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
			 ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
			 ("melpa-stable" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa-stable/")
			 ("org-cn"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/org/")
			 ))


(when (not (version<= "26.0.50" emacs-version ))
  (setq package-archive-priorities '(
				     ("melpa-stable" . 10)
				     ("org-cn" . 5)
				     ("melpa" . 5)
				     ("gnu" . 5)
				     )))
(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(use-package restart-emacs
	 :ensure t)

       (use-package magit
	 :ensure t)

       (use-package company
	 :ensure t
	 :config
	 (progn
	   (company-mode 1)
	   (add-hook 'after-init-hook 'global-company-mode)))

     ;;  (use-package company-tern
     ;;     :ensure t
     ;;     :config
     ;;     (add-to-list 'company-backends 'company-tern))

       (use-package company-irony
	 :ensure t
	 :config
	 (progn
	   (eval-after-load 'company
	     '(add-to-list 'company-backends 'company-irony))
	   (add-hook 'c++-mode-hook 'irony-mode)
	   (add-hook 'c-mode-hook 'irony-mode)
	   (add-hook 'objc-mode-hook 'irony-mode)

	   (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options))
	 )

       (use-package haskell-mode
	 :defer t
	 )

	(use-package js2-mode
	  :ensure t
	  :config
	  (progn 
	    (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
	  ))
	  (use-package org-pomodoro
	    :ensure t)

       ;; (use-package tide
       ;;   :ensure t
       ;;   :after (typescript-mode company flycheck)
       ;;   :hook ((typescript-mode . tide-setup)
       ;;          (typescript-mode . tide-hl-identifier-mode)
       ;;          (before-save . tide-format-before-save)
       ;; 	 ))

       (use-package flycheck
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

       (use-package evil-nerd-commenter
	 :defer 3
	 :config
	 (progn
	   (evilnc-default-hotkeys nil t)
	   )
	 )

       (use-package org-bullets
	 :ensure t
	 :config
	 (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

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
	   (add-hook 'go-mode-hook 'eglot-ensure)
	   ))

     (use-package lsp-mode
       :commands lsp
       :config
       (require 'lsp-clients)
       (add-hook 'js2-mode-hook 'lsp)
     )

     ;; optionally
     (use-package lsp-ui :commands lsp-ui-mode)  
     (use-package company-lsp
	   :ensure t
	   :config
	   (push 'company-lsp company-backends))

       (use-package yasnippet
	 :ensure t)

       (use-package evil-org
	 :ensure t
	 :after org
	 :config
	 (add-hook 'org-mode-hook 'evil-org-mode)
	 (add-hook 'evil-org-mode-hook
		   (lambda ()
		     (evil-org-set-key-theme)))
	 (require 'evil-org-agenda)
	 (evil-org-agenda-set-keys))

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

     (use-package ob-typescript
       :ensure t)
     (use-package evil-magit
       :ensure t)
     (use-package vterm
       :ensure t)
       (use-package org-tempo)
(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
	 ("\\.md\\'" . markdown-mode)
	 ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))
  (use-package avy
     :ensure t)
  ;; (use-package eaf
  ;; :load-path "~/.emacs.d/elpa/eaf")

(use-package evil-leader
  :ensure t
  :init
  (global-evil-leader-mode)
  (evil-leader/set-key
  "ff" 'counsel-find-file
  "ft" 'neotree-toggle
  "fn" 'neotree-find
  "fs" 'save-buffer
  "bb" 'ivy-switch-buffer
  "bd" 'kill-this-buffer
  "bn" 'next-code-buffer
  "bp" 'prev-code-buffer
  "bo" 'delete-other-windows
  "hk" 'counsel-descbinds
  "ga" 'org-agenda
  "gb" 'org-babel-tangle
  "gt" 'magit-status
  "qq" 'evil-quit
  "qQ" 'evil-quit-all
  "qr" 'restart-emacs
  "x" 'eval-last-sexp
  "ci" 'comment-or-uncomment-region
  "oi" '(lambda ()
	  (interactive)
	  (find-file "~/.emacs.d/init.org"))

  "oa" '(lambda ()
	  (interactive)
	  (find-file "~/agenda/agenda.org"))
  "oh" '(lambda ()
	  (interactive)
	  (find-file "~/agenda/habbits.org"))
  "on" '(lambda ()
	  (interactive)
	  (find-file "~/Documents/note"))
  "oc" 'org-capture
  "m'" 'org-edit-special
  "mc" 'org-ctrl-c-ctrl-c
  "me" 'org-export-dispatch
  "mti" 'org-clock-in
  "mte" 'org-clock-out
  "ss" 'swiper
  "wv" 'split-window-vertically
  "ws" 'split-window-horizontally
  "wh" 'evil-window-left
  "wj" 'evil-window-down
  "wk" 'evil-window-up
  "wl" 'evil-window-right
  )
  )

(when (not (version<= "26.0.50" emacs-version ))
  (use-package posframe
    :ensure t)
  )
(use-package pyim
  :ensure nil
  :config
  ;; 激活 basedict 拼音词库
  (use-package pyim-basedict
    :ensure nil
    :config (pyim-basedict-enable))
  (setq pyim-dicts '((:file "~/.emacs.d/pyim-bigdict.pyim")))

  (setq default-input-method "pyim")

  ;; 我使用全拼
  (setq pyim-default-scheme 'ziranma-shuangpin)

  ;; 设置 pyim 探针设置，可以实现 *无痛* 中英文切换 :-)
  (setq-default pyim-english-input-switch-functions
		'(pyim-probe-dynamic-english
		  pyim-probe-isearch-mode
		  pyim-probe-program-mode
		  pyim-probe-org-structure-template))

  (setq-default pyim-punctuation-half-width-functions
		'(pyim-probe-punctuation-line-beginning
		  pyim-probe-punctuation-after-punctuation))

  ;; 开启拼音搜索功能
  (setq pyim-isearch-enable-pinyin-search t)

  ;; 使用 pupup-el 来绘制选词框
     (if (version<= "26.0.50" emacs-version )
     (setq pyim-use-tooltip 'posframe)
     (setq pyim-use-tooltip 'popup))

  ;; 选词框显示5个候选词
  (setq pyim-page-length 5)

  ;; 让 Emacs 启动时自动加载 pyim 词库
  (add-hook 'emacs-startup-hook
	    #'(lambda () (pyim-restart-1 t)))
  :bind
  (("M-j" . pyim-convert-code-at-point) ;与 pyim-probe-dynamic-english 配合
   ("C-;" . pyim-delete-word-from-personal-buffer)))

(add-hook 'neotree-mode-hook
	      (lambda ()
		(define-key evil-normal-state-local-map (kbd "TAB") 'neotree-enter)
		(define-key evil-normal-state-local-map (kbd "l") 'neotree-quick-look)
		(define-key evil-normal-state-local-map (kbd "q") 'neotree-hide)
		(define-key evil-normal-state-local-map (kbd "RET") 'neotree-enter)
		(define-key evil-normal-state-local-map (kbd "g") 'neotree-refresh)
		(define-key evil-normal-state-local-map (kbd "n") 'neotree-next-line)
		(define-key evil-normal-state-local-map (kbd "p") 'neotree-previous-line)
		(define-key evil-normal-state-local-map (kbd "A") 'neotree-stretch-toggle)
		(define-key evil-normal-state-local-map (kbd "a") 'neotree-create-node)
		(define-key evil-normal-state-local-map (kbd "d") 'neotree-delete-node)
		(define-key evil-normal-state-local-map (kbd "H") 'neotree-hidden-file-toggle)))

(define-key evil-normal-state-map (kbd "C-u") 'evil-scroll-up)
(define-key evil-visual-state-map (kbd "C-u") 'evil-scroll-up)
(define-key evil-insert-state-map (kbd "C-u")
  (lambda ()
    (interactive)
    (evil-delete (point-at-bol) (point))))
(evil-leader/set-leader "<SPC>")
(define-key evil-normal-state-map (kbd "wj") 'evil-window-down)
(define-key evil-normal-state-map (kbd "wk") 'evil-window-up)
(define-key evil-normal-state-map (kbd "wh") 'evil-window-left)
(define-key evil-normal-state-map (kbd "wl") 'evil-window-right)
(define-key evil-normal-state-map (kbd "<up>") 'evil-previous-visual-line)
(define-key evil-normal-state-map (kbd "<down>") 'evil-next-visual-line)
(define-key evil-normal-state-map (kbd "C-s") 'avy-goto-char)
(define-key evil-normal-state-map (kbd "C-;") 'avy-goto-char-2)

(add-hook 'org-mode-hook (lambda ()
				(evil-org-set-key-theme '(textobjects insert navigation additional shift todo heading))
			   (define-key evil-normal-state-local-map (kbd "mO")
			     'org-insert-heading)
			   (define-key evil-normal-state-local-map (kbd "mo")
			     'org-insert-heading-after-current)
			   (define-key evil-normal-state-local-map (kbd "mi")
			     'org-insert-subheading)
			   (define-key evil-normal-state-local-map (kbd "mt")
			     'org-set-tags)
			   (define-key evil-normal-state-local-map (kbd "ms")
			     'org-schedule)
			   (define-key evil-normal-state-local-map (kbd "md") 'org-deadline)
			   (define-key evil-normal-state-local-map (kbd "m.") 'org-time-stamp)
			   (define-key evil-normal-state-local-map (kbd "t") 'org-todo)
			   )
)
     (evil-define-key 'normal org-capture-mode-map "fs" 'org-capture-finalize)
     (evil-define-key 'normal org-capture-mode-map "qq" 'org-capture-kill)

(setq org-capture-templates
      '(("l" "灵感" entry (file+headline "~/agenda/inspiration.org" "创意")
	 "* %?\n %i\n %a")
	("j" "Jounal" entry (file+datetree "~/agenda/journal.org")
	 "* %?\n输入于: %U\n %i\n %a")
	("t" "临时任务" entry (file+datetree "~/agenda/agenda.org")
	"**** TODO %?\n       SCHEDULED: %T")
	("s" "计划任务" entry (file+datetree+prompt "~/agenda/agenda.org")
	"**** TODO %?\n       SCHEDULED: %T")
	("k" "计时任务" entry (file+datetree "~/agenda/agenda.org")
	"**** TODO %?\n     :LOGBOOK:\n     CLOCK: %U\n     :END:\n")
	("h" "Habit" entry (file "~/Org/inbox.org")
	 "* TODO %?\nSCHEDULED: <%<%Y-%m-%d %a .+1d>>\n:PROPERTIES:\n:CREATED: %U\n:STYLE: habit\n:REPEAT_TO_STATE: NEXT\n:LOGGING: DONE(!)\n:ARCHIVE: %%s_archive::* Habits\n:END:\n%U\n")
	)
      )
      (define-key global-map "\C-cc" 'org-capture)

(global-unset-key (kbd "C-SPC"))

(setq lsp-language-id-configuration '(
				      (python-mode . "python3")
				      (go-mode . "go")
				      ))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files (quote ("~/agenda/habbits.org" "~/agenda/agenda.org")))
 '(package-selected-packages
   (quote
    (lsp-mode eglot lsp-imenu yasnippet js2-mode smartparens smartparens-config lsp-python lsp-ui tide company-lsp company neotree projectile doom-modeline dashboard counsel evil-leader org-bullets which-key use-package try evil)))
 '(word-wrap t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(setq lsp-language-id-configuration '((java-mode . "java")

(python-mode . "python")

(gfm-view-mode . "markdown")

(rust-mode . "rust")

(css-mode . "css")

(xml-mode . "xml")

(c-mode . "c")

(c++-mode . "cpp")

(objc-mode . "objective-c")

(web-mode . "html")

(html-mode . "html")

(sgml-mode . "html")

(mhtml-mode . "html")

(go-mode . "go")

(haskell-mode . "haskell")

(php-mode . "php")

(json-mode . "json")

(js2-mode . "javascript")

;;(typescript-mode . "typescript")

))

(setq org-default-notes-file "~/agenda/index.org")
  (org-babel-do-load-languages
    'org-babel-load-languages
    '((emacs-lisp . t)
    (lisp . t)
    (python . t)
    (js . t)
    (dot . t)
    (lua . t)
    (typescript . t)
      (calc . t)))
