# phpmailer_smtp — agent start

Sends Drupal mail through an external SMTP server via a core Mail plugin
(`PhpMailerSmtp`, id `phpmailer_smtp`) that wraps the `phpmailer/phpmailer` library and
implements `MailInterface`. Unlike the `smtp` module it does **not** auto-swap the mail
system — you select it as Sender/Formatter through Mail System (`mailsystem`) or core
`system.mail`. No module dependencies declared; bundles `phpmailer/phpmailer` (^6.11).
Config UI: **Admin → Config → System → PHPMailer SMTP** (`/admin/config/system/phpmailer-smtp`,
route `phpmailer_smtp.settings`). Single permission: `administer phpmailer smtp settings`.

- SMTP host/port/auth/encryption + activating the plugin as the mail system → [configure/phpmailer_smtp.md](configure/phpmailer_smtp.md)
- The one permission gating the config forms → [permissions/phpmailer_smtp.md](permissions/phpmailer_smtp.md)
