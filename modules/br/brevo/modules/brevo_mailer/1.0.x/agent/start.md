# Brevo Mailer — agent index

Submodule of `brevo`. Routes Drupal's outgoing mail through the Brevo transactional API, as a Mail System
`@Mail` plugin or an auto-created Symfony Mailer transport. Depends on `brevo` + `filter`. Config at
`/admin/config/services/brevo/mailer/settings` (`configure: brevo_mailer.admin_settings_form`, permission
`administer brevo`). Config schema `brevo_mailer.settings`. No own permissions, no Drush.

- **Settings (debug/test/format/theme/queue), Mail System vs Symfony Mailer wiring, DSN sync** →
  [configure/settings.md](configure/settings.md)
- **The `brevo_mail` / `brevo_queue_mail` plugins, message building, queue worker** →
  [plugins/mail.md](plugins/mail.md)

Key facts:
- `@Mail` plugins: `brevo_mail` (`BrevoMail`), `brevo_queue_mail` (`BrevoQueueMail`, always queues).
- Handler service `brevo_mailer.mail_handler` (`BrevoMailerHandler`) → `sendTransacEmail()`.
- Config `brevo_mailer.settings`: `debug_mode`, `test_mode`, `format_filter`, `use_queue`, `use_theme`.
- Symfony Mailer: auto-creates transport `brevo` (`brevo+api://<api_key>@default`), kept in sync by
  `BrevoMailerSubscriber` on `brevo.settings` save; DSN field locked in the transport form.
- Queue `brevo_send_mail` drained on cron by `CronSendMail`.
