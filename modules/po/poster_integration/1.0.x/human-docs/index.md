# Poster integration — manual setup guide

**Poster integration** (`poster_integration`) connects **Drupal Commerce** to the
[Poster](https://joinposter.com) POS/inventory service. It works in two directions: it
**imports** Poster categories and products into your Commerce store (creating Commerce product
types, product variations, taxonomy terms, and product images), and it **pushes** completed
Commerce orders back to Poster as "incoming orders" through Poster's HTTP API. It's aimed at
restaurants and retailers who run a Poster POS and want their Drupal Commerce catalogue and
orders kept in sync.

All API calls go over HTTPS to Poster's fixed endpoint (`https://joinposter.com/api/`) using
an **access token** you provide. When an order reaches its completed state, the module sends
the billing name and address plus the ordered SKUs and quantities to Poster automatically.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token‑cheap references for an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable it
   alongside Drupal Commerce.

The module's settings live on a single Commerce configuration form (covered under
"Where it lives" and "How to use it" below), so there is no separate configuration chapter.

## Where it lives in the admin menu

The settings form is at **`/admin/commerce/config/poster_integration`**, protected by the
**Setup poster integration** permission. It holds:

- **Access token** — your Poster API access token.
- **Spot id** — the Poster spot (location) that orders and data belong to.
- **Send orders** — a switch that turns the "push completed orders to Poster" behaviour on or
  off.

The same permission gates the **Load categories** and **Load products** import forms.

## How to use it

1. Grant the **Setup poster integration** permission to the role that will manage the
   integration.
2. Open **`/admin/commerce/config/poster_integration`** and enter your **access token** and
   **spot id**. Save.
3. Use the **Load categories** and then **Load products** forms to import your Poster catalogue
   into Commerce. The import creates the product/variation types, a `categories` taxonomy, the
   necessary fields, and downloads product images.
4. When you are ready for orders to flow back to Poster, enable **Send orders**. Make sure your
   checkout/payment gateway has **Collect billing information** turned on, so completed orders
   carry the name and address that the order push needs.

### A note on the access token

The access token is a credential that grants API access to your Poster account, so treat it as
a secret. By default this module stores it in its own configuration
(`poster_integration.settings`). For a hardened setup, keep the token out of exported configuration and version control —
store the value in an environment variable (with DDEV, `ddev dotenv set .ddev/.env
--poster-token=…` then `ddev restart`) and, where you can, reference it through a **Key**
entity rather than pasting it into the form. All Poster traffic already uses HTTPS.
