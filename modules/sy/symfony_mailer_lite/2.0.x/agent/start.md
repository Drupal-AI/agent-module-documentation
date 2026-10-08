# symfony_mailer_lite — agent start

Mail plugin + transport system that sends HTML mail/attachments via the Symfony Mailer library.
Drop-in successor to Swiftmailer. Requires `mailsystem`; assign it as formatter/sender there.
Transports live at **Config → System → Symfony Mailer Lite**
(`/admin/config/system/symfony-mailer-lite/transport`).

- Assign the mailer, configure transports, message settings, test → [configure/settings.md](configure/settings.md)
- Transport plugin type (native/smtp/sendmail/null/dsn) + how to add one → [plugins/transport.md](plugins/transport.md)
- Email template + theme suggestions → [theming/email-template.md](theming/email-template.md)
- Permission → [permissions/permissions.md](permissions/permissions.md)
