;; TODO: can I move more of this stuff into config.org?
;; TODO: can I clean up this file with some automatic formatting?

(require 'cl)

(defvar local-package-archives
  (list '("melpa" . "https://melpa.org/packages/")
        '("org" . "https://orgmode.org/elpa/")))

(defvar essentials
  (list 'org-plus-contrib
        'use-package
        'color-theme-sanityinc-tomorrow))

(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives (append package-archives local-package-archives))
(package-initialize)

(defun package-not-installed-p (pkg)
  "Checks if PKG is NOT installed"
  (not (package-installed-p pkg)))

(defun package-install-ensure (pkg)
  "Installs a package if it isn't already"
  (unless (package-installed-p pkg)
    (package-install pkg)))

(if (some #'package-not-installed-p essentials)
    (package-refresh-contents))

(mapc #'package-install-ensure essentials)

(if (require 'quelpa nil t)
  (with-temp-buffer
    (url-insert-file-contents
     "https://raw.github.com/quelpa/quelpa/master/bootstrap.el")
    (eval-buffer)))

(setq org-agenda-files (quote ("~/.emacs.d/notes.org")))
(org-babel-load-file (expand-file-name "~/.emacs.d/config.org"))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :foundry "1ASC" :family "ProTamsyn2x")))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (sanityinc-tomorrow-bright)))
 '(custom-safe-themes
   (quote
    ("1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" default)))
 '(global-whitespace-mode t)
 '(line-number-mode nil)
 '(org-agenda-files nil)
 '(package-selected-packages
   (quote
    (expand-region omnisharp omnisharp-emacs emacs-async xelb org-wild-notifier erc-image erc-hl-nicks nlinum flycheck-irony irony-eldoc company-irony dired+ dired-plus org-plus-contrib magit ebuild-mode pkgbuild-mode quelpa-use-package quelpa package-build company-go slime-company slime company-jedi zzz-to-char swiper siper popup-kill-ring nyan-mode symon dmenu diminish spaceline company dashboard rainbow-delimiters sudo-edit switch-window rainbow-mode rainbow which-key use-package smex purple-haze-theme org-bullets ido-vertical-mode fill-column-indicator color-theme-sanityinc-tomorrow clues-theme avy afternoon-theme))))

;; disable bold fonts globally AFTER loading the theme and
;; everything else so there's no way they get overridden
;; TODO: find a nicer way to do this
(mapc
 (lambda (face)
   (set-face-attribute face nil :weight 'normal))
 (face-list))
