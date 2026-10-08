# Symfony Mailer MS Graph — manual setup guide

**Symfony Mailer MS Graph** (`symfony_mailer_ms_graph`) adds a Microsoft Graph
API mail transport to the [Symfony Mailer](https://www.drupal.org/project/symfony_mailer)
module, so Drupal can send email through Microsoft 365 using modern OAuth2
instead of SMTP basic authentication (which Microsoft has been retiring). It
lets your site deliver mail straight through the Graph API from a Microsoft 365
mailbox.

The module supports two independent authentication methods, and you can use
either one or run both side by side. **Application (client credentials)** sends
mail as a shared/system mailbox using app-only permissions with no user login —
ideal for automated notifications, transactional email and cron-triggered mail.
**Delegated (OAuth 2.0 authorization code)** sends as a specific named Microsoft
365 mailbox that authorizes the app once through a Microsoft sign-in; a refresh
token keeps that authorization alive and is renewed automatically on cron.

It does **not** work purely on-enable — it gives you two transports that you
must configure before any mail flows through them. It depends on the
`symfony_mailer` module and on the [Key](https://www.drupal.org/project/key)
module, which stores the OAuth2 client secret securely (backed by an environment
variable rather than exported configuration). Administration is gated by the
`administer symfony mailer ms graph` permission. It supports Drupal 10.1, 11 and
12. One compatibility note: this is the module's **1.x** branch, which pairs with
**Symfony Mailer 1.x** — if your site runs Symfony Mailer 2.x you need the
module's 2.x branch, or the transport plugins will not be discovered.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, add the Key
   dependency, and enable the module.
2. [Configuration](configuration/index.md) — set up the Application and/or
   Delegated transport, field by field, and authorize with Microsoft.

## Where it lives in the admin menu

Once enabled, the module automatically creates two mailer transports. You edit
them under **Configuration → System → Mailer transport**
(`/admin/config/system/mailer`) — look for the **Microsoft Graph (Application)**
and **Microsoft Graph (Delegated)** transports. From there you either set one as
Symfony Mailer's default transport (so all site mail uses it) or attach it to a
Mailer Policy to route only specific email types through it.
