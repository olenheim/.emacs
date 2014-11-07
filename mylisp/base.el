;; 标题栏显示文件路径
(setq frame-title-format
'("%S" (buffer-file-name "%f"
(dired-directory dired-directory "%b"))))

;;成对显示括号,但不来回弹跳
(show-paren-mode t)
(setq show-paren-style 'parentheses)

;;speedbar设置
;;(autoload 'speedbar-frame-mode "speedbar" "Popup a speedbar frame" t)
;;(autoload 'speedbar-get-focus "speedbar" "Jump to speedbar frame" t)

;;主浮页和speedbar浮页之间的切换快捷键——不用设置，因为系统本身可以使用M-Tab来实现

;;设置speedbar默认出现在左侧
;;(add-hook 'speedbar-mode-hook
;;        (lambda ()
;;         (auto-raise-mode 1)
;;         (add-to-list 'speedbar-frame-parameters '(top . 0))
;;         (add-to-list 'speedbar-frame-parameters '(left . 0))
;;         ))

;显示所有文件
;;(setq speedbar-show-unknown-files t)

;;设置tags排列顺序为按照出现的先后次序排列
;;(setq speedbar-tag-hierarchy-method '(speedbar-prefix-group-tag-hierarchy))

;;关闭当前缓冲区
(global-set-key [f4] 'kill-this-buffer) 
(global-set-key [C-tab] 'switch-to-buffer)

;;设置字体，默认是Monospace  
;;set-defalut-font  
;;(set-default-font "Monospace")  
(set-default-font "-unknown-DejaVu Sans Mono-normal-normal-normal-*-17-*-*-*-m-0-iso10646-1")  ;;个人感觉Mono系字体适合程序（对普通青年）  

;;custom-set-variables  
;;set-color  
;;(set-background-color "black")  ;;use black-ground  
;;(set-foreground-color "white")  ;;use white-fore  
;;(set-face-foreground 'region "green") ;;  
;;(set-face-background 'region "blue") ;;  

;;===============================================================  
;;外观设置  
;;===============================================================  
;; 可以把光标由方块变成一个小长条  
(setq cursor-type 'bar)
;; 去掉滚动条  
;;(set-scroll-bar-mode nil)  
;;关闭开启画面  
(setq inhibit-startup-message t)  
;;禁用工具栏  
;;(tool-bar-mode 0)  
;;禁用菜单栏  
;;(menu-bar-mode nil)  
  
;;remove alert-bell  
;;(mouse-wheel-mode t)  
  
  
(global-linum-mode 'linum-mode)  
;;auto show row-num  
;;自动加载行号  
  
(partial-completion-mode 1)  
;;use partial-completion  
  
(icomplete-mode 1)  
;;use complete-completion  
  
  
;; 高亮当前行  
;;(require 'hl-line-settings)  
  

;;======================================================================  
  
  
  
;;======================================================================  
;;状态栏  
;;======================================================================  
;;显示时间  
;;(display-time)  
(display-time-mode 1);;启用时间显示设置，在minibuffer上面的那个杠上  
(setq display-time-24hr-format t);;时间使用24小时制  
(setq display-time-day-and-date t);;时间显示包括日期和具体时间  
;;(setq display-time-use-mail-icon t);;时间栏旁边启用邮件设置  
;;(setq display-time-interval 10);;时间的变化频率，单位多少来着？  
  
  
;;显示列号  
(setq column-number-mode t)  
;;没列左边显示行号,按f3显示/隐藏行号  
(require 'setnu)  
(setnu-mode t)  
;;(global-set-key[f3] (quote setnu-mode))  
  
;;显示标题栏 %f 缓冲区完整路径 %p 页面百分数 %l 行号  
(setq frame-title-format "%f")  
  
;;=======================================================================  
;;缓冲区  
;;=====================================================================  
;;设定行距  
(setq default-line-spaceing 4)  
;;页宽  
(setq default-fill-column 60)  
;;缺省模式 text-mode  
;;(setq default-major-mode 'text-mode)  
;;设置删除记录  
(setq kill-ring-max 200)  
;;以空行结束  
;;(setq require-final-newline t)  
;;开启语法高亮。  
(global-font-lock-mode 1)  
;;高亮显示区域选择  
(transient-mark-mode t)  
;;页面平滑滚动,scroll-margin 3 靠近屏幕边沿3行开始滚动，正好可以看到上下文  
;;(setq scroll-margin 3 scroll-consrvatively 10000)  
;;高亮显示成对括号  
(show-paren-mode t)  
(setq show-paren-style 'parentheses)  
;;鼠标指针避光标  
(mouse-avoidance-mode 'animate)  
;;粘贴于光标处,而不是鼠标指针处  
;;(setq mouse-yank-at-point t)  
  
;;=======================================================================  
;;回显区  
;;=======================================================================  
;;闪屏报警  
(setq visible-bell t)  
;;使用y or n提问  
(fset 'yes-or-no-p 'y-or-n-p)  
;;锁定行高  
(setq resize-mini-windows nil)  
;;递归minibuffer  
(setq enable-recursive-minibuffers t)  
;;当使用M-x COMMAND后，过1秒显示该COMMAND绑定的键  
(setq suggest-key-bindings-1)   ;;默认？  
  
;;======================================================================  
;;编辑器的设定  
;;======================================================================  
;;不产生备份文件  
(setq make-backup-files nil)  
;;不生成临时文件  
(setq-default make-backup-files nil)  
;;只渲染当前屏幕语法高亮，加快显示速度  
(setq lazy-lock-defer-on-scrolling t)  
;;(setq font-lock-support-mode 'lazy-lock-mode)  
(setq font-lock-maximum-decoration t)  
;;将错误信息显示在回显区  
(condition-case err  
    (progn  
      (require 'xxx))  
  (error  
   (message "Can't load xxx-mode %s" (cdr err))))  
;;使用X剪贴板  
(setq x-select-enable-clipboard t)  
;;设定剪贴板的内容格式 适应Firefox  
(set-clipboard-coding-system 'ctext)  
  
;;设置TAB宽度为4  
;;(setq default-tab-width 4)   
;;以下设置缩进  
;;用tab缩进  
(setq indent-tabs-mode t)  
(setq c-indent-level 4)  
(setq c-continued-statement-offset 4)  
(setq c-brace-offset -4)  
(setq c-argdecl-indent 4)  
(setq c-label-offset -4)  
(setq c-basic-offset 4)  
(global-set-key "\C-m" 'reindent-then-newline-and-indent)  
