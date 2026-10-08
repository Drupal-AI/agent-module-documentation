<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform Send Multiple Emails (webform_send_multiple_emails) — agent index

Provides one **Webform email handler** that splits a comma-separated To list and sends each
recipient a separate, individually-addressed message (instead of one email addressed to all).
Version **8.x-2.2**. Core `^8.8 || ^9 || ^10 || ^11`. Depends on **`webform`** (`drupal/webform:^6.0`).

Six-file module. No routes, no permissions, no services, no config schema, no config/install, no
settings page (`configure` is null). All logic lives in the single plugin class; configuration is
stored inside the host webform's handler configuration.

## What it provides

- **Plugin** — `@WebformHandler` id `send_multiple_emails`, class
  `Drupal\webform_send_multiple_emails\Plugin\WebformHandler\SendMultipleEmailWebformHandler`,
  extending core `Drupal\webform\Plugin\WebformHandler\EmailWebformHandler`
  (category "Notification", cardinality unlimited, results processed, submission optional).
- **Hook** — `webform_send_multiple_emails_help()` (help.page text only).

## Behaviour in one line

`postSave()` resolves the message via core `getMessage()`, does `explode(',', $message['to_mail'])`,
and calls `$this->sendMessage()` once per address; `postDelete()` does the same for the deleted
state; CC/BCC form fields are hidden to avoid duplicate delivery.

## Solution docs

- [`agent/plugins/send-multiple-emails-handler.md`](plugins/send-multiple-emails-handler.md) —
  the handler plugin: install/enable, added config keys, the send loop, salutation prefix, and the
  test "send to default" option, with class/method citations.
