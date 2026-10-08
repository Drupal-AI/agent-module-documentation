# Mailgun — manual setup guide

**Mailgun** (`mailgun`) sends your Drupal site's outgoing email through the
**Mailgun** HTTP API instead of the server's PHP `mail()` function. Routing mail
through Mailgun gives you better deliverability (SPF/DKIM handled by Mailgun),
open and click tracking, proper HTML rendering, per‑message tagging for analytics,
and optional queued sending so a slow mail send never holds up a page request.

The module provides two Mail plugins — one that sends immediately and one that
enqueues messages for delivery on cron — which you select through the
**Mailsystem** module as the mailer for all mail or for specific mail keys. All
connection and behavior settings (API key, region endpoint, working domain, test
and debug modes, tracking, the text format used to render the body, queueing, and
tagging) live on one admin settings form, and a companion **Test Email** form lets
you fire off a trial message to confirm everything works.

Two submodules extend it: **Mailgun Email Templates Examples** ships ready‑made
branded HTML email templates, and **Mailgun Mailing Lists** adds a newsletter
signup block and list management backed by Mailgun mailing lists. Because the
module talks to Mailgun's API, actually sending mail needs a valid API key and
domain — but all the configuration and plugin wiring is local to your site.

This guide is written for a **human** setting Mailgun up through the admin UI. If
you want terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its libraries
   with Composer and enable it.
2. [Configuration](configuration/index.md) — enter your API key and domain, wire
   Mailgun in through Mailsystem, tune sending options, and send a test email.

## Where it lives in the admin menu

The settings form is at **Configuration → System → Mailgun**
(`/admin/config/services/mailgun/settings`), with a **Test Email** form at
`/admin/config/services/mailgun/settings/test`. Both are gated by the **Administer
Mailgun** permission. You choose Mailgun as the mailer at **Configuration → System
→ Mailsystem** (`/admin/config/system/mailsystem`).

## How to use it

Enter your Mailgun API key and working domain on the settings form, choose your
region endpoint and any tracking/queue options, then use Mailsystem to select the
Mailgun plugin as the sender (and usually formatter) either globally or for
specific mail keys. Send a test email to verify delivery. See
[Configuration](configuration/index.md) for the step‑by‑step.
