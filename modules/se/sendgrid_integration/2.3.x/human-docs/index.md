# SendGrid Integration — manual setup guide

**SendGrid Integration** (`sendgrid_integration`) sends all of Drupal's outgoing
email through the **SendGrid** transactional email Web API instead of your server's
local mail or SMTP. It provides a mail plugin that, once selected as your site's
mail system, delivers every message Drupal sends — registration emails, password
resets, contact‑form messages, commerce receipts — over SendGrid's HTTPS API. That
usually means much better deliverability than a stock PHP mail setup.

The plugin builds each SendGrid message from Drupal's own mail data: it parses the
From/To/Cc/Bcc/Reply‑To headers, splits multipart bodies into plain‑text and HTML
parts (generating a plain‑text alternative automatically), attaches files, and
applies click/open tracking from your settings. Every message is tagged with
SendGrid **categories** (site name, sending module, message key) so you can filter
and report on mail inside the SendGrid dashboard. Sends that fail with a retryable
error are queued and retried on cron.

Two things are worth knowing up front. First, this module only *provides* the
SendGrid mail plugin — it does not hijack Drupal's mail on its own. You activate it
by selecting it in the required **Mailsystem** module. Second, your SendGrid API key
is a secret: the module can read it from plain config, from a **Key** entity (if the
Key module is installed), or from `settings.php`, so you can keep it out of version
control.

The bundled **SendGrid Integration Reports** sub‑module adds a statistics dashboard
built from SendGrid's stats API.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (it pulls in the
   SendGrid PHP libraries and Mailsystem), and enable the modules.
2. [Configuration](configuration/index.md) — set the API key, choose tracking,
   activate SendGrid as your mail system, and send a test email.

## Where it lives in the admin menu

- The settings form is at **Configuration → System → SendGrid**
  (`/admin/config/services/sendgrid`), with a **Test** tab for sending a trial
  email.
- You activate SendGrid as the mail system at **Configuration → System → Mail
  System** (`/admin/config/system/mailsystem`), provided by the Mailsystem module.
