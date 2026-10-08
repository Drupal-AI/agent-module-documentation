<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# PHPMailer SMTP (phpmailer_smtp) — agent index

Sends Drupal mail through an external SMTP server via a core Mail plugin
(`PhpMailerSmtp`, id `phpmailer_smtp`) that extends the `phpmailer/phpmailer` library class and
implements `MailInterface` (`format()` + `mail()`). Unlike the `smtp` module it does **not**
auto-swap the mail system — you select it as Sender/Formatter through Mail System (`mailsystem`)
or core `system.mail`. No Drupal module dependencies declared. Requires the PHPMailer **7**
library (`phpmailer/phpmailer:^7.1.1`; `hook_requirements()` enforces 7.1.1+). This is the
maintained 2.x branch; a separate 3.0.x branch is documented elsewhere.

- **Provides:** one `@Mail` plugin (`phpmailer_smtp`); one plugin type `PhpmailerOauth2`
  (manager `plugin.manager.phpmailer_oauth2`, annotation `@PhpmailerOauth2`); config schema
  for `phpmailer_smtp.settings` + `phpmailer_smtp.format`; themeable `phpmailer_smtp` template.
- **Config UI:** Admin → Config → System → PHPMailer SMTP (`/admin/config/system/phpmailer-smtp`,
  route `phpmailer_smtp.settings`) plus a Format subtab (route `phpmailer_smtp.format`).
- **Permission:** `administer phpmailer smtp settings` (`restrict access: TRUE`).
- **No** hook_install; `.install` only ships `hook_requirements()` (library version check) and
  config-add update hooks.

Solution docs:

- SMTP host/port/auth/encryption/TLS + activating the plugin as the mail system → [configure/phpmailer_smtp.md](configure/phpmailer_smtp.md)
- The `PhpmailerOauth2` OAuth2 plugin type (how XOAUTH2 auth is wired) → [plugins/oauth2.md](plugins/oauth2.md)
- The one permission gating the config forms → [permissions/phpmailer_smtp.md](permissions/phpmailer_smtp.md)
