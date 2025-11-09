;; -*- lexical-binding: t; -*-

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(use-package org-agenda
  :config
  (setq org-agenda-files (list "~/org/agenda")))

(defun alert-android-notifier (info)
  (let-alist (cl--plist-to-alist info)
    (message (format "%s" (cl--plist-to-alist info)))
    (android-notifications-notify :title .title :message .message)))

(defun alert-android-notifier (info)
  (android-notifications-notify :title (plist-get info :title)
				:body (plist-get info :message)))

(use-package alert
  :config
  (alert-define-style 'android :title "Android"
                      :notifier #'alert-android-notifier)
  (setq alert-default-style 'android))

(use-package org-alert
  :demand t
  :config
  (setq org-alert-interval 10)
  (org-alert-enable))

(use-package org-roam
  :demand
  :init
  (setq org-roam-v2-ack t)
  :bind (("C-c n f" . org-roam-node-find)
         ("C-c n g" . org-roam-graph)
         ("C-c n r" . org-roam-node-random)
         (:map org-mode-map
               (("C-c n i" . org-roam-node-insert)
                ("C-c n o" . org-id-get-create)
                ("C-c n t" . org-roam-tag-add)
                ("C-c n a" . org-roam-alias-add)
                ("C-c n l" . org-roam-buffer-toggle))))
  :config
  (require 'ucs-normalize)
  (setq org-roam-directory (file-truename
                            (concat org-directory "/notes/")))
  (org-roam-db-autosync-mode))

(use-package org-roam-dailies
  :bind
  ("C-c n d" . org-roam-dailies-goto-today)
  :config
  (setq org-roam-dailies-directory "daily/")
  (setq org-roam-dailies-capture-templates
        '(("d" "default" entry
           "* %?"
           :target (file+head "%<%Y-%m-%d>.org"
                              "#+title: %<%Y-%m-%d>\n")))))

(use-package ledger-mode)

(use-package org-capture
  :config
  (setq org-capture-templates
        (append '(("l" "Ledger entries")
                  ("ld" "Discover" plain
                   (file "~/ledger/main.ledger")
                   "%(org-read-date) %^{Payee}
  Expenses:%^{Account}           $ %^{Amount}
  Liabilities:Discover
"))
                org-capture-templates)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(ledger-mode magit org-alert org-roam)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
