# Amazon PAAPI5 — manual setup guide

**Amazon PAAPI5** (`amazon_pa`) connects Drupal to the **Amazon Product
Advertising API version 5**. With it your site can fetch product data from
Amazon — details, pricing, images, and affiliate links — and display that data
in your content. It is a common building block for affiliate sites, product
comparison pages, and anywhere you want to surface live Amazon product
information.

The module ships two submodules: **`amazon_pa_filter`** (a text filter for
turning references into product output) and **`asin`** (working with Amazon ASIN
product identifiers). It provides its own permissions and a settings form where
you enter your Amazon API credentials.

To talk to Amazon's API you authenticate with an **access key**, a **secret
key**, and a **partner (associate) tag**. Treat the access and secret keys as
secrets: store them in environment variables rather than exported configuration,
and let Drupal read them from there. Requests go out over HTTPS to Amazon, and
you should respect Amazon's PA-API terms and rate limits. Product data you fetch
is external data, so it is escaped on display like any untrusted content.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and pick the submodules you need.
2. [Configuration](configuration/index.md) — enter your Amazon API credentials
   and partner tag.

## Where it lives in the admin menu

Once enabled, the module's settings form is available at the Amazon PAAPI5
settings page (route `amazon_pa.admin_settings`), reachable from the admin
configuration area. See [Configuration](configuration/index.md) for what to
enter there.
