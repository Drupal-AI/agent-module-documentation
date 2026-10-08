# Postmark — agent index

Sends Drupal mail through the Postmark transactional-email REST API (via `wildbit/postmark-php`)
as a Mail System (`mailsystem`) mail plugin. Requires a Postmark Server API token and a verified
Sender Signature.

- **Settings form, config keys, debug/test options, enabling the plugin via Mail System** →
  [configure/settings.md](configure/settings.md)
- **The `postmark_mail` mail plugin and `PostmarkHandler` service for programmatic sending** →
  [api/mail.md](api/mail.md)
- **The `administer postmark` permission** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Depends on `mailsystem`; select `Postmark mailer` (`postmark_mail`) on
  `/admin/config/system/mailsystem` as the Sender.
- `configure` route `postmark.settings` → `/admin/config/mail/postmark` (perm `administer postmark`,
  `restrict access: TRUE`).
- Config object `postmark.settings`: `postmark_api_key`, `postmark_sender_signature`,
  `postmark_debug_mode`, `postmark_debug_email`, `postmark_debug_no_send`, plus `format_filter`.
- Service `postmark.mail_handler` (`PostmarkHandler`) wraps `PostmarkClient::sendEmail()`.
- All mail is sent FROM the Sender Signature address (not the message's own From).
- No Drush commands, no submodules, no config schema.
