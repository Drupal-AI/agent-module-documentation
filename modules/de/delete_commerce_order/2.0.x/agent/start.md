<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Delete Commerce Order Periodically (delete_commerce_order) — agent index

Bulk-deletes old **Commerce orders** (plus their `commerce_payment` records) by date — either **on demand** via a Batch API job or **automatically on cron** via a queue worker. Package `Commerce`. Depends on `commerce`, `commerce_order`. Core `^9 || ^10 || ^11`. License GPL-2.0-or-later. Version **2.0.0** (dir `2.0.x`).

Destructive/irreversible: orders are financial records + PII. The one entry route is gated by the restricted `administer commerce_order` permission — keep it that way, back up first, and mind retention obligations.

## What it actually is (from source)

- **One route/form** — `delete_commerce_order.form` at `/admin/commerce/order-deletion`, `_permission: administer commerce_order`, added as the local task **"Bulk Delete"** on `entity.commerce_order.collection` (`*.links.task.yml`). Form class `CommerceOrderDeletionForm` (`src/Form/`) extends `ConfigFormBase`, form id `delete_commerce_order`.
- **One config object** — `delete_commerce_order.settings` with keys `cron_radio`, `selected_date`, `intervel`. **No `config/schema/` or `config/install/` is shipped** (`provides_config_schema` = false).
- **One service** — `delete_commerce_order.batch_processing_service` → `CommerceOrderDeleteService` (`src/Service/`), args `@entity_type.manager`, `@logger.factory`. Runs the foreground Batch API deletion.
- **One queue worker** — plugin id `commerce_delete_order` (`CommerceOrderDeleteQueue`, `cron time = 300`), deletes enqueued order IDs in the background.
- **One hook** — `hook_cron()` in `.module`: when `cron_radio == 1`, queries `commerce_order` older than `intervel` and enqueues the IDs.
- **One library** — `delete_commerce_order/delte_order` (`js/order-delete.js`): toggles the date vs. interval field and adds a JS `confirm()` before submit. No permissions, no Drush, no schema, no submodules.

## Solution docs

- **The form, its config object/keys, route & permission, and how to operate it** → [config/settings.md](config/settings.md)
- **Deletion mechanics: batch service, queue worker, cron hook, what gets deleted** → [api/deletion.md](api/deletion.md)
