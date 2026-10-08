# Clover Commerce Sync — manual setup guide

**Clover Commerce Sync** (`clover_commerce_sync`) keeps your Drupal Commerce store
in step with a [Clover POS](https://www.clover.com/) account. It pulls current
product **prices** and **stock levels** from Clover using the Clover REST API (v3)
and writes them onto your Commerce product variations — so the prices and inventory
a customer sees online match what's happening at the register.

It solves the classic "two systems, two truths" problem for retailers who ring up
sales in‑store on Clover but also sell online through Drupal Commerce. Clover
prices (stored in cents) are converted to your store currency and applied to
variations; stock is written through the [Commerce Stock](https://www.drupal.org/project/commerce_stock)
module when it's installed, or onto a plain integer field otherwise. Items are
matched between the two systems by **SKU** — a Clover item and a Commerce variation
are linked when their SKUs match exactly; anything without a match is skipped
silently.

Syncing happens three ways: on a **cron schedule** (configurable from every 15
minutes up to once a day), on demand via a **"Run sync now"** button on the
settings page, and in near‑real‑time through an optional **webhook** endpoint
(`/clover-sync/webhook`) that Clover calls whenever an item changes. Because Clover
sends only the id of the changed item, the module re‑fetches the current value from
the API before applying it. The module handles Clover's rate limits gracefully
(paging delay plus exponential backoff on HTTP 429), so it's safe on large
catalogues.

If you rely on webhooks, set the webhook secret before exposing the endpoint. The
module is marked *minimally maintained*.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Commerce dependencies.
2. [Configuration](configuration/index.md) — obtain Clover credentials, fill in the
   settings form field by field, match SKUs, and set up the webhook safely.

## Where it lives in the admin menu

The settings and manual‑sync trigger live at **Commerce → Clover Sync**
(`/admin/config/commerce/clover-sync`), gated by the **Administer clover commerce
sync** permission.
