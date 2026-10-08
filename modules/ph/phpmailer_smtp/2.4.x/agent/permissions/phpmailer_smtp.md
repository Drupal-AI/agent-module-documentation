<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# PHPMailer SMTP permissions

The module defines one permission (`phpmailer_smtp.permissions.yml`):

| Permission | Gates |
|---|---|
| `administer phpmailer smtp settings` | Access to **both** config forms — the transport settings (`/admin/config/system/phpmailer-smtp`, route `phpmailer_smtp.settings`) and the message format form (route `phpmailer_smtp.format`). |

- Marked `restrict access: TRUE` — it is a security-sensitive permission (grants access to the
  SMTP username/password and can change how all site mail is sent).
- Grant only to trusted administrators.
- The same permission also controls whether an *elevated* SMTP debug level is applied for the
  current user: in `PhpMailerSmtp::smtpInit()`, `SMTPDebug` is raised to the configured
  `smtp_debug` value only when the current user holds `administer phpmailer smtp settings`.
