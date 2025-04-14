;;; himalaya-evil.el --- Evil mode support for Himalaya  -*- lexical-binding: t -*-

;; Copyright (C) 2025

;; Author:
;; Maintainer:
;; Version: 1.0
;; Package-Requires: ((emacs "27.1") (evil "1.0.0"))
;; URL: https://github.com/dantecatalfamo/himalaya-emacs
;; Keywords: mail comm evil

;; This file is not part of GNU Emacs

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:
;; Evil mode integration for the Himalaya email client interface.
;; This package provides Evil keybindings for Himalaya modes.

;;; Code:

(require 'evil)
(require 'himalaya-envelope)
(require 'himalaya-message)

;; Define Evil keymaps for each major mode
(defvar himalaya-list-envelopes-mode-evil-map
  (make-sparse-keymap)
  "Evil keymap for `himalaya-list-envelopes-mode'.")

(defvar himalaya-read-message-mode-evil-map
  (make-sparse-keymap)
  "Evil keymap for `himalaya-read-message-mode'.")

(defvar himalaya-read-message-raw-mode-evil-map
  (make-sparse-keymap)
  "Evil keymap for `himalaya-read-message-raw-mode'.")

;; Setup Evil bindings for list-envelopes mode
(evil-define-key '(normal visual) himalaya-list-envelopes-mode-map
  ;; Navigation
  "j" 'next-line
  "k" 'previous-line
  "f" 'himalaya-list-envelopes-next-page
  "b" 'himalaya-list-envelopes-prev-page
  "J" 'himalaya-list-envelopes-at-page
  "n" 'himalaya-list-envelopes
  "gg" 'beginning-of-buffer
  "G" 'end-of-buffer

  ;; Actions
  (kbd "RET") 'himalaya-read-message-at-point
  "w" 'himalaya-write-new-message
  "r" 'himalaya-reply-to-message-at-point
  "R" 'himalaya-reply-to-message-at-point
  "F" 'himalaya-forward-message-at-point

  ;; Marking
  "m" 'himalaya-mark-envelope-forward
  "DEL" 'himalaya-unmark-envelope-backward
  "u" 'himalaya-unmark-envelope-forward
  "U" 'himalaya-unmark-all-envelopes

  ;; Operations
  "D" 'himalaya-delete-marked-messages
  "C" 'himalaya-copy-marked-messages
  "M" 'himalaya-move-marked-messages
  "a" 'himalaya-download-marked-attachments
  "s" 'himalaya-mark-unread-envelope

  ;; Other
  "e" 'himalaya-expunge-folder
  "q" 'kill-current-buffer)

;; Setup Evil bindings for message mode
(evil-define-key '(normal visual) himalaya-read-message-mode-map
  "a" 'himalaya-download-current-attachments
  "q" 'kill-current-buffer
  "R" 'himalaya-read-current-message-raw
  "r" 'himalaya-reply-to-current-message
  "M" 'himalaya-move-current-message
  "f" 'himalaya-forward-current-message
  "n" 'himalaya-next-message
  "p" 'himalaya-prev-message)

(evil-define-key '(normal visual) himalaya-read-message-raw-mode-map
  "a" 'himalaya-download-current-attachments
  "q" 'kill-current-buffer
  "R" 'himalaya-read-current-message-raw
  "r" 'himalaya-reply-to-current-message
  "M" 'himalaya-move-current-message
  "f" 'himalaya-forward-current-message
  "n" 'himalaya-next-message
  "p" 'himalaya-prev-message)

;;;###autoload
(defun himalaya-evil-setup ()
  "Set up Evil integration for Himalaya."
  (when (and (boundp 'evil-mode) evil-mode)
    ;; Add hooks to initialize Evil keymaps when modes are loaded
    (add-hook 'himalaya-list-envelopes-mode-hook #'himalaya-evil-list-envelopes-setup)
    (add-hook 'himalaya-read-message-mode-hook #'himalaya-evil-read-message-setup)
    (add-hook 'himalaya-read-message-raw-mode-hook #'himalaya-evil-read-message-raw-setup)))

(defun himalaya-evil-list-envelopes-setup ()
  "Set up Evil keymaps for himalaya-list-envelopes-mode."
  (evil-make-overriding-map himalaya-list-envelopes-mode-map 'normal)
  (evil-normalize-keymaps))

(defun himalaya-evil-read-message-setup ()
  "Set up Evil keymaps for himalaya-read-message-mode."
  (evil-make-overriding-map himalaya-read-message-mode-map 'normal)
  (evil-normalize-keymaps))

(defun himalaya-evil-read-message-raw-setup ()
  "Set up Evil keymaps for himalaya-read-message-raw-mode."
  (evil-make-overriding-map himalaya-read-message-raw-mode-map 'normal)
  (evil-normalize-keymaps))

;; Initialize Evil integration if Evil is loaded
;; This is now handled in himalaya.el
(provide 'himalaya-evil)
;;; himalaya-evil.el ends here
