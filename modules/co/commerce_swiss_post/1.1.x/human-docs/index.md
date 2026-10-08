# Commerce Swiss Post — manual setup guide

**Commerce Swiss Post** (`commerce_swiss_post`) provides a **Swiss Post shipping method** for
Drupal Commerce, generates **Swiss Post shipping labels** (barcode/address-label PDFs), and can
**verify Swiss (CH) and Liechtenstein (LI) addresses** against Swiss Post's Address Web
Services. It lets stores that ship within or from Switzerland offer a Swiss Post delivery
option at checkout and produce the corresponding labels.

The buyer-facing price is a **flat rate** you configure on the shipping method (the plugin
extends Commerce's Flat rate); the Swiss Post API is used for label generation and address
verification, not for quoting the checkout price. It is a shipping feature with no
access-control role of its own. Because label generation and address verification send store
and customer **address data** to Swiss Post, and both use **API credentials**, treat those
credentials as secrets and keep the calls over HTTPS — see "How to use it" below.

The module targets Drupal 10.1+ and 11. Note it is currently **seeking co-maintainers**, so
weigh its maintenance status for a production store.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module.

This module has **two** places you configure it: a dedicated **Swiss Post Settings** page for
API credentials, and the usual Commerce **shipping method** form for the flat rate. Both are
described in "How to use it" below.

## Where it lives in the admin menu

- API credentials and label options: **Configuration → Web services → Swiss Post Settings**
  (`/admin/config/services/swiss-post-settings`).
- The shipping method itself: **Commerce → Configuration → Shipping methods**
  (`/admin/commerce/shipping-methods`).

## How to use it

1. Go to **Configuration → Web services → Swiss Post Settings**
   (`/admin/config/services/swiss-post-settings`) and fill in the Swiss Post
   **API host**, **Client ID**, **Client Secret**, **Franking License**, and the label layout
   (A5/A6/A7). The **Print Preview** option produces "SPECIMEN" test labels. If you want CH/LI
   address verification, fill in the **Address web services** host, username and password too.
   Treat the Client Secret and the address-service password as **secrets**: keep them out of
   version-controlled configuration — for example set them from an environment variable in
   `settings.php` with a config override
   (`$config['commerce_swiss_post.settings']['client_secret'] = getenv('SWISSPOST_CLIENT_SECRET');`).
   The API host defaults to `https://wedec.post.ch`, so calls run over HTTPS.
2. Go to **Commerce → Configuration → Shipping methods**
   (`/admin/commerce/shipping-methods`) and click **Add shipping method**.
3. Choose the **Swiss Post** plugin, set the **flat rate** amount and, in the *Swiss Post
   Shipping Method* field, the Swiss Post product code (e.g. `ECO`, `PRI`). Save.
4. To store label PDFs on shipments, add the *Swiss Post Barcode Label* entity trait to your
   shipment type and make sure the **private** file system is configured.
5. Generate labels from a shipment's **Generate label** operation, or with the **Download Swiss
   Post Shipping labels** bulk action on the orders list.
6. Because label generation and address verification send store and customer **address data** to
   Swiss Post, make sure that is consistent with your privacy policy.

At checkout, customers shipping to eligible destinations will see the Swiss Post option at its
flat rate; you then generate Swiss Post labels for the resulting shipments.
