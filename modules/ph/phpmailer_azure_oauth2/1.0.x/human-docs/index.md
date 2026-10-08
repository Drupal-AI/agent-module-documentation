# PHPMailer Azure OAuth2 — manual setup guide

**PHPMailer Azure OAuth2** (`phpmailer_azure_oauth2`) lets Drupal send email through
Microsoft 365 / Outlook SMTP using **Microsoft Entra ID (Azure AD) OAuth2**
authentication (XOAUTH2), instead of the old username‑and‑password basic auth that
Microsoft is phasing out. It builds on the
[PHPMailer SMTP](https://www.drupal.org/project/phpmailer_smtp) module: you register
an application in Entra ID, connect it here, authorise it once, and Drupal then
sends mail with short‑lived OAuth2 tokens that the module keeps refreshed
automatically.

It is designed with credential safety in mind. The OAuth2 **client secret is stored
via the [Key](https://www.drupal.org/project/key) module** (typically backed by an
environment variable), and the access and refresh **tokens are kept in Drupal's State
API** — never written into exported configuration. It refreshes tokens on cron,
warns administrators if a refresh token is getting old (around 75 days), and protects
its authorisation callback against CSRF. If you already use the older
`phpmailer_oauth2` module, a built‑in two‑step migration wizard can import your
existing settings and tokens.

It depends on the PHPMailer SMTP and Key modules, and supports Drupal 10.3, 11 and
12.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside PHPMailer SMTP and Key.
2. [Configuration](configuration/index.md) — register the Entra ID app, store the
   client secret, connect and authorise, and point PHPMailer SMTP at it.

## Where it lives in the admin menu

The settings form is at **Configuration → System → PHPMailer Azure OAuth2**
(`/admin/config/system/phpmailer-azure-oauth2`), behind the *administer phpmailer
azure oauth2 settings* permission. Full step‑by‑step guidance is on the
[Configuration](configuration/index.md) page.
