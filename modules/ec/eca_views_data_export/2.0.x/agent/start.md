<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ECA Views data export (eca_views_data_export) — agent index

Bridges the **ECA** rules engine to the **Views Data Export** module. It does **not** trigger
exports. Instead, as views_data_export serializes each result row (core hook
`hook_views_data_export_row_alter()`), this module dispatches a per-row **ECA event** so ECA models
can inspect and rewrite the outgoing cells. Package `ECA`. Depends on `eca` (^2||^3) and
`views_data_export`. Core `^10.4 || ^11`. PHP `>=8.1`. License GPL-2.0-or-later. Version 2.0.1.
No routes, no permissions, no settings form.

- **ECA event `eca_views_data_export:alter_row` ("Alter a row")**, its View/Display scoping, and
  the `current_row` / `current_result` tokens → [plugins/event-alter-row.md](plugins/event-alter-row.md)
- **ECA action `eca_views_data_export_set_column_value` ("Set column value")** → [plugins/action-set-column-value.md](plugins/action-set-column-value.md)

## What it actually provides (from source)

- **Event plugin** `ViewsDataExportEvent` (id `eca_views_data_export`, deriver
  `ViewsDataExportEventDeriver`) in `src/Plugin/ECA/Event/`. One derivative `alter_row`
  (label *"Alter a row"*), event class `Event\AlterRow`, event name constant
  `EcaEvents::ALTER_ROW = 'eca_views_data_export.alter_row'`.
- **Action plugin** `SetColumnValue` (id `eca_views_data_export_set_column_value`, label
  *"Set column value"*) in `src/Plugin/Action/`, extends ECA `ConfigurableActionBase`.
- **Hooks** (attribute-based, class methods): `ViewsHooks::viewsDataExportRowAlter()` implements
  `hook_views_data_export_row_alter()` and calls
  `TriggerEvent::dispatchFromPlugin('eca_views_data_export:alter_row', $row, $result, $view)`;
  `TokenHooks::tokenInfo()`/`tokens()` register + resolve the `current_result` and `current_row`
  token types (delegating to ECA's DTO token handler). Legacy procedural shims in
  `eca_views_data_export.module` forward to these services.
- **Services** (`eca_views_data_export.services.yml`): `Hook\TokenHooks`, `Hook\ViewsHooks`
  (both autowired) and an alias of `Drupal\eca\Event\TriggerEvent`.
- **Config schema only** (`config/schema/eca_views_data_export.schema.yml`): event mapping
  `view_id`/`display_id`; action mapping `column`/`value`. No config/install objects.
- No install/update hooks, no Drush, no new plugin types.
