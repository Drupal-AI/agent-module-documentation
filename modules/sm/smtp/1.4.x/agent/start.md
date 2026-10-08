# smtp — agent start

Routes Drupal's outgoing mail through an external SMTP server via a PHPMailer-based core Mail
plugin (`SMTPMailSystem`). No module deps; bundles `phpmailer/phpmailer`. Config UI:
**Admin → Config → System → SMTP Authentication Support** (`/admin/config/system/smtp`, route
`smtp.config`). Single permission: `administer smtp module`.

- Settings: host, port, protocol, auth, From, test email, reroute → [configure/settings.md](configure/settings.md)
- How it delivers mail (Mail plugin) + selective use with Mailsystem → [extend/mail-plugin.md](extend/mail-plugin.md)
