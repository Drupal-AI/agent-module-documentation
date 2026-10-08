<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# PhpMail Alter (phpmail_alter) — agent index

Alters Drupal's outbound mail. `hook_mail_alter()` forces `From`/`Reply-to` from config and,
when enabled, hands delivery to a native-`mail()` backend that supports **HTML bodies**,
**non-Latin From names** and **Contact-form file attachments**. Package `Mail`.
Core `^11 || ^12`. License GPL-2.0-or-later. Version **2.0.3** (dir `2.0.x`).

- No permissions of its own, no Drush, no config schema, no declared module dependencies.
- One config object: **`phpmail_alter.settings`** (`phpmail`, `from`, `reply`, `debug`).
- One admin route: **`phpmail_alter.settings`** → `/admin/config/system/phpmail-alter`
  (permission `administer site configuration`), menu link under *Configuration → System*.

## Docs

- **Config object, the settings form, and the four fields** →
  [config/settings.md](config/settings.md)
- **The alter hook, the `phpmail_alter` mail backend, attachments, debug service and the
  `phpmail_alter_from` alter** → [api/service.md](api/service.md)

## What it actually is (from source)

- `phpmail_alter.module` → `phpmail_alter_mail_alter()` delegates to
  `Drupal\phpmail_alter\Hook\MailAlter::hook()` (`src/Hook/MailAlter.php`). It sets
  `$message['headers']['From']` from config `from`; sets `Reply-to` from config `reply` when
  `$message['reply-to']` is empty; and, if config `phpmail` is on and the message id is not
  `register_no_approval_required`, sets `$message['send'] = !service('phpmail_alter')->mail($message)`
  (i.e. it sends via its own backend and stops core from double-sending).
- Service **`phpmail_alter`** = `Drupal\phpmail_alter\Service\PhpMail` (implements
  `PhpMailInterface`); ctor deps `@phpmail_alter.debug`, `@config.factory`, `@module_handler`,
  `@messenger`, `@file.mime_type.guesser` (`phpmail_alter.services.yml`).
- Service **`phpmail_alter.debug`** = `Drupal\phpmail_alter\Service\DebugService`
  (implements `DebugServiceInterface`); deps `@config.factory`, `@logger.factory`. Logs full
  send data to the `phpmail_alter` channel when `debug` is on; logs a send failure as an error.
- `src/Controller/PhpMail.php` — **deprecated** back-compat shim: static `mail()` logs a warning
  and delegates to the `phpmail_alter` service. Not routed; do not use in new code.
- No `*.permissions.yml`, no `*.install`, no `config/schema/`, no submodules. `config/install/`
  ships defaults for `phpmail_alter.settings`.

## Security-relevant facts (public, non-sensitive)

- `From`/`Reply-to` come from **admin config** (route gated by `administer site configuration`),
  not from request input. Header values other than From are encoded via Symfony Mime
  `UnstructuredHeader`; the envelope `Return-Path` is only used as a `-f` arg after an
  `isShellSafe()` allow-list check (`[^a-zA-Z0-9@_\-.]` rejected). Attachments are read only from
  managed file entities referenced by a Contact message. This mirrors core's PhpMail threat model.
