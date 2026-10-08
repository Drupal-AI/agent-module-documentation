# Ecwid Ecommerce Shopping Cart — manual setup guide

**Ecwid Ecommerce Shopping Cart** (project `ecwid_shopping_cart`, module machine
name `ecwid`) embeds an [Ecwid](https://www.drupal.org/project/ecwid_shopping_cart)
hosted online store into your Drupal site. Instead of running a full commerce
stack inside Drupal, your products, categories, cart, and checkout all live on
Ecwid's servers and are rendered on your pages through a JavaScript storefront
embed. It's the lightweight way to add a shop to a Drupal site without operating
Drupal Commerce.

You connect the site to your Ecwid store through an **OAuth authorization flow**.
Once connected, the module gives you a storefront page at `/store`, a "connect"
page to start the link, and an admin **control‑panel iframe** (backed by Ecwid
single sign‑on) so you can manage the store from inside Drupal. No inventory or
order data is stored in Drupal — everything lives in Ecwid — so backups, upgrades,
and PCI‑style checkout security are handled on Ecwid's side.

One important naming quirk: the **project/Composer package** is
`ecwid_shopping_cart`, but the **module you enable** is `ecwid` (that's the machine
name inside `ecwid.info.yml`). Install with the project name, enable with `ecwid`.

Before you go live, treat the stored store credentials (in `ecwid.config`) as
sensitive and keep config exports out of public repositories (see
[Configuration](configuration/index.md)).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   `ecwid` module.
2. [Configuration](configuration/index.md) — connect your Ecwid store over OAuth,
   manage it from the control panel, and expose the storefront.

## Where it lives in the admin menu

The module registers a handful of paths rather than a single settings form:

- **Connect the store:** `/admin/ec-store-connect` (starts the OAuth flow; the
  callback `/admin/ec-store-connect/token` finishes it).
- **Manage the store:** `/admin/ec-store` (the Ecwid control‑panel iframe).
- **Storefront:** `/store` (the public shop page your visitors see).
