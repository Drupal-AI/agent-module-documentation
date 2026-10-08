# Google Bard Integration — manual setup guide

**Google Bard Integration** (`google_bard`) adds a simple "ask Bard" query form to
your Drupal site. A visitor types a message at `/google-bard`, the module sends it
to Google's Bard chat endpoint, and the reply is converted from Markdown to HTML
and shown back on the page. It's a lightweight way to prototype a generative‑AI
chat feature inside the CMS.

It is important to understand how this module authenticates before you use it. It
does **not** use an official API key. Instead it drives the consumer Bard web
endpoint (`bard.google.com`) using two session **cookies** captured from a signed‑in
Google account (`__Secure-1PSID` and `__Secure-1PSIDTS`). Those cookies are
effectively full Google‑account credentials, so treat this as an experimental /
demo integration tied to a single account — not something to run in production.

> **Deprecated.** The maintainers recommend moving to Google Gemini for AI
> integration. For real, supported AI work on Drupal, prefer the official provider
> ecosystem (the Drupal AI module and its Google/Gemini provider) rather than this
> cookie‑based approach.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — enter the two Google session cookies
   the module uses to talk to Bard, and understand what you are storing.

## Where it lives in the admin menu

The settings form sits at **Configuration → System → Google Bard settings**
(`/admin/config/system/google-bard-settings`), which requires the *Administer site
configuration* permission.

## How to use it

Once the cookies are configured, visit `/google-bard`, type a prompt, and submit.
The most recent answer is rendered on the page. Note that the last answer is held
in shared site state, so it is not private per user — another visitor to the form
may see the previous response. Keep this in mind before exposing the form to
anonymous traffic.
