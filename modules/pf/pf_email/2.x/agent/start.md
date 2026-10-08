<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Push Framework Email (pf_email) — agent index

**The email delivery channel for the Push Framework — mails each rendered notification to the recipient user's own account email via Drupal's mail manager.** Version 2.3.0 (doc dir `2.x`).

- **Core:** `^10 || ^11`. **PHP:** `>=8.1`. **License:** GPL-2.0-or-later. Package `Push`.
- **Depends on:** `push_framework` (`drupal/push_framework:^2.3`). No other modules, no libraries, no Drush.
- **Config route:** `pf_email.settings` → `/admin/config/system/push_framework/email`, permission `administer site configuration` (a tab under the framework's channel settings).
- **Config object:** `pf_email.settings` (`active`, `use_default_settings`). Schema is supplied by `push_framework`, not this module.
- **Provides:** one `ChannelPlugin` (id `email`) + a settings form; no permissions, no entities, no services, no custom plugin types.

- **The channel plugin, hook_mail, settings form, and how it operates** →
  [config/settings.md](config/settings.md)

## What it actually is

- One channel plugin: `Email` (id **`email`**, label *"Email"*) in
  `src/Plugin/PushFrameworkChannel/Email.php`, extending `push_framework`'s `ChannelBase`.
  Injects `plugin.manager.mail`. `getConfigName()` → `pf_email.settings`;
  `applicable()` returns the channel's `active` flag; `send()` mails the notification.
- One `hook_mail()` in `pf_email.module` (key `notification`) that assembles the subject/body
  and, for HTML mail, sets `Content-Type: text/html` and wraps the body in a minimal HTML
  document with a `<base href>` at the site root.
- One settings form: `src/Form/Settings.php` extends `push_framework`'s `Form\Settings`, only
  overriding `getFormId()` (`pf_email_settings`) and `getEditableConfigNames()`
  (`['pf_email.settings']`). All fields come from the parent framework form.

## Mechanism (from source)

- `Email::send($user, $entity, $content, $attempt)` picks the content variant for
  `$user->getPreferredLangcode()` (falling back to the first key if absent), then calls
  `mailManager->mail('pf_email', 'notification', $user->getEmail(), <langcode>, [...])` with
  `subject`, `body`, and `is html` from that variant. Returns `RESULT_STATUS_SUCCESS` /
  `RESULT_STATUS_FAILED` per the mail manager's `result`.
- Recipient is always `$user->getEmail()` — the framework-selected user's own registered address.
  Content is produced by the framework's notification templates, not by this module.
- `pf_email_mail()` puts `$params['subject']` into `$message['subject']` and appends
  `$params['body']` to `$message['body']`; HTML mode adds the `<html>…<base>…</head><body>`
  prefix (`Markup::create`, static markup) and `</body></html>` suffix.

## Notes / caveats

- `provides_config_schema` is **false** here — `pf_email.settings` keys (`active`,
  `use_default_settings`) validate against a base schema defined by `push_framework`.
- `pf_email.links.task.yml` declares its local task under the key **`pg_email.settings`**
  (a `pg`/`pf` typo). It is cosmetic — the task's `route_name` is the correct
  `pf_email.settings` — so the "Email" tab still works.
- Actual mail transport (SMTP, Symfony Mailer, etc.) is whatever the site configures for the
  mail manager; this module only formats and hands off the message.
