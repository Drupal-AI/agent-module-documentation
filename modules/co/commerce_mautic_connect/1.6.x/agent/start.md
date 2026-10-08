<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Mautic Connect — agent index

Syncs Drupal Commerce cart/order/customer data to **Mautic** marketing automation.
Four opt-in features: **Abandoned Cart** (cart HTML + expiring recovery links),
**Coupon Tags**, **Customer Metrics** (RFM), **Customer Details** (name/phone/country).
All Mautic HTTP is delegated to the `advanced_mautic_integration.api` wrapper. Version
**1.6.0**, core `^10 || ^11`, PHP `^8.1`.

Requires `commerce:commerce_cart` and `advanced_mautic_integration`. Optional
`commerce_exchanger` (currency conversion for metrics). Sends customer/cart PII to an
external Mautic instance — a trust-boundary crossing; every feature is **off by
default** and enabling is gated by `administer site configuration`.

- **Features, config keys/defaults, the MauticFeature plugin system, field creation** →
  [features-and-config.md](features-and-config.md)
- **Event subscribers, queue workers, Drush commands, contact matching, recovery-link
  copy flow, country mapper, sync suspender** → [sync-and-recovery.md](sync-and-recovery.md)

## Key facts
- Configure route: `commerce_mautic_connect.settings` → `/admin/commerce/config/mautic-connect`
  (`administer site configuration`). Single config object `commerce_mautic_connect.settings`.
  Admin menu link `commerce_mautic_connect.settings` under `commerce.configuration`.
- No credentials stored here — Mautic base URL + API auth live in
  `advanced_mautic_integration`. This module's config is only feature toggles, Mautic
  field aliases, coupon prefix, base currency, and `recovery_link_lifetime` (seconds).
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
  preview route renders it for a chosen draft order + theme (admin-only). Quantities
  and prices are formatted by `commerce_mautic_connect.cart_email_formatter`.
- **Recovery links are copy-only and expiring** (changed from pre-1.5.0): opening one
  copies the order's items into the visitor's own cart, never signs anyone in, never
  hands over the original order, and stops working after `recovery_link_lifetime`
  (default 604800s = 7 days). Routes `.restore` (`/cart/restore/{order}/{timestamp}/{token}`)
  and legacy `.restore_legacy` (`/cart/restore/{order}/{token}`, pre-1.5.0 links).
- No custom permissions and no `.install` schema. One `hook_post_update`
  (`commerce_mautic_connect.post_update.php`) seeds `recovery_link_lifetime` = 604800.
