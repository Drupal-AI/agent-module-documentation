# Postmark — manual setup guide

**Postmark** (`postmark`) sends your site's outbound email through the third-party
[Postmark](https://postmarkapp.com/) transactional-email service over its HTTPS
REST API, instead of relying on local SMTP or `sendmail`. It's a good fit for
improving deliverability of transactional mail (password resets, order receipts)
and for hosts that block outbound SMTP ports.

It plugs into the **Mail System** module as a mail plugin, so you can route
*all* mail through Postmark, or only mail from specific modules (say, Commerce
order emails) while leaving the rest on Drupal's default mailer. When Drupal sends
a message, the plugin formats the body — optionally running it through a chosen
text format and always deriving a plain-text alternative from HTML — and hands it
to Postmark's official PHP client.

One important rule: Postmark requires that all mail be sent **from a single
verified Sender Signature**. The module enforces this by using your configured
signature as the From address on every send (for core Contact-form mail, the
submitter's address becomes the Reply-To instead). The settings form also gives
you debug tools: redirect all mail to one inbox on staging, log full API
responses, or use a "no-send" test mode that validates your setup without spending
a Postmark credit.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (it pulls in two
   PHP libraries), enable it, and note the Mail System dependency.
2. [Configuration](configuration/index.md) — point Mail System at Postmark, enter
   your Server API token and Sender Signature, and use the debug/test options.

## Where it lives in the admin menu

The Postmark settings form is at **Configuration → System → Postmark**
(`/admin/config/mail/postmark`), gated by the restricted **Administer Postmark**
permission. Choosing which mail Postmark handles happens on the Mail System form
at **Configuration → System → Mail System** (`/admin/config/system/mailsystem`).

## How to use it

Install the module, select the **Postmark mailer** as the sender on the Mail
System page, then enter your Postmark **Server API token** and a **verified Sender
Signature** on the Postmark settings form. Send a test email from that form to
confirm it works. See [Configuration](configuration/index.md) for the full
walkthrough, including keeping your API token out of exported config.
