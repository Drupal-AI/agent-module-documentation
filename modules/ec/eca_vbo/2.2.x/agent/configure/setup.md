# Wiring an ECA operation into Views

No admin settings page. You connect an ECA model to a View through the **operation name**.

## Two Views field plugins

VBO exposes bulk-action fields on a View. This module works with two:

- **"Views bulk operations"** (stock, `views_bulk_operations_bulk_form`) — supports ECA operations.
- **"ECA bulk operations"** (`eca_vbo_bulk_form`, `EcaVboBulkForm`, added via `hook_views_data_alter`) —
  lists only ECA-derived actions and **does enforce custom access** (passes definition + selected data
  to `VboExecute::customAccess()`). Use this whenever you rely on `vbo:custom_access`.

## Recipe A — bulk operation without access check

1. ECA UI: create/edit a model. Add event **"VBO: Execute Views bulk operation (one by one)"**
   (`vbo:execute`); set an **Operation name**, e.g. `My Operation`.
2. Add the successor actions that do the work (e.g. set a field), and **an action that saves the
   entity** — this module only dispatches the event, it does not save.
3. Optionally add **"VBO: Set result"** (`eca_vbo_set_result`) to set the completion message.
4. Save the ECA config (this clears cached VBO action defs so the action appears).
5. Views UI: add the field **"Views bulk operations"** (or "ECA bulk operations") and select your
   operation (`My Operation`) among the actions.

## Recipe B — bulk operation WITH custom access

1. Do steps 1–4 above.
2. Add a second event **"VBO: Custom access for Views bulk operation"** (`vbo:custom_access`) with the
   **same operation name**. As its successor add **"VBO: Set custom access on Views Bulk Operation"**
   (`eca_vbo_set_custom_access`), optionally gated by prepended ECA conditions (role, field value, …).
3. Views UI: you **must** add the field **"ECA bulk operations"** (`eca_vbo_bulk_form`), not the stock
   one, and select your operation.

## Confirmation step

The action confirms by default via route `eca_vbo.confirm` (`EcaVboConfirm`), path
`/views-bulk-operations/eca-vbo-confirm/{view_id}/{display_id}`. To skip it, tick **"Skip confirmation
step"** in the action's preconfiguration (VBO field settings). You can also react to the confirm form
with the `vbo:confirm_form_*` events. If you add fields via `vbo:form_build`, the action shows a config
form; otherwise it goes straight to confirm/execute.

## execute vs execute_multiple

- `vbo:execute` runs once per entity — the entity is in scope (`[event:entity:*]`). Best for per-item
  changes.
- `vbo:execute_multiple` runs once for the whole selection (`[event:queue:*]`) — best for summaries,
  aggregate work, or a single outbound call. If you use both, the multiple event runs first.

## Quick check on the running site

```bash
# List the derived ECA VBO actions currently available:
ddev drush php:eval "print_r(array_keys(\Drupal::service('plugin.manager.views_bulk_operations_action')->getDefinitions()));" | grep eca_vbo
```
