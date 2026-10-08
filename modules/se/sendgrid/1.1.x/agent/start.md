<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Sendgrid (sendgrid) — agent index

Routes Drupal mail through the SendGrid API using the official `sendgrid/sendgrid` PHP library (~7).
Provides two core Mail plugins — `sendgrid_mail` (send immediately) and `sendgrid_queue_mail`
(enqueue, deliver on cron) — a `sendgrid.mail_handler` service that builds and sends the
`SendGrid\Mail\Mail` object, a settings form, a test-email form, and a pre-send event to alter the
message. Requires `mailsystem` (you select the plugin there); optionally uses `key` to store the API
key as a Key entity.

Core: `^9 || ^10 || ^11`. Configure route: `sendgrid.settings_form`
(`/admin/config/services/sendgrid/settings`). One permission: `administer sendgrid`. No Drush commands.

- **Set the API key, debug/IP-pool/format/theme options, pick the mail plugin, send a test** →
  [configure/settings.md](configure/settings.md)
- **The `administer sendgrid` permission** → [permissions/permissions.md](permissions/permissions.md)
- **Send mail directly via the handler service; the send queue + cron worker** →
  [api/mail-handler.md](api/mail-handler.md)
- **Alter the outgoing email just before it hits the API (`sendgrid.send` event)** →
  [events/send.md](events/send.md)
- **Theme the HTML body, template suggestions, text-format filter** → [theme/theme.md](theme/theme.md)

Key facts:
- Config object `sendgrid.settings`, keys: `api_key` (string — raw key, or a Key entity id when the
  `key` module is on), `debug_mode` (bool), `ip_pool_name` (string), `format_filter` (text-format id),
  `use_theme` (bool).
- Service `sendgrid.mail_handler` = `Drupal\sendgrid\SendgridHandler` implements
  `SendgridHandlerInterface::sendMail(array $message)`; `SendgridHandlerInterface::CONFIG_NAME` =
  `'sendgrid.settings'`.
- Mail plugin ids: `sendgrid_mail`, `sendgrid_queue_mail`. Queue name `sendgrid_send_mail`; QueueWorker
  `sendgrid_send_mail` (`cron` time 10).
- Event constant `SendgridEvents::SEND` = `'sendgrid.send'`, event class `SendgridSendEvent`.
- Theme hook `sendgrid` (template `sendgrid.html.twig`); `hook_install` registers `sendgrid` in
  `system.mail` `interface`.
- Logger channel `sendgrid`. Routes: `sendgrid.settings_form`, `sendgrid.test_email_form`.
