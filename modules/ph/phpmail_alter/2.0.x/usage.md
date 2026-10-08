<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
PhpMail Alter implements `hook_mail_alter()` to force the From/Reply-to headers from configuration and, optionally, to send outbound mail through its own PHP `mail()` backend that supports HTML bodies, non-Latin sender names, contact-form file attachments and a debug log.

---

PhpMail Alter (2.x, Drupal 11/12) has two jobs, both driven by the single config object `phpmail_alter.settings`. First, on every outbound message its `hook_mail_alter()` (in `src/Hook/MailAlter.php`) overwrites `$message['headers']['From']` with the configured `from` value and sets `Reply-to` from the configured `reply` value when the message has no reply-to yet. Second, when the `phpmail` flag is on it sets `$message['send'] = FALSE` (so Drupal's default mail plugin does not also send) and delivers the message itself through the `phpmail_alter` service (`src/Service/PhpMail.php`), a fork of core's PhpMail backend calling PHP's native `mail()`. That backend adds features core's lacks: it emits a proper `text/html; charset=utf-8` body when the Content-Type header is `text/html` (wrapping the body in `<html>…</html>`), MIME-encodes the display-name part of the From value so non-Latin sender names work, derives a `List-Unsubscribe` header from Reply-to, and — when the message parameters carry a Contact form submission (`params['contact_message']`) whose entity has file fields — reads those managed files and appends them as base64 `multipart/mixed` attachments. Header values other than From are encoded through Symfony Mime's `UnstructuredHeader`, the optional envelope `Return-Path` is passed as a `-f` argument only after an `isShellSafe()` allow-list check, and long plain-text lines are wrapped. A separate `phpmail_alter.debug` service logs a full dump of each send (recipient, encoded/decoded subject, body, headers) to the `phpmail_alter` logger channel when the `debug` flag is on, and logs an error there if `mail()` returns false. The single admin form (`src/Form/Settings.php`, route `phpmail_alter.settings` at `/admin/config/system/phpmail-alter`, permission `administer site configuration`) exposes exactly four fields — Rewrite PhpMail, From Header, Reply to, Debug mode. The module ships no permissions of its own, no Drush commands, no config schema and no declared module dependencies (file-field attachments only run when the `file`/`contact` stack is present). The deprecated class `src/Controller/PhpMail.php` remains only as a backward-compatible shim that logs a warning and delegates to the service.

---

- Force a consistent envelope/From address on all outgoing site mail regardless of which module generated it.
- Set a site-wide default Reply-to address for outbound mail.
- Send HTML email from Drupal via the native `mail()` function (add a `text/html` Content-Type header and get a real `text/html; charset=utf-8` message).
- Use a non-Latin (e.g. Cyrillic) display name in the From header and have it correctly MIME-encoded.
- Attach files uploaded through a core Contact form to the notification email automatically.
- Add a `List-Unsubscribe` header (built from the Reply-to address) to improve deliverability/spam scoring.
- Replace Drupal's default PhpMail backend behaviour without writing a custom mail plugin.
- Turn on debug mode to log the full recipient, subject, body and headers of every send to the `phpmail_alter` log channel.
- Diagnose mail-delivery failures: a failed `mail()` call surfaces a user message and an error log entry.
- Keep Drupal's own `register_no_approval_required` mail on the default sender (that message id is deliberately skipped by the rewrite).
- Wrap over-long plain-text body lines automatically before sending.
- Let another module adjust the final From value at send time via the `phpmail_alter_from` alter hook.
- Pass a validated envelope sender (`-f` / Return-Path) to the MTA when `sendmail_path` doesn't already set one.
- Provide a simple admin-only settings screen for sender/reply/debug without touching code.
- Standardise sender identity across contact forms, user emails and other transactional mail.
- Serve as a drop-in HTML-capable mail backend on small sites that use PHP `mail()` rather than SMTP.
- Migrate an existing 1.x (Drupal 9–11) install to the 2.x branch on Drupal 11/12.
