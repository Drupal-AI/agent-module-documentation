<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Blocks Bulk Actions (blocks_bulk_actions) — agent index

Adds **Enable / Disable / Delete** bulk actions to Drupal's core **Block layout** page
(`/admin/structure/block`). Package `Blocks`. Core `^9 || ^10 || ^11`. Version `1.0.0-alpha2`.
**No** contrib dependencies, **no** routes, **no** permissions, **no** config, **no** Drush.
License GPL-2.0-or-later.

- **How it hooks the form, the batch flow, the plugin type, and how to add a custom action** →
  [api/plugins.md](api/plugins.md)

## What it actually is

- A `hook_form_alter()` in `blocks_bulk_actions.module` that targets **only** form id
  `block_admin_display_form` (the core Block layout form, route `block.admin_display`, gated by
  the core `administer blocks` permission). It does **not** register any route or form of its own.
- It defines a custom plugin type **`BlocksBulkActions`**: manager
  `BlocksBulkActionsPluginManager` (service `plugin.manager.blocks_bulk_actions`, discovers
  `Plugin/BlocksBulkActions/*`), interface `BlocksBulkActionsInterface`, base
  `BlocksBulkActionsPluginBase`, annotation `Annotation\BlocksBulkActions` (`id`, `description`,
  optional `bids`), alter hook `blocks_bulk_actions_info`.
- Three shipped plugins act on core `block` config entities (`Drupal\block\Entity\Block`):
  - `BlocksBulkActionsEnable` (id `blocks_bulk_action_enable`) — `setStatus(TRUE)` + `save()`.
  - `BlocksBulkActionsDisable` (id `blocks_bulk_action_disable`) — `setStatus(FALSE)` + `save()`.
  - `BlocksBulkActionsDelete` (id `blocks_bulk_action_delete`) — `delete()`.
- Asset library `blocks_bulk_actions/scripts` (`js/blocks-bulk-actions.js`,
  `css/blocks-bulk-actions.css`, dep `core/jquery`): the select-all checkbox toggles every
  `.block-selector`, and the actions bar becomes sticky on scroll.

## Mechanism (from source)

- `hook_form_alter()` builds the action `<select>` from `getDefinitions()`, including only
  definitions whose plugin `access($account)` returns TRUE; adds a `selector` checkbox to each
  block row (rows that have a `region-theme` key) plus a `Selector` header and a select-all box;
  prepends the actions container and attaches the library. Apply runs custom submit
  `blocks_bulk_actions_apply`.
- `blocks_bulk_actions_apply()` reads the chosen action id and the selected block ids (all ids
  when select-all is `all`, otherwise the checked rows), **re-checks** `access($account)` on the
  instantiated action, then `batch_set()`s a batch whose operation calls
  `executeMultiple($selected_blocks)` → `execute($id)` per block. Finished callback prints the
  action's `actionFinishedMessage()`.
- Access is layered on the core `administer blocks` permission: reaching the page requires it, and
  every shipped plugin's `access()` returns `$account->hasPermission('administer blocks')`. The
  base class default `access()` returns TRUE — so a **custom** plugin that omits `access()` inherits
  no extra check (but the page-level `administer blocks` gate still applies).
