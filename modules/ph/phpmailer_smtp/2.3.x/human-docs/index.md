# PHPMailer SMTP — manual setup guide

**PHPMailer SMTP** (`phpmailer_smtp`) makes Drupal send its email through an
external SMTP server instead of the local `mail()` function on your web server.
That is the usual way to get reliable delivery from a real mail provider —
SendGrid, Mailgun, Amazon SES, Postmark, Gmail / Google Workspace, or any other
SMTP relay — so your site's password resets, order confirmations and other
transactional mail actually reach the inbox.

Under the hood it uses the modern, well‑maintained `phpmailer/phpmailer` library
and exposes it to Drupal as a standard **Mail plugin**. One important thing to
know up front: unlike the older `smtp` module, enabling PHPMailer SMTP does **not**
automatically take over your site's mail. It only *offers* itself as an option;
you then have to point Drupal's mail system at it — either through the Mail System
(`mailsystem`) contrib module or with a small change to core's mail
configuration. This is covered step by step in the configuration guide.

It supports SSL or TLS encryption, username/password authentication or OAuth2
(XOAUTH2) via a pluggable authentication system, a backup host for failover, file
attachments, HTML or plain‑text output, and a handy development safety net that
reroutes every outgoing email to a single address so test mail never escapes.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its PHPMailer
   library with Composer, then enable it.
2. [Configuration](configuration/index.md) — activate it as your mail system and
   fill in the SMTP connection settings, field by field.

## Where it lives in the admin menu

The settings live at **Configuration → System → PHPMailer SMTP**
(`/admin/config/system/phpmailer-smtp`), with a second **message format** form
under it. Both are gated by a single permission, *Administer PHPMailer SMTP
settings*.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Point Drupal's mail system at the PHPMailer SMTP plugin — this is the step that
   actually turns it on (see [Configuration](configuration/index.md)).
3. Enter your SMTP provider's host, port, encryption and credentials on the
   settings form.
4. Use the form's **send a test email** field to confirm the connection works.
