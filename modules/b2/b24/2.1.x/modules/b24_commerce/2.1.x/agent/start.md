<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# b24_commerce (b24_commerce) — agent index

Submodule of **[b24](../../../../agent/start.md)**. Exports Drupal **Commerce** orders to
Bitrix24 leads/deals and product variations/taxonomy sections to the Bitrix24 catalog. Depends on
`b24`, `commerce`, `commerce_order`, `profile`, `token`. Package `bitrix24`. Configure route
`b24_commerce.settings_form`.

## What it provides

- **Service `b24_commerce.event_subscriber`** (`src/EventSubscriber/B24CommerceSubscriber.php`) —
  subscribes to Commerce `OrderEvents` INSERT/UPDATE/ASSIGN/DELETE. Picks `lead` (Classic mode) or
  `deal` (Simple mode) via `RestManager::getCrmMode()`; builds fields from
  `b24_commerce.mapping.<order_type>` with token replacement (`commerce_order`/`profile`/`user`),
  invokes `hook_b24_commerce_data_alter()`, calls `RestManager::addLead/addDeal/updateLead/
  updateContact`, records a `b24_reference` (hash-guarded), and attaches product rows. Dispatches
  `B24CommerceEvent::ENTITY_INSERT/UPDATE`.
- **Service `b24_commerce.catalog_manager`** (`src/Service/CatalogManager.php`) — `processItem()`
  exports a variation (NAME/XML_ID/PRICE/CURRENCY_ID/SECTION_ID) or taxonomy term
  (product section) to Bitrix24, add vs update by existing `XML_ID`.
- **Entity hooks** (`b24_commerce.module`) — `commerce_order_item_*` (refresh product rows),
  `commerce_product_variation_*` and `taxonomy_term_*` (catalog sync), `commerce_product_delete`.
- **Forms** — `MappingForm` (per order-type field mapping; dynamic routes from
  `Routing/B24CommerceRoutes` + local tasks from `Plugin/Derivative/DynamicMappingTasks`),
  `ProductExportBatchForm` (`/admin/config/b24/commerce/export_products`; store + section-field
  selection, Batch API export).
- **Event** `B24CommerceEvent` (`src/Event/B24CommerceEvent.php`): `b24_commerce.entity.insert/
  update/delete`, carries the order + external id.
- **Config schema** (`config/schema/b24_commerce.schema.yml`): `b24_commerce.mapping.*`,
  `b24_commerce.settings` (`exportable_stores`, `section_fields`), `b24_commerce.field_types`.
- **Hook** `hook_b24_commerce_data_alter(&$fields, $context)` (`b24_commerce.api.php`).

All routes require `administer b24 configuration`.

## Solution docs

- [sync.md](sync.md) — order→lead/deal sync, catalog export, mapping, routes & config.
