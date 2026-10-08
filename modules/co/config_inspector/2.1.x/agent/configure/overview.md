<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Admin report UI

The module has **no settings form** — it is a read-only inspector. Everything is under one
report. There is no `config/install` or `config/schema`; enabling the module is all the setup.

## Access

- Route: `config_inspector.overview` → path `/admin/reports/config-inspector`
  (also the `configure` route in the `.info.yml`, and a menu link under Reports).
- Permission: **`inspect configuration`** (`config_inspector.permissions.yml`,
  `restrict access: TRUE`). Grant it to a developer role; do not give it to the public.

## The pages (per config object)

The overview lists all active config names. Clicking one opens per-object tabs, each its own
route with the same `inspect configuration` permission and a `{name}` argument:

| Tab | Route | Path | Shows |
|---|---|---|---|
| List | `config_inspector.list_page` | `/admin/reports/config-inspector/{name}/list` | Flat property → schema-type → value table |
| Tree | `config_inspector.tree_page` | `/admin/reports/config-inspector/{name}/tree` | Nested schema tree |
| Form | `config_inspector.form_page` | `/admin/reports/config-inspector/{name}/form` | The data rendered as a form via schema widgets |
| Raw data | `config_inspector.raw_page` | `/admin/reports/config-inspector/{name}/raw` | The raw stored YAML/array |
| Download | `config_inspector.download` | `/admin/config/development/configuration/inspect/{name}/download` | Downloads the object |

## What each object row reports

- **Status** — `No schema`, `Correct`, or `N errors` (schema-compliance check).
- **Validatable** — percentage of property paths that carry real validation constraints.
- **Data** — `✅✅` (valid, fully validatable), `✅❓` (valid primitive, can't validate further),
  or `N errors` (constraint violations).

For CLI/scripted use prefer [drush/inspect.md](../drush/inspect.md); to call the analysis from
code see [api/manager.md](../api/manager.md).
