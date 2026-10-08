# Configure the VBO field on a View

VBO has no global admin page. You enable it per View display.

## Steps (UI)
1. Edit a View (`/admin/structure/views/view/<id>`).
2. Add field → **Views bulk operations** (Global). Only one per display.
3. In the field settings choose:
   - **Selected actions** — tick which Action plugins are offered. Leave empty to offer all.
   - Per action: **preconfiguration** (fixed settings via `buildPreConfigurationForm`), a
     custom label, and whether it shows a **configuration** step and/or **confirmation** step.
   - **Batch** + **Batch size** — process via Batch API in chunks (default 10).
   - **Clear selection on exposed filter/sort change**, **Force selection info**, etc.
4. Place the field first so the checkbox column renders at the row start.

## How execution flows
Select rows (or "select all results") → pick action → optional configure step
(`/views-bulk-operations/configure/{view}/{display}`) → optional confirm step
(`/views-bulk-operations/confirm/...`) → batch runs the action's `execute()` /
`executeMultiple()`. Selection is stored in tempstore and survives multi-page AJAX
(`/views-bulk-operations/ajax/...`).

## Config schema
Field/plugin settings are validated by `config/schema/views_bulk_operations.views.schema.yml`
and `...data_types.schema.yml`, so a View with VBO exports/deploys as normal config.
Access to the execute/confirm routes is guarded by the `_views_bulk_operation_access` check.
