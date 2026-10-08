<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Mautic Connect — agent index

Syncs Drupal Commerce cart/order/customer data to **Mautic** marketing automation.
Four opt-in features: **Abandoned Cart** (cart HTML + magic-link recovery), **Coupon
Tags**, **Customer Metrics** (RFM), **Customer Details** (name/phone/country). All
Mautic HTTP is delegated to the `advanced_mautic_integration.api` wrapper. Version
**1.4.0**, core `^10 || ^11`, PHP `^8.1`.

Requires `commerce:commerce_cart` and `advanced_mautic_integration`. Optional
`commerce_exchanger` (currency conversion for metrics). Sends customer/cart PII to an
external Mautic instance — a trust-boundary crossing; every feature is **off by
default** and enabling is gated by `administer site configuration`.

- **Features, config keys/defaults, the MauticFeature plugin system, field creation** →
  [features-and-config.md](features-and-config.md)
- **Event subscribers, queue workers, Drush commands, contact matching, magic-link
  recovery, country mapper, sync suspender** → [sync-and-recovery.md](sync-and-recovery.md)

## Key facts
- Configure route: `commerce_mautic_connect.settings` → `/admin/commerce/config/mautic-connect`
  (`administer site configuration`). Single config object `commerce_mautic_connect.settings`.
- No credentials stored here — Mautic base URL + API auth live in
  `advanced_mautic_integration`. This module's config is only feature toggles, Mautic
  field aliases, coupon prefix, and base currency.
- Settings form (`Form/MauticConnectForm`) is a hub: it renders one tab per
  `MauticFeature` plugin (`buildForm`/`validateForm`/`submitForm` delegated to each
  plugin) and shows live Mautic connection status.
- Plugin type: **`MauticFeature`** — PHP-8 attribute `#[MauticFeature(id,label,weight)]`
  (`src/Attribute/MauticFeature.php`), manager
  `plugin.manager.commerce_mautic_connect.mautic_feature`, base
  `MauticFeaturePluginBase`, alterable via `hook_mautic_feature_info_alter()`.
  Four bundled plugins: `abandoned_cart` (w0), `coupon_tags` (w5),
  `customer_metrics` (w10), `customer_details` (w25).
- Contact matching everywhere is **email-search-first**: `getList('email:'.$email,0,1)`
  → `edit()` if found, else `create()`. Anonymous carts fall back to the Mautic
  `mtc_id` tracking cookie.
- Two queue workers (cron time=60): `commerce_mautic_connect_customer_metrics_sync`,
  `commerce_mautic_connect_abandoned_cart_sync`.
- Theme hook `commerce_mautic_connect_cart_email` (`templates/cart-email.html.twig`,
  vars `items`, `cart_total`, `cart_url`, `base_url`); overridable per theme; a
  preview route renders it for a chosen draft order + theme (admin-only).
- No custom permissions and no hook_install/schema (the module ships no
  `*.permissions.yml` and no `.install`). `src/Service/RfmCalculationService.php` is an
  empty stray file (metrics live in `CustomerMetricsCalculationService`).
