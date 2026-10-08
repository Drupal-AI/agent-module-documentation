# Mailjet API — manual setup guide

**Mailjet API** (`mailjet_api`) is a deliberately small module that lets your
Drupal site send email through [Mailjet](https://www.mailjet.com/)'s
transactional email API (the Send API v3.1) instead of the local PHP mail
server. Where the larger, official Mailjet module bundles the whole marketing
suite — campaigns, contacts, statistics — this one does a single job well:
provide a Mail plugin that hands your outgoing messages to Mailjet over HTTPS for
better deliverability.

It plugs into Drupal's **Mail System** module, so you can route either all of
your site's mail or just the mail from specific modules through Mailjet. That
makes it a good fit alongside newsletter tools such as Simplenews, or simply as a
reliable transport for password resets and other system email.

Because it authenticates to Mailjet with an API key and secret, those two values
are **live credentials** — treat them like passwords and keep them out of
exported configuration. The configuration guide shows how to store them safely.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (which pulls in
   the Mailjet SDK and the required Mail System module) and enable it.
2. [Configuration](configuration/index.md) — enter your API keys, set the
   options, and point Mail System at the Mailjet mailer.

## Where it lives in the admin menu

After enabling, you configure the module's own settings form (API keys and
options), then tell **Mail System** (**Configuration → System → Mail System**)
to use the **Mailjet API** mailer — globally or for a specific module/key. The
configuration guide walks through both steps.
