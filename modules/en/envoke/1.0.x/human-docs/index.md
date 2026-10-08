# Envoke — manual setup guide

**Envoke** (`envoke`) is a connector that lets Drupal use
[Envoke](https://envoke.com/) — an email marketing platform — as its mail/mailing
provider. With it, mail and newsletters go out through Envoke's API, and subscriber
information can be managed against the Envoke platform rather than only through
Drupal's own mail system.

The module is young — it describes itself as having fairly basic functionality and
is at a beta release — but the core idea is straightforward: point Drupal at your
Envoke account with an API key and let Envoke handle delivery. It provides its own
permission to control who can use its features.

One thing is worth understanding before you wire it up: using Envoke means
**recipient/subscriber data (which is personal data) and message content leave your
site and are sent to Envoke's API** — an egress that should be reflected in your
privacy policy and data‑processing agreements. You authenticate by entering your
**Envoke API credentials** on the module's settings form.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — supplying the Envoke API credentials,
   setting sender defaults, and routing mail through Envoke.

## Where it lives in the admin menu

Envoke's settings live under **Configuration** (in the Mail area) where you enter
the API credentials that connect Drupal to your Envoke account. The module also
adds its own permission, granted at **People → Permissions**, so you can decide who
is allowed to use its mailing features.
