# SendGrid — manual setup guide

**SendGrid** (`sendgrid`) routes your Drupal site's outgoing email through the
**SendGrid** (Twilio) email service instead of the local server's mail transport.
Sending through SendGrid's API generally means better deliverability — fewer of
your system emails (password resets, notifications, newsletters) landing in spam —
along with the tracking and delivery insight SendGrid provides.

The module is built on the official SendGrid PHP library and plugs into Drupal
through the **Mail System** module, which is a required dependency: you configure
SendGrid as the mail plugin, and Drupal hands your outbound mail to it. Beyond the
API key you can optionally set a debug mode, an IP pool name, and a few other
options.

To get going you add your SendGrid credentials on the module's settings form
(`/admin/config/services/sendgrid/settings`). Keep the API key out of plain
configuration — store it in a Key entity or an environment variable — since it can
send mail on your account. Administration is gated by the `administer sendgrid`
permission. SendGrid runs on Drupal 9, 10, and 11, and *is* covered by Drupal's
security advisory policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and Mail System)
   with Composer and enable it.
2. [Configuration](configuration/index.md) — add your SendGrid credentials and
   optional settings, and route mail through it.

## Where it lives in the admin menu

Once enabled, the settings form is at **Configuration → Web services → SendGrid
settings** (`/admin/config/services/sendgrid/settings`). Which mail Drupal routes
through SendGrid is controlled through the **Mail System** module's configuration.
