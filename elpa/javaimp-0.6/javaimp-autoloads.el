;;; javaimp-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "javaimp" "javaimp.el" (22109 20955 683975
;;;;;;  220000))
;;; Generated autoloads from javaimp.el

(autoload 'javaimp-maven-visit-root "javaimp" "\
Loads all modules starting from root module identified by
PATH.  PATH should point to a directory.

\(fn PATH)" t nil)

(autoload 'javaimp-add-import "javaimp" "\
Imports CLASSNAME in the current file.  Interactively,
performs class name completion based on the current module's
dependencies, JDK jars and top-level classes in the current
module.

\(fn CLASSNAME)" t nil)

(autoload 'javaimp-organize-imports "javaimp" "\
Groups and orders import statements in the current buffer.  Groups are
formed and ordered according to `javaimp-import-group-alist'.  Classes within a
single group are ordered in a lexicographic order. Optional NEW-CLASSES
argument is a list of additional classes to import.

\(fn &rest NEW-CLASSES)" t nil)

(autoload 'javaimp-invalidate-jar-classes-cache "javaimp" "\
Resets jar classes cache (debugging only)

\(fn)" t nil)

(autoload 'javaimp-forget-all-visited-modules "javaimp" "\
Resets `javaimp-maven-root-modules' (debugging only)

\(fn)" t nil)

(autoload 'javaimp-reset "javaimp" "\
Resets all data (debugging only)

\(fn)" t nil)

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; javaimp-autoloads.el ends here
