# Configure — report page, generated routes, storage choice

Checklist API has **no settings form**. Its `configure` route (`checklistapi.report`) points
at the report, not a config UI. Behavior is controlled entirely by each checklist's definition
(see [hooks/checklistapi.md](../hooks/checklistapi.md)).

## The Checklists report

- Route: `checklistapi.report` — path `/admin/reports/checklistapi`.
- Permission: `view checklistapi checklists report`.
- Lists every defined checklist with percent complete, last-updated date, and last-updated
  user. Rendered by `ChecklistapiController::report`.

## Routes generated per checklist

`ChecklistapiRoutes::routes()` (a `route_callbacks` entry) builds, for each checklist whose
definition has both `#path` and `#title`:

| Route name | Path | Purpose |
|---|---|---|
| `checklistapi.checklists.{id}` | the definition's `#path` | View / fill the checklist (`ChecklistapiChecklistForm`). |
| `checklistapi.checklists.{id}.clear` | `{#path}/clear` | Clear saved progress (`ChecklistapiChecklistClearForm`). |

Both carry the `_checklistapi_access: 'TRUE'` requirement (permission-based, see permissions
doc). `#path` cannot be changed via the alter hook once routes are built.

## Choosing where progress is stored

Set per checklist in the definition:

```php
'#storage' => 'config',   // default: config object checklistapi.progress.{id} (exportable)
// or
'#storage' => 'state',    // state key checklistapi.progress.{id} (per-environment)
```

Config schema for the stored progress lives in `config/schema/checklistapi.schema.yml`
(`checklistapi.progress.*`). There are no other site-wide settings to configure.

## Compact mode

A per-user cookie (`Drupal.visitor.checklistapi_compact_mode`) toggles compact display (less
description text) on checklist forms; there is no admin setting for it.
