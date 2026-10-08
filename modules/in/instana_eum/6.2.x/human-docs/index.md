# Instana EUM — manual setup guide

**Instana EUM** (`instana_eum`) connects your Drupal site to **Instana End User
Monitoring** — the real‑user monitoring (RUM) side of IBM Instana. Once
configured, it injects Instana's EUM beacon script onto every page, so page‑load
times, performance metrics and JavaScript errors from your visitors' browsers are
reported back to your Instana dashboard. You get a live picture of how the site
actually behaves for real users, without touching your theme's code.

Setup is a single configuration form: you supply the **reporting URL** and **key**
that Instana gives you for your application, save, and browse the site to confirm
data is flowing into the dashboard. Optional switches let you track individual
pages, include admin (`/admin`) traffic, and add your own advanced `ineum(...)`
calls.

Two things are worth knowing up front. The beacon loads the Instana agent script
(`https://eum.instana.io/eum.min.js`) from Instana on every page, so your site
makes an outbound request to that host. And the permission that controls this
form, **configure instana**, is genuinely powerful — the advanced‑settings field
runs its contents as JavaScript in every visitor's browser — so grant it only to
trusted administrators.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — enter your Instana connection
   details and choose what to track.

## Where it lives in the admin menu

Once enabled, the settings form sits at **Configuration → System → Instana EUM
Configuration** (`/admin/config/services/instana_eum`, the `instana_eum.settings`
route). See [Configuration](configuration/index.md) for a field‑by‑field walkthrough.
