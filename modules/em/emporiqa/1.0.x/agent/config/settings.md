<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Emporiqa — settings, permission, install

## Install / enable
`composer require drupal/emporiqa` then `drush en emporiqa`. Enabling pulls in `commerce_product`
and core `node` (info.yml `dependencies`). `drupal/commerce ^2.40 || ^3` must be present.

`hook_install()` (`emporiqa.install`) auto-detects Commerce field mappings and pre-populates
`field_mapping`: a taxonomy `category_field` (field name containing `categor`), a `brand_field`
(`brand`/`manufactur`), `image_fields` (image fields, or media/`image`/`photo`/`picture` refs), a
`description_field` (`body` or the first `text_with_summary`/`text_long`), a numeric `stock_field`
(name contains `stock`/`quantity`/`inventory`), and `attribute_fields` (all `attribute_*` fields).

`hook_uninstall()` deletes `emporiqa.settings`, deletes the `node.emporiqa` and
`commerce_product.emporiqa` view modes, and deletes the `emporiqa_webhook` queue. Update hooks
`10001`–`10004` prune deprecated keys and add `order_transitions` / `max_order_quantity_field`.

## Permission & routes
- `administer emporiqa` (`emporiqa.permissions.yml`, `restrict access: true`) — gates both admin
  routes. No other permission is defined.
- `emporiqa.settings` → `/admin/config/services/emporiqa` (`SettingsForm`). `configure` target.
- `emporiqa.sync` → `/admin/config/services/emporiqa/sync` (`SyncForm`; the "Sync" local task).

## Config object `emporiqa.settings`
Install defaults in `config/install/emporiqa.settings.yml`; typed schema in
`config/schema/emporiqa.schema.yml` (`type: config_object`). Keys:

- `store_id` (string, required) — Emporiqa store identifier.
- `webhook_secret` (string) — shared secret used to sign outbound webhooks and the user token, and
  to verify inbound order-tracking signatures. Required before any sync runs.
- `webhook_url` (string, default `https://emporiqa.com/webhooks/sync/`) — base URL; validated as a
  URL that must start with `https://` in `SettingsForm::validateForm()`.
- `enabled_languages` (sequence) — translations included in payloads (empty = site default only).
- `sync_products` (bool, default true), `sync_pages` (bool, default true).
- `product_types` (sequence) — bundles to sync (empty = all).
- `batch_size` (integer, default 50) — items per webhook batch during full sync (form clamps 1–100).
- `order_transitions` (sequence, default `[place]`) — Commerce transition IDs that fire
  `order.completed` (form takes a comma list; `place`/`validate`/`fulfill`/`complete` are subscribed).
- `field_mapping` (mapping) — `category_field`, `brand_field`, `description_field` (default `body`),
  `image_fields` (seq), `stock_field`, `attribute_fields` (seq), `min_order_quantity_field`,
  `max_order_quantity_field`.

## `SettingsForm` (`src/Form/SettingsForm.php`, extends `ConfigFormBase`)
Form id `emporiqa_settings_form`. Uses `#config_target` for most keys. The **connection secret** is a
`password` element handled manually in `submitForm()` (only overwritten when a new value is entered;
`validateForm()` requires it when none is stored). Renders the read-only **Order Tracking API URL**
(from route `emporiqa.order_tracking`) for the merchant to paste into the dashboard. Field-mapping
selects are populated by helpers that scan `commerce_product` / `commerce_product_variation` field
definitions (reference, text, image/media, numeric, `attribute_*`). When `commerce_stock` is enabled
the stock field is labeled a fallback. Attaches `emporiqa/admin`.

## View modes (`config/optional`)
`core.entity_view_mode.node.emporiqa` and `core.entity_view_mode.commerce_product.emporiqa`. A
content type is **syncable as a page only if** its `node.<bundle>.emporiqa` entity view display is
enabled; the same display drives product/page description rendering
(`DataFormatter::hasEmporiqaDisplay()`).
