# COOKiES Media Entity Facebook — manual setup guide

**COOKiES Media Entity Facebook** (`cookies_media_entity_facebook`) is a small glue
module that brings Facebook media embeds under **COOKiES** consent management. If
your site uses the **Media Entity Facebook** module to embed Facebook content, this
submodule ensures that embedded Facebook content is only loaded **after** the visitor
grants the relevant cookie consent — so third‑party Facebook embeds stay
GDPR‑compliant instead of loading (and tracking) before consent.

It is purely a consent‑integration bridge: it has no settings of its own and no
access‑control role. It simply registers Facebook media with the COOKiES consent
framework so the existing consent banner and gating handle it. It depends on both the
**COOKiES** module and the **Media Entity Facebook** module (version 4.0.0 or later),
and it works on Drupal 9.3+, 10, and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside COOKiES and Media Entity Facebook.

There is **no configuration page** for this module — it has no settings form. Consent
handling for Facebook media is governed by your COOKiES configuration, described under
"How it works" below.

## Where it lives in the admin menu

This module adds no admin page. Once enabled, Facebook media embeds are gated
automatically through your existing COOKiES setup — the consent service definitions
and banner live in the COOKiES module.

## How it works

Once all three modules are enabled, any Facebook media (from Media Entity Facebook)
on your site is registered with COOKiES. When a visitor who has not consented to the
relevant service views a page with a Facebook embed, COOKiES withholds the embed and
shows its consent placeholder in its place; the Facebook content loads only after
consent is given. There is nothing to configure in this submodule itself — make sure
the corresponding service is set up in your COOKiES configuration.
