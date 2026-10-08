# Cloudflare Email — manual setup guide

**Cloudflare Email** (`cloudflare_email`) lets Drupal send its outbound
transactional email through the **Cloudflare Email Service REST API** over HTTPS,
with no SMTP relay involved. Many hosting platforms block outbound SMTP ports
(25/587), which stops Drupal from sending account, password‑reset and
notification emails; this module sidesteps that entirely by replacing Drupal's
mail backend with one that talks to Cloudflare over the same HTTPS that the rest
of your traffic already uses.

It is a drop‑in mail backend: once it is the site's default mail plugin, all of
Drupal's outgoing mail routes through Cloudflare. It sends both plain‑text and
HTML messages (generating a plain‑text fallback from HTML automatically), adds a
health check to the status report, and ships a Drush command to send a test
message. Your Cloudflare API token is stored with the **Key** module — referenced
by ID and never written into exported configuration.

This module needs a bit of setup before it works: you enable it, create a Key
holding a Cloudflare API token, fill in the settings form, and then make it
Drupal's default mail backend. It requires the **Key** module and depends on core
**System**. It also needs a Cloudflare account on the Workers Paid plan with the
Email Service enabled, a verified sending domain, and a token with the *Email
Sending: Send* permission. Two optional submodules extend it: **Analytics**
(`cloudflare_email_analytics`) adds a delivery report, and a **Symfony Mailer
Lite** bridge (`cloudflare_email_symfony_mailer_lite`).

> **Current limitations to know up front:** attachments are not yet supported,
> inbound mail / Email Routing is out of scope (this is sending‑only), and bounce
> and complaint webhooks are not yet processed. The 1.0.x branch is an early
> alpha.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and the Key module
   with Composer and enable them.
2. [Configuration](configuration/index.md) — create the Key, fill in the settings
   form, make it the default mail backend, and send a test message.

## Where it lives in the admin menu

The settings form is at **Configuration → System → Cloudflare Email**
(`/admin/config/system/cloudflare-email`), which requires the **Administer
Cloudflare email** permission.
