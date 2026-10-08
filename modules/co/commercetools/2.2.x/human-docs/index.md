# commercetools — manual setup guide

**commercetools** (`commercetools`) provides the base integration between Drupal
and the **commercetools** headless/API‑first commerce platform. Once you enter
your commercetools credentials, your Drupal site gains a full‑featured online
store — multi‑language, multi‑country, multi‑currency, multiple stocks, checkout,
payments, and order management — with the products, customers, and PII data all
stored on the commercetools side rather than in your Drupal database.

The problem it solves: it connects Drupal to a commercetools **project** via its
API and caches the data needed to render product pages locally (with instant
cache invalidation via commercetools Subscriptions, or a cron‑based fallback), so
your Drupal database stays compact and free of PII while still serving a complete
storefront. Product listings and filters can be placed into any page using native
Drupal **Blocks** and **Layout Builder**.

Important: this is the **base module and provides no end‑user UI on its own**. To
get a storefront you also install one of the UI modules:

- **commercetools Content** — the coupled approach, rendering everything on the
  backend and delivering a fully pre‑rendered page (best first‑load performance).
- **commercetools Decoupled** — the decoupled approach, delivering interactive
  Web Components that load data on the frontend via GraphQL (best for in‑page
  catalog browsing and filtering; usable inside React/Vue/Angular SPAs).

The module requires no other Drupal dependencies and works largely out of the
box: you enter your commercetools **Client ID**, **Client secret**, and **Project
key** on its settings page and it starts working. If you don't have credentials
yet, a bundled demo submodule lets you try the functionality without an account.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the base
   module, and add a UI module.
2. [Configuration](configuration/index.md) — enter your commercetools credentials
   on the settings page.

## Where it lives in the admin menu

Once enabled, the settings page is at **Configuration → commercetools**
(`/admin/config/system/commercetools`). That is where you enter your Client ID,
Client secret, and Project key. See [Configuration](configuration/index.md).
