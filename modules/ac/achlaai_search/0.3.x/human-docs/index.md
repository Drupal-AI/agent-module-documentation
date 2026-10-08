# Achla AI Search — manual setup guide

**Achla AI Search** (`achlaai_search`) connects your Drupal site to the hosted
**Achla AI Search** service and embeds a search-and-answer widget on your public
pages. The heavy lifting — indexing your content, generating answers, billing, and
the widget's design — all lives in the Achla SaaS. The Drupal module is deliberately
small: it proves your site owns the domain, stores the resulting connector
authority locally, checks the connection's status, and places the verified widget.

Connecting does **not** use a pasted API key. Instead it uses Achla's **Ownership
v2** protocol: you start a connection attempt from the admin page, and Achla
completes it by calling your site back server-to-server to confirm ownership. The
widget only appears once ownership is proven, and it serves only signed,
backend-authorized releases — the module will not load arbitrary JavaScript.

Only a widget released and signed by Achla is placed, and the module fails closed if
it cannot verify that. Its admin and configuration screens are restricted to a
single, deliberately-granted permission, and its one public endpoint (the ownership
callback) is authenticated by cryptography and rate-limited rather than left open —
so there is no key for an administrator to leak and no arbitrary code to inject.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and grant the connector permission (plus migrating from the legacy package).
2. [Configuration](configuration/index.md) — connect with Ownership v2, place the
   widget, and check the status.

## Where it lives in the admin menu

The settings page sits at **Configuration → Web services → Achla AI Search**
(`/admin/config/services/achlaai-search`), gated by the restricted **Manage the
Achla AI Search connector** permission. A status page is at
`/admin/config/services/achlaai-search/status`.
