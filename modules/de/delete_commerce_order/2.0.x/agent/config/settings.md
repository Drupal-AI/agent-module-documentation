<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The admin form, config object, route & permission

## Install / enable

`ddev drush en delete_commerce_order -y`. Requires `commerce` + `commerce_order` (Commerce Core). Nothing else. Back up the database first — deletion is irreversible.

## Route & access

- Route `delete_commerce_order.form` → path `/admin/commerce/order-deletion`, title "Delete Commerce Orders" (`delete_commerce_order.routing.yml`).
- Requirement: `_permission: 'administer commerce_order'` — Commerce's restricted order-admin permission. This is the **only** entry point that triggers a deletion from the UI.
- Menu: `*.links.task.yml` adds local task `delete_commerce_order.add_page` titled **"Bulk Delete"** under `base_route: entity.commerce_order.collection` (the Commerce → Orders listing). There is no `configure` link in info.yml.

## The form (`CommerceOrderDeletionForm`)

Extends `ConfigFormBase`, so submission is a POST protected by the Form API CSRF token, and it writes to the editable config object `delete_commerce_order.settings` (constant `SETTINGS`). Fields:

| Field | Type | Purpose |
|-------|------|---------|
| `cron_radio` | radios (0=No, 1=Yes) | "Do you want to set a Periodic cron to delete the orders?" — chooses batch-now vs. cron-schedule |
| `selected_date` | date (`max` = today) | Cutoff date for the **immediate batch** path (used when `cron_radio == 0`) |
| `intervel` | select | Relative cutoff for the **cron** path: options "Older than 1 Month / 3 Months / 6 Months / 1 / 2 / 3 / 4 / 5 Years", each stored as a computed `Y-m-d` date string |

A static `note` markup element reminds you to back up. The form attaches library `delete_commerce_order/delte_order`.

### Submit behavior (`submitForm()`)

1. Always saves `selected_date`, `cron_radio`, `intervel` into `delete_commerce_order.settings`.
2. If `cron_radio == 0` (batch now): builds a batch definition, runs an entity query
   `getStorage('commerce_order')->getQuery()->condition('created', strtotime($selected_date), '<')->accessCheck(FALSE)`,
   and if any IDs match calls `CommerceOrderDeleteService::initiateBatchProcessing($orderIds, $batch)`. It then shows "Batch Process executed." (as an error-styled message) or "No orders found to delete." — see [../api/deletion.md](../api/deletion.md).
3. If `cron_radio == 1` (cron): just saves config and shows "The configuration for the cron is saved." The actual deletion happens later in `hook_cron()`.

`accessCheck(FALSE)` means per-order view access is not consulted; the route's `administer commerce_order` gate is what restricts who can reach this form. Keep that permission restricted to trusted admins.

## Config object `delete_commerce_order.settings`

No schema file ships (config export will warn about missing schema). Keys:

- `cron_radio` — string `'0'` or `'1'`.
- `selected_date` — `Y-m-d` string; cutoff for the batch path.
- `intervel` — `Y-m-d` string; cutoff snapshot for the cron path (recomputed each time the form is saved, not each cron run).

## Client behavior (`js/order-delete.js`)

`Drupal.behaviors.editCronRadio` shows the date field for batch mode and the interval field for cron mode, colors the backup note red, requires an interval to be chosen in cron mode, and pops a native `confirm()` ("Are you sure you want to delete the records via cron/batch?") before the form submits. This is a UX guard only — server-side deletion does not depend on it.
