;;gdb debug 设置
(setq bin_path "")
(setq gdb_command (concat "gdb -i=mi ~/tcplogger/code/main/builder/bin/tcplogger_d"))

(defun prj-compile()
(interactive)
(if (eq major-mode 'c++-mode)
  (setq command			
	    (concat "cd ~/tcplogger/code/main/builder/ && ./rebuild.lsp"))
  (message "Unknow mode, won't compile!"))
(compile command))
(defun compile-run()
  (interactive)
  (if (eq major-mode 'c++-mode)
      (setq command			
	    (concat "cd ~/tcplogger/code/main/builder/ && ./rebuild.lsp && cd bin && ./tcplogger_d ../../config_dev.xml"))
    (message "Unknow mode, won't compile!"))
  (compile command))
(defun gdb-or-gud-go ()
  "If gdb isn't running; run gdb, else call gud-go."
  (interactive)
  (if (and gud-comint-buffer
           (buffer-name gud-comint-buffer)
           (get-buffer-process gud-comint-buffer)
           (with-current-buffer gud-comint-buffer (eq gud-minor-mode 'gdba)))
      (gud-call (if gdb-active-process "continue" "run") "")
    ;;    (gdb "gdb -i=mi ~/tcplogger/code/main/builder/bin/tcplogger_d")))
    (gdb (gud-query-cmdline 'gdb))))
(defun gud-break-remove ()
  "Set/clear breakpoin."
  (interactive)
  (save-excursion
    (if (eq (car (fringe-bitmaps-at-pos (point))) 'breakpoint)
        (gud-remove nil)
      (gud-break nil))))
(defun gud-kill ()
  "Kill gdb process."
  (interactive)
  (with-current-buffer gud-comint-buffer (comint-skip-input))
  (kill-process (get-buffer-process gud-comint-buffer)))
(defadvice gdb-setup-windows (after my-setup-gdb-windows activate)
  "my gdb UI"
  (gdb-get-buffer-create 'gdb-stack-buffer)
  (set-window-dedicated-p (selected-window) nil)
  (switch-to-buffer gud-comint-buffer)
  (delete-other-windows)
  (let ((win0 (selected-window))
        (win1 (split-window nil nil 'left))      ;code and output
        (win2 (split-window-below (/ (* (window-height) 2) 3)))     ;stack
        )
    (select-window win2)
    (gdb-set-window-buffer (gdb-stack-buffer-name))
    (select-window win1)
    (set-window-buffer
     win1
     (if gud-last-last-frame
         (gud-find-file (car gud-last-last-frame))
       (if gdb-main-file
           (gud-find-file gdb-main-file)
         ;; Put buffer list in window if we
         ;; can't find a source file.
         (list-buffers-noselect))))
    (setq gdb-source-window (selected-window))
    (let ((win3 (split-window nil (/ (* (window-height) 3) 4)))) ;io
      (gdb-set-window-buffer (gdb-get-buffer-create 'gdb-inferior-io) nil win3))
    (select-window win0)
    ))
(setq gdb-many-windows t)
(setq gud-tooltip-mode t)

(defun my_gdb_debug()
  (interactive)
  (gdb gdb_command))

(defun my-c++-mode-hook()
  (local-set-key [C-f7] 'prj-compile)
  (local-set-key [C-f5] 'compile-run)
  (local-set-key [f5] 'my_gdb_debug)
  (local-set-key [M-f5] 'gud-go)
  (local-set-key [S-f5] 'gud-kill)
  (local-set-key [Shift-f8] 'gud-print)
  (local-set-key [C-f8] 'gud-pstar)
  (local-set-key [f9] 'gud-break-remove)
  (local-set-key [f10] 'gud-next)
  (local-set-key [C-f10] 'gud-until)
  (local-set-key [S-f10] 'gud-jump)
  (local-set-key [S-f11] 'gud-step)
  (local-set-key [C-f11] 'gud-finish)
  )
(add-hook 'c++-mode-hook 'my-c++-mode-hook)
