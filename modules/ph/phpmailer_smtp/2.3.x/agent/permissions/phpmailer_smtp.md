# PHPMailer SMTP permissions

The module defines one permission (`phpmailer_smtp.permissions.yml`):

| Permission | Gates |
|---|---|
| `administer phpmailer smtp settings` | Access to **both** config forms — the transport settings (`/admin/config/system/phpmailer-smtp`, route `phpmailer_smtp.settings`) and the message format form (route `phpmailer_smtp.format`). |

- Marked `restrict access: TRUE` — it is a security-sensitive permission (grants access to
  SMTP credentials and can change how all site mail is sent).
- Grant only to trusted administrators.
- The same permission also controls whether elevated SMTP debug output is shown: in the Mail
  plugin, a higher `smtp_debug` level is only applied for the current user if they hold
  `administer phpmailer smtp settings`.
