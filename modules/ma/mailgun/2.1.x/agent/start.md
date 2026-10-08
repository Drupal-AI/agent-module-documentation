<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Mailgun — agent index

Sends Drupal mail through the Mailgun HTTP API. Two Mail plugins (`mailgun_mail`,
`mailgun_queue_mail`) are wired in via **Mailsystem**; all behavior is in the `mailgun.settings`
config object. Real sending needs an API key/domain, but all config is local.

- **Settings keys, the admin form, wiring via Mailsystem, storing the API key securely** →
  [configure/settings.md](configure/settings.md)
- **The two Mail plugins + the cron queue worker** →
  [plugins/mail-plugins.md](plugins/mail-plugins.md)
- **The MailgunHandler service API (send, validate, domains)** →
  [api/handler.md](api/handler.md)
- **Drush: the sql-sanitize queue-empty hook** →
  [drush/commands.md](drush/commands.md)
- **Permission: `administer mailgun`** → [permissions/permissions.md](permissions/permissions.md)

Submodules (own docs):
- `mailgun_email_templates_examples` → `modules/mailgun_email_templates_examples/2.1.x/`
- `mailgun_mailing_lists` → `modules/mailgun_mailing_lists/2.1.x/`

Key facts:
- Config object `mailgun.settings`; configure route `mailgun.admin_settings_form` =
  `/admin/config/services/mailgun/settings`. Test form: `.../settings/test`.
- Mail plugin ids: `mailgun_mail`, `mailgun_queue_mail`. Queue worker id `mailgun_send_mail`.
- Depends on `mailsystem`. Composer lib `mailgun/mailgun-php ~3.0`.
