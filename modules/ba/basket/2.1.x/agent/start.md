<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drupal AlternativeCommerce / Basket (basket) — agent index

A self-contained online store built on **plain nodes** (not Drupal Commerce): any content type is
turned into a product, a session/DB cart collects items, a `basket_order` node is the checkout form,
and orders live in bespoke `basket_*` tables. Adds currencies, delivery, payment, discounts, stock,
statuses, e-mail notifications, and an editable Twig template system, all under one admin section.
Dependencies: core `node`, `token`, `views` + contrib **`scss_compiler`** (storefront CSS is compiled
from Sass at request time). Composer also pulls `mpdf/mpdf` (invoice PDFs) and
`phpoffice/phpspreadsheet` (order export). PHP 8.1+. **No standard `configure` route** — settings live
under `/admin/basket/settings-*` (route `basket.admin.pages`).

- **All settings objects, the admin config pages, getSettings/setSettings** → [configure/settings.md](configure/settings.md)
- **Turn a node type into a product (price field, image/stock, add-to-cart)** → [configure/products.md](configure/products.md)
- **Permissions (grouped: Orders / Buyers / Section / Settings / Users)** → [permissions/permissions.md](permissions/permissions.md)
- **Drush commands (`basket:po`, `basket:po_update`)** → [drush/commands.md](drush/commands.md)
- **The `Basket` service + its sub-services (cart, orders, currency, term…) and key methods** → [api/services.md](api/services.md)
- **Storefront routes + AJAX API endpoints (add/update cart, checkout, payment flow)** → [api/endpoints.md](api/endpoints.md)
- **Integrator hooks (alters + invoked events, e.g. price/discount/order/payment)** → [hooks/hooks.md](hooks/hooks.md)
- **The 8 plugin types it defines and how to add one (payment gateway, delivery, discount…)** → [plugins/plugin-types.md](plugins/plugin-types.md)
- **The `basket_price_field` field type / widget / formatter** → [fields/price-field.md](fields/price-field.md)
- **The 4 blocks (cart count, currency switch, rate, user discount)** → [blocks/blocks.md](blocks/blocks.md)

## Key facts

- **Service:** `Basket` (class `Drupal\basket\Basket`). Get sub-objects via `->cart()`, `->orders()`,
  `->currency()`, `->term()`, `->cron()`, `->token()`, `->mailCenter()`, `->waybill()`,
  `->translate()`. Settings via `->getSettings($type,$name)` / `->setSettings($type,$name,$value)`.
- **Config objects:** `basket.setting.<type>` (schemaless — the module ships **no** `config/schema`).
  Types include `order_form`, `order_page`, `notifications`, `templates`, `enabled_services`,
  `popup_plugin`, `appearance`, `export_orders`, `FilterOrders`, `basket_theme`, `empty_trash`,
  `orders_tabs_settings`, `orders_stat_block_settings`.
- **Routes (only two):** `basket.admin.pages` = `/admin/basket/{page_type}` (custom access
  `Admin\Pages::access` → perm `basket order_access`); `basket.pages` = `/basket/{page_type}`
  (`_access: 'TRUE'`, each page self-checks a permission). Both are controller dispatchers keyed by
  a hyphen-split `page_type` (e.g. `settings-currency`, `orders-edit-12`, `api-add`).
- **Product node type:** any bundle registered in the `basket_node_types` table (via
  `/admin/basket/settings-node_types`). Checkout entity: node type **`basket_order`** (installed).
- **Plugin managers (services):** `BasketPayment`, `BasketDelivery`, `BasketDeliverySettings`,
  `BasketDiscount`, `BasketParams`, `BasketPopup`, `BasketStockBulk`, `BasketExtraSettings` — each
  discovers plugins under `src/Plugin/Basket/<Type>/`.
- **Field type:** `basket_price_field` (widget `BasketPriceFieldWidget`, formatter
  `BasketPriceFieldFormatter`); field-type category `basket`.
- **Blocks:** `basket_count`, `basket_currency`, `basket_currency_rate`, `basket_user_discount`.
- **Tables:** `basket` (cart), `basket_orders`, `basket_orders_item`, `basket_orders_delivery`,
  `basket_orders_payment`, `basket_orders_export`, `basket_terms`, `basket_currency`,
  `basket_node_types`, `basket_user_percent`, `basket_node_delete`.
- **Cron:** `basket_cron()` → `Basket::cron()->run()` (trims abandoned carts, refreshes the
  alternativecommerce.org module list state). **Permissions:** yes (grouped). **Drush:** yes.
  **Config schema:** no. **Submodules:** none. Ecosystem add-ons (delivery/payment providers) ship as
  separate projects (e.g. `basket_novaposhta`).
