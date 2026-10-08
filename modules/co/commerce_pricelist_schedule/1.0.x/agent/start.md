<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Pricelist Schedule (commerce_pricelist_schedule) — agent index

Adds **scheduled CSV imports** to **Commerce Pricelist**: an admin uploads a price-list CSV,
picks a start date/time, and Drupal cron runs the import later (create/update price-list items,
optionally deleting existing ones first) through a queue worker. Version **1.0.0-beta1**.
Package `Commerce`. Core `^10 || ^11`. License GPL-2.0-or-later.
Depends on **`commerce_pricelist`** (`^2`), which brings in Drupal Commerce.

Everything is gated by the existing **`administer commerce_pricelist`** permission — this module
defines **no permissions, no config, and no config schema** of its own.

## What it provides (from source)

- **Content entity `pricelist_scheduled_import`** (`src/Entity/PricelistScheduledImport.php`,
  base table `pricelist_scheduled_import`). One row per scheduled import. Base fields:
  `commerce_pricelist` (entity_reference → `commerce_pricelist`, required), `scheduled_time`
  (datetime, required), `status` (string, default `pending`), `import_file` (file; extensions
  `csv txt`, required), `import_settings` (string_long — JSON of the import form values),
  `created`, `changed`. Status constants: `pending`, `in_progress`, `completed`, `failed`,
  `cancelled`. (Its annotation lists canonical/edit/delete links and a list-builder handler, but
  no routes/handler class ship for those — only the three custom routes below are wired.)
- **Three routes** (`commerce_pricelist_schedule.routing.yml`), all
  `_permission: 'administer commerce_pricelist'` + `_admin_route: TRUE`:
  - `…schedule_import` — `/price-list/{commerce_pricelist}/scheduled-imports/add` →
    `Form\ScheduleImportForm`.
  - `…scheduled_import_list` — `/price-list/{commerce_pricelist}/scheduled-imports` →
    `Controller\ScheduledImportListController::list`.
  - `…cancel_import` —
    `/price-list/{commerce_pricelist}/scheduled-imports/{pricelist_scheduled_import}/cancel` →
    `Form\ScheduledImportCancelConfirmForm`.
- **UI links**: a local task tab **"Scheduled Imports"** on the price-list edit form
  (`…links.task.yml`, base_route `entity.commerce_pricelist.edit_form`) and a **"Schedule Import"**
  action link on the list page (`…links.action.yml`).
- **Queue worker** `scheduled_import_worker` (`src/Plugin/QueueWorker/ScheduledImportWorker.php`,
  `cron = {"time" = 60}`) — runs the actual import.
- **`hook_cron`** and **`hook_ENTITY_TYPE_access` (file)** in `commerce_pricelist_schedule.module`.
- An extension hook **`hook_commerce_pricelist_schedule_finished($context, $scheduled_import)`**
  invoked by the worker between batch operations.

## How it works

- **Schedule** → [operation/scheduling.md](operation/scheduling.md): the form, upload location,
  what gets stored, and the cancel flow.
- **Execution** → [operation/execution.md](operation/execution.md): the cron pickup, the queue
  worker's batch-emulation loop, status transitions, and the 30-day cleanup.

## Security posture (positive)

- Every route requires `administer commerce_pricelist` and is an admin route. The target price
  list is a route entity parameter and the chosen price list is stored server-side on the entity;
  a request cannot make the scheduler act on a price list the admin cannot administer.
- Prices are **not** resolved from any request at this layer — this module only imports CSV rows
  into price-list items; the live active price is resolved server-side by `commerce_pricelist`.
- The queue worker's batch callbacks are **hardcoded** to `commerce_pricelist`'s
  `PriceListItemImportForm` methods (not caller-supplied). Uploaded files go to
  `private://pricelists/` when a private stream exists (else `temporary://`), and a file-access
  hook only grants those files to admins that reference them.
