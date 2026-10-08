# PHPMailer SMTP — manual setup guide

**PHPMailer SMTP** (`phpmailer_smtp`) makes Drupal send its email through an
external SMTP server using the well-known, battle-tested **PHPMailer** library
instead of the default PHP `mail()` function. That means reliable, RFC-compliant
delivery through a real mail service (SendGrid, Amazon SES, Mailgun, your
company's mail server, and so on), with support for HTML emails, attachments, and
inline images.

There are two things to understand about how it works. First, it depends on the
**PHPMailer** PHP library, which Composer installs for you. Second — and this
trips people up — **enabling the module alone changes nothing**: it only *provides*
a mail plugin. You have to tell Drupal to actually route mail through it, which is
almost always done with the companion **Mail System** module (`mailsystem`).

Once wired up, you configure your SMTP host, port, encryption, and credentials on
the module's settings form. The most secure setup is port **465** with SSL/TLS
(fully encrypted from the start); port 587 with STARTTLS is also supported but
upgrades a plain-text connection and is considered slightly less secure. For
sensitive credentials, prefer keeping them out of exported configuration — the
module supports the Key module and settings.php overrides. It also has an
extension point for OAuth2 authentication.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and PHPMailer
   library with Composer, enable it, and add the Mail System module.
2. [Configuration](configuration/index.md) — the SMTP transport settings, the
   email-format form, and activating it as the site's mail system.

## Where it lives in the admin menu

PHPMailer SMTP has two settings forms under **Configuration → System**:

- **PHPMailer SMTP** (`/admin/config/system/phpmailer-smtp`, route
  `phpmailer_smtp.settings`) — the SMTP transport (host, port, encryption, auth).
- **Format** (`/admin/config/system/phpmailer-smtp/format`, route
  `phpmailer_smtp.format`) — whether email is sent as plain text or HTML.

Both are gated by the **Administer PHPMailer SMTP settings** permission. To make
Drupal actually use PHPMailer SMTP you then visit **Configuration → System → Mail
System** (provided by the Mail System module) and select it as the sender and
formatter — see the configuration guide.
