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

(alert-define-style 'android :title "Android"
                    :notifier #'alert-android-notifier)

(use-package alert
  :config
  (setq alert-default-style 'android))

(use-package org-alert
  :init
  (org-alert-enable)
  :config
  (setq org-alert-interval 10))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(org-alert)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
