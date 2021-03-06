;;; package --- Summary
;;; Commentary:
;;; Code:
(require 'package) ;; You might already have this line
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) ;; You might already have this line

(add-to-list 'load-path "~/.emacs.d/")

(abbrev-mode nil)

(require 'tramp)
(defun sudo ()
  "reopen current file with sudo."
	(defvar sudo-file-real-path)
  (setq sudo-file-real-path
				(replace-regexp-in-string "\n" ""
																	(shell-command-to-string (concat "readlink -f " buffer-file-truename))
																	)
				)
  (kill-this-buffer)
	(interactive)
  (find-file (concat "/sudo::" sudo-file-real-path))
  )

;; aggressive indent
(global-aggressive-indent-mode 1)
(add-to-list 'aggressive-indent-excluded-modes 'html-mode)

;;golden
;;(golden-ratio-mode t)

;;tramp


;;volatile-highlights
(require 'volatile-highlights)
(volatile-highlights-mode t)

;;highlight-number
(add-hook 'prog-mode-hook 'highlight-numbers-mode)

;;indent guide
(indent-guide-mode t)

;; popwin
(require 'popwin)
(popwin-mode 1)

;; ace jump mode major function
;; 
(autoload
  'ace-jump-mode
  "ace-jump-mode"
  "Emacs quick move minor mode"
  t)
;; you can select the key you prefer to
(define-key global-map (kbd "M-s") 'ace-jump-mode)

;; 
;; enable a more powerful jump back function from ace jump mode
;;
(autoload
  'ace-jump-mode-pop-mark
  "ace-jump-mode"
  "Ace jump back:-)"
  t)
(eval-after-load "ace-jump-mode"
  '(ace-jump-mode-enable-mark-sync))
(define-key global-map (kbd "C-x SPC") 'ace-jump-mode-pop-mark)


 ;;;;;;;;;;;;;;;;;;;;;;;company;;;;;;;;;;;;;;;;;;
;;(add-hook 'after-init-hook #'global-company-mode)
;;;;;;;;;;;;;;;;;;;;;;;;;;;flycheck;;;;;;;;;;;;;;;;
;;(add-hook 'after-init-hook #'global-flycheck-mode)
;;;;;;;;;;;;;;;;;;;emacs-ycmd;;;;;;;;;;;;;;;;;;;
;;(require 'ycmd)
;;(add-hook 'c++-mode-hook 'ycmd-mode)
;;(add-hook 'c++-mode-hook 'company-mode)
;;(add-hook 'after-init-hook #'global-ycmd-mode)
;;(ycmd-force-semantic-completion t)

;;(ycmd-global-config nil)
;;(ycmd-server-command (quote ("python" "~/ycmd/ycmd")))  
;;(set-variable 'ycmd-server-command '("python" "/home/olivier/ycmd/ycmd/"))
;;(set-variable 'ycmd-server-command '("python" "~/ycmd/ycmd/))
;;(set-variable 'ycmd-global-config "/home/olivier/ycmd/cpp/ycm/.ycm_extra_conf.py")
;;(set-variable 'ycmd-extra-conf-whitelist '("/home/olivier/tomongo/*"))
;;(require 'company-ycmd)
;;(company-ycmd-setup)
;;(require 'flycheck-ycmd)
;;(flycheck-ycmd-setup)

;;helm proj
(projectile-global-mode)
(require 'helm-projectile)
(helm-projectile-on)

;;neotree
(require 'neotree)
(global-set-key [S-f12] 'neotree-toggle)

;;highligt-parentheses-mode
(highlight-parentheses-mode t)

;;shut up
(when noninteractive
  (shut-up-silence-emacs))

;;comment
(evilnc-default-hotkeys)

;;flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)

(require 'flycheck-color-mode-line)

(eval-after-load "flycheck"
  '(add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode))

(with-eval-after-load 'flycheck
  (flycheck-pos-tip-mode))

(require 'flycheck-status-emoji)

(eval-after-load 'flycheck
 	'(progn
 		 (require 'flycheck-google-cpplint)
 		 ;; Add Google C++ Style checker.
 		 ;; In default, syntax checked by Clang and Cppcheck.
 		 (flycheck-add-next-checker 'c/c++-clang
 																'c/c++-googlelint 'append)))

(require 'helm-flycheck) ;; Not necessary if using ELPA package
(eval-after-load 'flycheck
  '(define-key flycheck-mode-map (kbd "C-<f6>") 'helm-flycheck))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(company-backends (quote (company-clang company-dabbrev)))
 '(custom-safe-themes
	 (quote
		("06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "196cc00960232cfc7e74f4e95a94a5977cb16fd28ba7282195338f68c84058ec" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" "f5eb916f6bd4e743206913e6f28051249de8ccfd070eae47b5bde31ee813d55f" default)))
 '(display-time-mode t)
 '(flycheck-clang-include-path (quote ("/home/olivier/tomongo/include")))
 '(flycheck-googlelint-linelength "120")
 '(nrepl-message-colors
	 (quote
		("#CC9393" "#DFAF8F" "#F0DFAF" "#7F9F7F" "#BFEBBF" "#93E0E3" "#94BFF3" "#DC8CC3")))
 '(show-paren-mode t)
 '(tool-bar-mode nil))


(add-hook 'c-mode-common-hook 'google-set-c-style)
;; If you want the RETURN key to go to the next line and space over
;; to the right place, add this to your .emacs right after the load-file:
(add-hook 'c-mode-common-hook 'google-make-newline-indent)


;;mvn
(require 'mvn)

;;ac
(ac-config-default)

;;ac-clang
;;(require 'ac-clang)
;;(ac-clang-initialize)

;;electirc
(require 'electric)
(electric-indent-mode t)
(electric-pair-mode t)
(electric-layout-mode t)

(indent-guide-global-mode)(indent-guide-global-mode)

(defun indent-buffer ()
	"Indent the whole buffer."
	(interactive)
	(save-excursion
		(indent-region (point-min) (point-max) nil)))
(global-set-key [f8] 'indent-buffer)

;; indent-guide
(indent-guide-global-mode)

;;magit
(global-set-key [f11] 'magit-status)

;;helm
(require 'helm)
(require 'helm-config)

;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

(when (executable-find "curl")
	(setq helm-google-suggest-use-curl-p t))

(setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
			helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
			helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
			helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
			helm-ff-file-name-history-use-recentf t)

(helm-mode 1)

;;eclim
(require 'eclim)
;;(global-eclim-mode)
(require 'eclimd)

;;(require 'company)
;;(require 'company-emacs-eclim)
;;(company-emacs-eclim-setup)
;;(global-company-mode t)
;;(setq company-emacs-eclim-ignore-case t)

;;(custom-set-variables
;;  '(eclim-eclipse-dirs '("/usr/lib/eclipse"))
;;  '(eclim-executable "~/.eclipse/org.eclipse.platform_4.5.1_155965261_linux_gtk_x86_64/eclimd"))


(setq help-at-pt-display-when-idle t)
(setq help-at-pt-timer-delay 0.1)
(help-at-pt-set-timer)

(defun mvn-package ()
	(interactive)
	(mvn "clean package")
	)


(defun mvn-exec ()
	(interactive)
	(mvn "clean package exec:exec")
	)

(defun mvn-eclipse ()
	(interactive)
	(mvn "eclipse:eclipse")
	)

(defun restart-eclim ()
	(interactive)
	(stop-eclimd)
	(start-eclimd "~/"))

(defun compile-dot()
	(interactive)
	(setq msg	(concat graphviz-dot-dot-program
										" -T" graphviz-dot-preview-extension " "
										(shell-quote-argument buffer-file-name)
										" -o "
										(shell-quote-argument
										 (concat (file-name-sans-extension buffer-file-name)
														 "." graphviz-dot-preview-extension))))
	(compile msg))

(defun my-graph-dot-mode-hook()
	(local-set-key (quote [f5]) (quote compile-dot))
	(local-set-key (quote [f7]) (quote graphviz-dot-preview)))
(add-hook 'graphviz-dot-mode-hook 'my-graph-dot-mode-hook)

;;change eclim hot key
(defun my-eclim-mode-hook()
	;; add the emacs-eclim source
	(require 'ac-emacs-eclim-source)
	(ac-emacs-eclim-config)
	(flycheck-mode 0)
	(local-set-key (quote [f7]) (quote mvn-compile))
	(local-set-key (quote [f9]) (quote eclim-java-find-declaration))
	(local-set-key (quote [C-f9]) (quote eclim-java-find-type))
	(local-set-key (quote [S-f9]) (quote eclim-java-find-references))
	(local-set-key (quote [f10]) (quote eclim-java-import-organize
																			))
	(local-set-key (quote [C-f10]) (quote eclim-project-mode))
	(local-set-key (quote [C-f8]) (quote eclim-java-format))
	(local-set-key (quote [S-f8]) (quote restart-eclim))
	(local-set-key (quote [f6]) (quote eclim-problems-next-same-window))
	(local-set-key (quote [S-f6]) (quote eclim-problems-correct
																			 ))
	(local-set-key (quote [C-f6]) (quote eclim-problems))
	(local-set-key (quote [f5]) (quote mvn-package))  
	(local-set-key (quote [C-f5]) (quote mvn-exec)))  
(add-hook 'eclim-mode-hook 'my-eclim-mode-hook)

;;rainbow in java
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;;(require 'color-theme)
;;spcaemacse
;;(require 'spacemacs-light-theme)
(load-theme 'monokai t)

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
(setq ffap-c-path '("/usr/include" "/usr/local/include"))
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

;;(my-maximized) 
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

;;goto-last-change
(global-set-key (kbd "M-{") 'goto-last-change)
(global-set-key (kbd "M-}") 'goto-last-change-reverse)

(load "gdb.el")

(require 'highlight-symbol)
(global-set-key [f3] 'highlight-symbol-at-point)
(global-set-key (kbd "M-]") 'highlight-symbol-next)
(global-set-key (kbd "M-[") 'highlight-symbol-prev)
(global-set-key (kbd "M-\\") 'highlight-symbol-occur)
(global-set-key [(shift f3)] 'highlight-symbol-remove-all)
(global-set-key [(meta f3)] 'highlight-symbol-query-replace)

;;(load "sql-indent.el")

;;(load "window-numbering.el")
(window-numbering-mode 1)

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

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "DejaVu Sans" :foundry "unknown" :slant normal :weight normal :height 120 :width semi-condensed)))))

(provide 'init)
;;; init.el ends here
