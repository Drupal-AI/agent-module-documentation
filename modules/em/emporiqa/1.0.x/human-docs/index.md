# Emporiqa — manual setup guide

**Emporiqa** (`emporiqa`) connects a Drupal Commerce storefront to **Emporiqa**, an
AI chat assistant that acts as an online salesperson: it recommends products from
your own catalog, answers product and policy questions, handles objections, and
walks shoppers to checkout in 65+ languages. The search, conversation logic, and
language model run as a managed service; this module handles the Drupal side —
syncing your catalog and content, embedding the chat widget, and supporting an
in‑chat cart and checkout.

The module reads Drupal Commerce through Drupal's own APIs: products and variations
sync with resolved, promotion‑aware prices, any content type (shipping, returns,
FAQs) syncs through its display modes, and stock can come from Commerce Stock,
custom fields, or publish status. It exposes small JSON cart endpoints so the chat
can read the visitor's cart and add or update items (operating on the current
session's cart via Commerce's cart provider, with CSRF protection), and it issues a
signed user‑identity token so the widget can identify a logged‑in shopper. Drush
commands and alter hooks are provided for sync control and customization.

Emporiqa depends on **Commerce Product** (`commerce_product`) and core **Node**,
and it provides its own permissions. It needs configuration before it works: you
create an Emporiqa account, set a strong signing secret, and sync your catalog.

> **Set the signing secret strongly.** The user‑identity token is HMAC‑signed with
> an admin‑configured `webhook_secret`, entered on the module's settings form. Use a
> long, high‑entropy value. Until the secret is set, the token endpoint returns nothing.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Commerce dependency.
2. [Configuration](configuration/index.md) — create an Emporiqa account, set the
   signing secret, sync your catalog, and put the widget live.

## Where it lives in the admin menu

After enabling the module, you configure it in Drupal (the signing secret and sync
options) and complete the rest of the setup — the widget, pricing playground, and
dashboard — in your Emporiqa account. See [Configuration](configuration/index.md).
