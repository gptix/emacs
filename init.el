(recentf-mode 1)
(setq recentf-max-menu-items 100)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

(global-visual-line-mode 1)

;;;;
;; Packages
;;;;

;; Define package repositories
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)

;; Load and activate emacs packages. Do this first so that the
;; packages are loaded before you start trying to modify them.
;; This also sets the load path.
(package-initialize)
;;(package-refresh-contents)

(defvar my-packages
  '(;; makes handling lisp expressions much, much easier
    ;; Cheatsheet: http://www.emacswiki.org/emacs/PareditCheatsheet

;;    slime

    sly
    
    intero

    ;; key bindings and code colorization for Clojure
    ;; https://github.com/clojure-emacs/clojure-mode
    clojure-mode

    ;; extra syntax highlighting for clojure
    clojure-mode-extra-font-locking

    ;; integration with a Clojure REPL
    ;; https://github.com/clojure-emacs/cider
    cider

    ;; colorful parenthesis matching
    rainbow-delimiters

    ;; git integration
    magit
    ))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;; By adding the directory "vendor", AND THEN downloading any elisp
;; files into ~/.emacs.d/vendor, you'll be able to easily load them.
;;
;; For example, if you download yaml-mode.el to ~/.emacs.d/vendor,
;; then you can add the following code to this file:
;;
;; (require 'yaml-mode)
;; (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
;; 
;; Then these lines will make Emacs enter yaml mode whenever you open
;; a .yml file
(add-to-list 'load-path "~/.emacs.d/vendor")

;;;;
;; Customization
;;;;

;; Add a directory to our load path so that when you `load` things
;; below, Emacs knows where to look for the corresponding file.
(add-to-list 'load-path "~/.emacs.d/customizations")

;; These customizations change the way emacs looks and disable/enable
;; some user interface elements
(load "ui.el")

(load "edit-server.el")


;; Configure slime
(setq inferior-lisp-program "/usr/bin/sbcl")
(setq slime-contribs '(slime-fancy))


;; Configure for Haskell and Intero
(add-hook 'haskell-mode-hook 'intero-mode)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-cursor-mode nil)
 '(package-selected-packages (quote (engine-mode slime))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "fixed" :foundry "misc" :slant normal :weight normal :height 98 :width normal)))))


;; try to use TRAMP
(setq tramp-default-method "ssh")

;; Load the engine-mode library into Emacs:
(require 'engine-mode)

;; Define an engine (with the keybinding "C-x / d") that'll search DuckDuckGo:
(defengine duckduckgo
  "https://duckduckgo.com/?q=%s"
  :keybinding "d")

;; Enable the engine-mode minor mode everywhere:
(engine-mode t)

(dolist (hook '(text-mode-hook))
  (add-hook hook (lambda () (flyspell-mode 1))))
