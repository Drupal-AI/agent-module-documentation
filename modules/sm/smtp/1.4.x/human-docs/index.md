# SMTP Authentication Support — manual setup guide

**SMTP Authentication Support** (`smtp`) routes all of Drupal's outgoing email
through an external SMTP server of your choice — Gmail / Google Workspace,
SendGrid, Mailgun, Amazon SES, Office 365, or a corporate relay — instead of
handing mail to the local server's PHP `mail()` function. It uses the bundled
**PHPMailer** library to open an authenticated, optionally encrypted connection
to that server, which makes delivery far more reliable and keeps your messages
out of spam folders.

When you turn SMTP on, it replaces Drupal's default mail system with its own
PHPMailer-based backend and remembers the previous one so it can be restored if
you turn SMTP off again. This guide is written for a **human** clicking through
the admin UI: it walks you, step by step and with screenshots, from installing
the module to filling in your SMTP server details and sending a test email to
confirm everything works. If you are looking for terse, token-cheap references
for an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

![The SMTP Authentication Support settings page](images/settings.png)

## Where it lives in the admin menu

Everything in this guide sits under **Configuration → System → SMTP
Authentication Support** (`/admin/config/system/smtp`). That single settings page
holds the on/off toggle, the SMTP server details (host, backup host, port,
encryption, timeout), the authentication username and password, the site-wide
"from" address and name, and a built-in tool for sending a test email. Access is
controlled by the **`administer smtp module`** permission.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and store your SMTP password securely.
2. [Configuration](configuration/index.md) — turn SMTP on, enter your server and
   authentication details, set the default "from" address, and send a test email
   to verify delivery.
