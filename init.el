(when (>= emacs-major-version 24)
    (require 'package) 
    (package-initialize)
    (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
)  

;; jdee  
(add-to-list 'load-path "~/.emacs.d/jdee-2.4.1/lisp")  
(load "jde")  
;;change jdee hot key
(defun my-java-jde-mode-hook()  
  (local-set-key (quote [tab]) (quote jde-complete))  
  (local-set-key (quote [f7]) (quote jde-compile))
  (local-set-key (quote [f5]) (quote jde-debug))
  (local-set-key (quote [C-f5]) (quote jde-run)))  
(add-hook 'java-mode-hook 'my-java-jde-mode-hook)  

(add-to-list 'load-path "~/.emacs.d/")
(require 'color-theme)
(color-theme-initialize)
(color-theme-charcoal-black)

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

(global-set-key (kbd "<f9>") 'my-evil-mode-on)
(global-set-key (kbd "<f10>") 'my-evil-mode-off)

;grep-find
(global-set-key (kbd "<f3>") 'grep-find)

(global-set-key (kbd "<f1>") 'shell) 
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

(defun indent-buffer ()
"Indent the whole buffer."
(interactive)
(save-excursion
(indent-region (point-min) (point-max) nil)))
(global-set-key [f8] 'indent-buffer)

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


;;==========================================================  
;;YASnippet的配置  
;;==========================================================  
;;太强大了，强大的模板功能  
;(add-to-list 'load-path "~/.emacs.d/plugins/yasnippet-master")
;(require 'yasnippet)
;(setq yas/prompt-functions 
;;  '(yas/dropdown-prompt yas/x-prompt yas/completing-prompt yas/ido-prompt yas/no-prompt))
;(yas/global-mode 1)
;(yas/minor-mode-on) ; 以minor mode打开，这样才能配合主mode使用

(add-to-list 'load-path "~/.emacs.d/yasnippet")  
(require 'yasnippet)  

(add-to-list 'load-path "~/.emacs.d/plugins/")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/plugins//ac-dict")
(ac-config-default)

(setq-default cursor-type 'bar) 
;;(define-key ac-mode-map  [(control return)] 'auto-complete)  
;; /usr/include
;; /usr/include/c++/4.8
;; /usr/include/x86_64-linux-gnu/c++/4.8
;; /usr/include/c++/4.8/backward
;; /usr/lib/gcc/x86_64-linux-gnu/4.8/include
;; /usr/local/include
;; /usr/lib/gcc/x86_64-linux-gnu/4.8/include-fixed
;; /usr/include/x86_64-linux-gnu
;;clang!
(require 'auto-complete-clang)  
(setq ac-clang-auto-save t)  
(setq ac-auto-start t)  
(setq ac-quick-help-delay 0.5)  
;; (ac-set-trigger-key "TAB")  
;; (define-key ac-mode-map  [(control tab)] 'auto-complete)  
;; (define-key ac-mode-map  [(control tab)] 'auto-complete)  
(defun my-ac-config ()  
  (setq ac-clang-flags  
        (mapcar(lambda (item)(concat "-I" item))  
               (split-string  
                "  
")))  
  (setq-default ac-sources '(ac-source-abbrev ac-source-dictionary ac-source-words-in-same-mode-buffers))  
  (add-hook 'emacs-lisp-mode-hook 'ac-emacs-lisp-mode-setup)  
  ;; (add-hook 'c-mode-common-hook 'ac-cc-mode-setup)  
 ;; (add-hook 'ruby-mode-hook 'ac-ruby-mode-setup)  
  ;;(add-hook 'css-mode-hook 'ac-css-mode-setup)  
  (add-hook 'auto-complete-mode-hook 'ac-common-setup)  
  (global-auto-complete-mode t))  
(defun my-ac-cc-mode-setup ()  
  (setq ac-sources (append '(ac-source-clang ac-source-yasnippet) ac-sources)))  
(add-hook 'c-mode-common-hook 'my-ac-cc-mode-setup)  
;; ac-source-gtags  
(my-ac-config)  

(add-to-list 'load-path' "~/.emacs.d/mylisp/")

(load "sql-indent.el")

(load "window-numbering.el")
(window-numbering-mode 1)

;;(load "gdb.el")
(load "google-c-style.el")  
(add-hook 'c-mode-common-hook 'google-set-c-style)  
(add-hook 'c-mode-common-hook 'google-make-newline-indent)  
(require 'flymake-easy)
(add-hook 'c-mode-hook 'flymake-easy-load)
;;(load "flymake-clang-c++.el")
;;(add-hook 'c-mode-common-hook 'flymake-clang-c++-load)
;;(require 'flymake-cppcheck)
;;(add-hook 'c-mode-hook 'flymake-cppcheck-load)
;;(add-hook 'c++-mode-hook 'flymake-cppcheck-load)

(require 'sr-speedbar);;这句话是必须的
(setq sr-speedbar-width 10)
(global-set-key (kbd "<f6>") (lambda()
          (interactive)
          (sr-speedbar-toggle)))
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
