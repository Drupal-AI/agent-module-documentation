# Gmail API — manual setup guide

**Gmail API** (`gmail`) sends your Drupal site's outgoing email through Google's
**Gmail API** using OAuth2, instead of the server's local PHP `mail()` function or
a plain SMTP connection. It registers a mail plugin — `GmailSystem` — that builds
each message and hands it to Google's API for delivery, which can improve
deliverability for sites sending from a Google Workspace or Gmail account.

Setting it up has two halves. On the Google side you create an OAuth 2.0 client in
the Google Cloud console, enable the Gmail API, and register your site's callback
URL. On the Drupal side you enter the resulting client id and secret, run the
Google consent flow once to obtain an access/refresh token, and then route your
site mail through the Gmail plugin. The module depends on the Google API PHP
client and PHPMailer, both installed via Composer.

Because this module handles OAuth credentials and can send mail as your Google
account, treat its settings as sensitive. The configuration guide covers where the
secrets live and an important caution about the OAuth callback route.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its Composer
   dependencies, and enable it.
2. [Configuration](configuration/index.md) — create the Google OAuth client, enter
   the credentials, complete consent, and select the mailer.

## Where it lives in the admin menu

Once enabled, the settings form sits at **Configuration → System → Gmail API**
(`/admin/config/system/gmail`, route `gmail.config`), gated by the *Administer
Gmail module* permission. The OAuth consent flow returns to a callback at
`/gmail-api/callback`.
