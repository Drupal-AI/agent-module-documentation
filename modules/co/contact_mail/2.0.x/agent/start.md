<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Contact Mail (contact_mail) — agent index

Utility that post-processes core Contact-module notification emails. Implements
`hook_mail_alter()` (only for mail ids `contact_page_mail` / `contact_page_copy`) to add
site-wide extra recipients, re-render the submission as an HTML block, prepend a configurable
header, and optionally set a `text/html` content type. No third-party libraries.

- **Machine name:** `contact_mail`  ·  **Package:** Mail  ·  **License:** GPL-2.0-or-later
- **Core:** `^11 || ^12`  ·  **PHP:** 8.3+
- **Depends on:** `contact` (core Contact module). No other Drupal or Composer deps.
- **Config route:** `contact_mail.settings` → `/admin/config/system/contact-mail`
  (permission `administer contact forms`). Menu link under System config.
- **Config object:** `contact_mail.settings` (keys `tpl`, `html`, `emails`, `header`).
  Ships defaults in `config/install/contact_mail.settings.yml`. No config/schema in this release.
- **Permissions:** none of its own (reuses core `administer contact forms`).
- **Drush commands:** none.

## Provides

- **Service** `contact_mail.mail_alter` → `Drupal\contact_mail\Hook\MailAlter` — the alter logic.
- **hook_theme** `contact_mail` (`Drupal\contact_mail\Hook\Theme`) → template
  `templates/submission.html.twig`, variables `type`, `submission`.
- **Alter hooks for other modules:** `contact_mail_alter_message`, `contact_mail_alter_emails`
  (invoked via `module_handler->alter()` inside `MailAlter::alter()`).
- **Settings form:** `Drupal\contact_mail\Form\Settings` (`ConfigFormBase`, form id
  `contact_mail_settings`).

## Solution docs

- [Configuration & settings form](config/settings.md) — config keys, route, defaults, operation.
- [Mail-alter behaviour & extension hooks](api/mail-alter.md) — how the message is rewritten,
  recipient handling, HTML rendering, and the two alter hooks.
