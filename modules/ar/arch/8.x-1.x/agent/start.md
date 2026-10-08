<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Arch dashboard (arch) — agent index

Base/admin module of the **Arch** e-commerce suite. Provides the store dashboard, the store admin
menu tree, and store content settings. Version **8.x-1.0-alpha26**. Core `^9.4 || ^10 || ^11`.
License GPL-2.0-or-later. Package `Arch`.

- **Dashboard, permissions, content settings, admin-theme toggle** → [config/settings.md](config/settings.md)
- **The `store_dashboard_panel` plugin type** → [plugins/store_dashboard_panel.md](plugins/store_dashboard_panel.md)

## What it is

- Requires contrib `drupal/address` (`^1.4|^2`) and `drupal/currency` (`^3.3`), PHP ext `bcmath`,
  `intl`, `json`. Depends on core `entity`, and Arch submodules `arch_product`, `arch_order`.
- Permission: **`administer store`** (`arch.permissions.yml`), used by most Arch admin routes.
- Routes (`arch.routing.yml`): `arch.dashboard` `/admin/store`, `arch.settings`
  `/admin/store/settings` (menu block page), `arch.content.settings`
  `/admin/store/settings/contents` (`StoreContentSettingsForm`). All require `administer store`.
- Plugin type **`store_dashboard_panel`** — manager `plugin.manager.store_dashboard_panel`
  (`StoreDashboardPanelManager`), annotation `@StoreDashboardPanel`, base
  `StoreDashboardPanel`, fallback plugin `broken`.
- `DashboardController::dashboard()` builds the page from `hook_arch_tasks()` links + all panel
  plugins, with alter hooks `arch_dashboard`, `arch_tasks`, `arch_dashboard_panels` and
  `hook_arch_dashboard_page_alter()`.
- `_arch_content_settings()` reads the `arch.content_settings` key/value store; `arch_theme()`
  registers `arch_terms_of_use` (suggestions per mode `_none`/`TC`/`PP`/`TCPP`) for the checkout
  acceptance line.
- No entities, no Drush, no config schema. Install-config `arch.settings:use_admin_theme` (bool).

## The 24 submodules

Each is documented in its own tree under `../modules/<machine_name>/8.x-1.x/`.

**Documented here (Part A — commerce core):**
[arch_cart](../modules/arch_cart/8.x-1.x/agent/start.md),
[arch_checkout](../modules/arch_checkout/8.x-1.x/agent/start.md),
[arch_onepage](../modules/arch_onepage/8.x-1.x/agent/start.md),
[arch_order](../modules/arch_order/8.x-1.x/agent/start.md),
[arch_order_invoice](../modules/arch_order_invoice/8.x-1.x/agent/start.md),
[arch_order_statistics](../modules/arch_order_statistics/8.x-1.x/agent/start.md),
[arch_payment](../modules/arch_payment/8.x-1.x/agent/start.md),
[arch_payment_cod](../modules/arch_payment_cod/8.x-1.x/agent/start.md),
[arch_payment_saferpay](../modules/arch_payment_saferpay/8.x-1.x/agent/start.md),
[arch_payment_transfer](../modules/arch_payment_transfer/8.x-1.x/agent/start.md),
[arch_discount](../modules/arch_discount/8.x-1.x/agent/start.md).

**Catalog / pricing / logistics (see each submodule's own tree):**
arch_product, arch_product_group, arch_product_statistics, arch_price, arch_price_search_api,
arch_stock, arch_stock_search_api, arch_shipping, arch_shipping_instore, arch_addressbook,
arch_compare, arch_downloadable_product, arch_logger.

## Dependency shape (high level)

- Catalog: `arch_product` (+ `arch_product_group`, `arch_downloadable_product`); pricing:
  `arch_price` (+ `arch_price_search_api`, `arch_discount`).
- Buying flow: `arch_cart` → `arch_checkout` (+ `arch_onepage` UI) → `arch_order` → `arch_payment`
  (+ gateway `arch_payment_cod` / `arch_payment_saferpay` / `arch_payment_transfer`).
- Fulfilment: `arch_shipping` (+ `arch_shipping_instore`), `arch_stock` (+ `arch_stock_search_api`).
- Reporting/misc: `arch_order_statistics`, `arch_product_statistics`, `arch_order_invoice`,
  `arch_logger`, `arch_compare`, `arch_addressbook`.
