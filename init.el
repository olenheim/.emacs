(require 'package) ;; You might already have this line
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) ;; You might already have this line

(require 'tramp)
(defun sudo ()
  "reopen current file with sudo."
  (setq sudo-file-real-path
				(replace-regexp-in-string "\n" ""
																	(shell-command-to-string (concat "readlink -f " buffer-file-truename))
																	)
				)
  (kill-this-buffer)
  (find-file (concat "/sudo::" sudo-file-real-path))
  (interactive)
  )

;;highligt-parentheses-mode
(highlight-parentheses-mode t)

;;markdown
(add-to-list 'load-path "~/.emacs.d/emacs-goodies-el")
(require 'markdown-mode)

;;git
(require 'git)

;;electirc
(require 'electric)
(electric-indent-mode t)
(electric-pair-mode t)
(electric-layout-mode t)

(defun indent-buffer ()
  "Indent the whole buffer."
  (interactive)
  (save-excursion
    (indent-region (point-min) (point-max) nil)))
(global-set-key [f8] 'indent-buffer)


;;magit
(global-set-key [f11] 'magit-status)

;;helm
(require 'helm-config)

;;eclim
(require 'eclim)
(global-eclim-mode)
(require 'eclimd)

;;(custom-set-variables
;;  '(eclim-eclipse-dirs '("/usr/lib/eclipse"))
;;  '(eclim-executable "~/.eclipse/org.eclipse.platform_4.5.1_155965261_linux_gtk_x86_64/eclimd"))

;; add the emacs-eclim source
(require 'ac-emacs-eclim-source)
(ac-emacs-eclim-config)

(setq help-at-pt-display-when-idle t)
(setq help-at-pt-timer-delay 0.1)
(help-at-pt-set-timer)

;;ac
(ac-config-default)

(defun restart-eclim ()
	(interactive)
	(stop-eclimd)
	(start-eclimd "~/"))

;;change eclim hot key
(defun my-eclim-mode-hook()  
  (local-set-key (quote [f7]) (quote mvn-compile))
	(local-set-key (quote [f9]) (quote eclim-java-find-declaration))
	(local-set-key (quote [f10]) (quote eclim-java-find-type))
	(local-set-key (quote [C-f10]) (quote eclim-java-find-references))
	(local-set-key (quote [C-f8]) (quote eclim-java-format))
	(local-set-key (quote [S-f8]) (quote restart-eclim))
	(local-set-key (quote [f6]) (quote eclim-problems-next-same-window))
	(local-set-key (quote [S-f6]) (quote eclim-problems-correct
																			 ))
	(local-set-key (quote [C-f6]) (quote eclim-problems))
  (local-set-key (quote [f5]) (quote eclim-java-import-organize
																		 ))
  (local-set-key (quote [C-f5]) (quote eclim-maven-run)))  
(add-hook 'eclim-mode-hook 'my-eclim-mode-hook)

(add-to-list 'load-path "~/.emacs.d/")

(require 'color-theme)
;;spcaemacse
(require 'spacemacs-light-theme)

;;             C  mode
(add-hook 'c-mode-hook 'hs-minor-mode)
(defun my-c-mode-auto-pair ()
  (interactive)
  (make-local-variable 'skeleton-pair-alist)
  (setq skeleton-pair-alist  '(
															 (?` ?` _ "''")
															 (?\( ?  _ ")")
															 (?\[ ?  _ "]")
															 (?{ \n > _ \n ?} >)))
  (setq skeleton-pair t)
  (local-set-key (kbd "(") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "{") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "`") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "[") 'skeleton-pair-insert-maybe))
(add-hook 'c-mode-hook 'my-c-mode-auto-pair)

(add-to-list 'load-path "~/.emacs.d/evil-evil")  
(load "evil.el")

;;evil-mode
(defun my-evil-mode-on ()
  (interactive)
  (evil-mode 1)
  (setq cursor-type 'bar))

(defun my-evil-mode-off ()
  (interactive)
  (evil-mode 0)
  (setq cursor-type 'bar))

(global-set-key (kbd "<f7>") 'smart-compile)
(defun smart-compile()
  (interactive)
  (if (eq major-mode 'python-mode)
      (setq command
						(concat "python "
										(file-name-nondirectory buffer-file-name)))
		(if (eq major-mode 'newlisp-mode)
				(setq command
							(concat "newlisp "
											(file-name-nondirectory buffer-file-name)))
			(if (eq major-mode 'c-mode)
					(setq command
								(concat "gcc -Wall -o "
												(file-name-sans-extension
												 (file-name-nondirectory buffer-file-name))
												" "
												(file-name-nondirectory buffer-file-name)
												" -g -lm "))
	      (if (eq major-mode 'c++-mode)
						(setq command			
									(concat "c++ -g -std=c++11 -I../include -I../../include -I../../../include -I/usr/local/include  -Wall -DBOOST_LOG_DYN_LINK -o "
													(file-name-sans-extension
													 (file-name-nondirectory buffer-file-name))
													".cc.o -c "
													(file-name-nondirectory buffer-file-name)
													""))
					(message "Unknow mode, won't compile!")))))
  (compile command))

;;(ffap-bindings)
(setq ffap-c-path
      '("/usr/include" "/usr/local/include"))
(setq ffap-newfile-prompt t)
(setq ffap-kpathsea-depth 5)

(setq ff-search-directories
      '("../src/*" "../include/*" "../../src/*" "../../include/*" "../../../src/*" "../../../include/*" "."))

(defvar my-cpp-other-file-alist
  '(("\\.cpp\\'" (".hpp" ".ipp"))
    ("\\.ipp\\'" (".hpp" ".cpp"))
    ("\\.hpp\\'" (".ipp" ".cpp"))
    ("\\.cxx\\'" (".hxx" ".ixx"))
    ("\\.ixx\\'" (".cxx" ".hxx"))
    ("\\.hxx\\'" (".ixx" ".cxx"))
    ("\\.c\\'" (".h"))
    ("\\.cc\\'" (".h"))
    ("\\.h\\'" (".cc" ".c"))
    ))

(setq-default ff-other-file-alist 'my-cpp-other-file-alist)

(setq ff-always-in-other-window 1)

;;; Bind the toggle function to a global key
(global-set-key "\M-o" 'ff-find-other-file)


(global-set-key (kbd "C-x f") 'find-file-at-point)

;;(global-set-key (kbd "<f9>") 'my-evil-mode-on)
;;(global-set-key (kbd "<f10>") 'my-evil-mode-off)

;;grep-find
(global-set-key (kbd "C-<f3>") 'grep-find)
(global-set-key (kbd "<f1>") 'shell)
(global-set-key (kbd "S-<f1>") 'shell-pop) 
(global-set-key (kbd "<f2>") 'rename-buffer)

;;multi-window
(global-set-key (kbd "C-<f1>") 'display-buffer)
(global-set-key (kbd "C-~") 'switch-to-buffer-other-window)
(global-set-key (kbd "C-`") 'find-file-other-window)

(winner-mode 1)
(global-set-key (kbd "M--") 'winner-undo)
(global-set-key (kbd "M-=") 'winner-redo)

																				;全屏
(defun my-fullscreen ()
  (interactive)
  (x-send-client-message
   nil 0 nil "_NET_WM_STATE" 32
   '(2 "_NET_WM_STATE_FULLSCREEN" 0))
  )
(global-set-key [f12] 'my-fullscreen)

																				;最大化
(defun my-maximized ()
  (interactive)
  (x-send-client-message
   nil 0 nil "_NET_WM_STATE" 32
   '(1 "_NET_WM_STATE_MAXIMIZED_HORZ" 0))
  (interactive)
  (x-send-client-message
   nil 0 nil "_NET_WM_STATE" 32
   '(1 "_NET_WM_STATE_MAXIMIZED_VERT" 0)))

(my-maximized) 
(tool-bar-mode 0)
(menu-bar-mode 0)

;;(global-set-key [C-tab] 'other-window)
;;(windmove-default-keybindings)
(global-set-key (kbd "M-<left>")  'windmove-left)
(global-set-key (kbd "M-<right>") 'windmove-right)
(global-set-key (kbd "M-<up>")    'windmove-up)
(global-set-key (kbd "M-<down>")  'windmove-down)

;;copy free
;; copy region or whole line
(global-set-key "\M-w"
								(lambda ()
									(interactive)
									(if mark-active
											(kill-ring-save (region-beginning)
																			(region-end))
										(progn
											(kill-ring-save (line-beginning-position)
																			(line-end-position))
											(message "copied line")))))


;; kill region or whole line
(global-set-key "\C-w"
								(lambda ()
									(interactive)
									(if mark-active
											(kill-region (region-beginning)
																	 (region-end))
										(progn
											(kill-region (line-beginning-position)
																	 (line-end-position))
											(message "killed line")))))


(setq-default cursor-type 'bar) 

(add-to-list 'load-path' "~/.emacs.d/mylisp/")


(load "gdb.el")
(load "highlight-symbol.el")

(require 'highlight-symbol)
(global-set-key [f3] 'highlight-symbol-at-point)
(global-set-key (kbd "M-]") 'highlight-symbol-next)
(global-set-key (kbd "M-[") 'highlight-symbol-prev)
(global-set-key (kbd "M-\\") 'highlight-symbol-occur)
(global-set-key [(shift f3)] 'highlight-symbol-remove-all)
(global-set-key [(meta f3)] 'highlight-symbol-query-replace)

(load "sql-indent.el")

(load "window-numbering.el")
(window-numbering-mode 1)

(load "google-c-style.el")  
(add-hook 'c-mode-common-hook 'google-set-c-style)  
(add-hook 'c-mode-common-hook 'google-make-newline-indent)  
(require 'flymake-easy)
(add-hook 'c-mode-hook 'flymake-easy-load)

;;(require 'sr-speedbar);;这句话是必须的
;;(setq sr-speedbar-width 10)
;;(global-set-key (kbd "<f6>") (lambda()
;;			       (interactive)
;;			       (sr-speedbar-toggle)))
;;(add-hook 'after-init-hook '(lambda () (sr-speedbar-toggle)));;开启程序即启用

;;窗口缩放
(require 'windresize)      
(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)


(font-lock-add-keywords 'lisp-mode '("[(]" "[)]"))
(font-lock-add-keywords 'lisp-mode '("[select]" "[from]" "[where]"))

(load "base.el")  

(put 'scroll-left 'disabled nil)

(bookmark-bmenu-list)
(switch-to-buffer "*Bookmark List*")
