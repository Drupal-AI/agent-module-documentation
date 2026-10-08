# MKC Accelerator Digital Goods — manual setup guide

**MKC Accelerator Digital Goods** (`mkc_accel_digital`) adds digital-product
selling to a **MonkeysCommerce** store: downloadable files, software license keys,
and access keys. It handles secure file delivery through signed, token-based
download links, generates license keys automatically on purchase, counts downloads
and enforces limits/expiry, and provides headless APIs for download and license
management. At checkout it recognises digital-only carts (skipping the shipping
step), delivers links and keys instantly on order completion, and copes with mixed
carts where shipping applies only to the physical items.

It introduces two main entities — **DigitalDownload** (a file tied to a product
variant, tracking download count, max downloads and expiration) and **LicenseKey**
(auto-generated or manually assigned, with activation/deactivation/expiry tracking)
— plus services for signed download URLs, key generation and license management.
Customers get **My Downloads** and **My Licenses** pages; administrators get
management screens for downloads, licenses and delivery settings.

This is an add-on for MonkeysCommerce, so it depends on the MonkeysCommerce core
plus its catalog and order modules (`mkc_core`, `mkc_catalog`, `mkc_order`), and
targets Drupal 11.3+ on PHP 8.2+.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module on your MonkeysCommerce store.
2. [Configuration](configuration/index.md) — set download limits, key formats and
   delivery options, and manage downloads and licenses.

## Where it lives in the admin menu

Once enabled, the module's screens sit under **Commerce → Digital**:

- `/admin/commerce/digital/downloads` — manage all digital downloads.
- `/admin/commerce/digital/licenses` — manage all license keys.
- `/admin/commerce/digital/settings` — configure download limits, key formats and
  delivery options.

Customers use `/user/downloads` and `/user/licenses`, and secure downloads are
served from `/digital/download/{token}`.
