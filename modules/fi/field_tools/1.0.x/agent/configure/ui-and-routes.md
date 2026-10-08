# Field Tools — pages, bundle tabs, routes, permission

Field Tools has **no settings form** (`configure: null`). Its "configuration" is the set of routes
and UI actions it adds. Everything is driven from Field UI pages; there is nothing to store.

## Permission

- `access field tools pages` — gates the three `/admin/reports/fields/*` overview pages.
- The per-bundle clone/copy/export actions instead require the core
  `administer <entity_type> fields` permission (e.g. `administer node fields`).

## Site-wide overview routes (`{name}.routing.yml`)

| Route | Path | Controller |
|---|---|---|
| `field_tools.reports.list` | `/admin/reports/fields/tools` | `FieldList::content` — every field instance |
| `field_tools.reports.references` | `/admin/reports/fields/references` | `FieldReferencesList::content` — reference fields |
| `field_tools.reports.references_graph` | `/admin/reports/fields/graph` | `FieldGraph::content` — needs GraphAPI |
| `field_tools.import_multiple` | `/admin/config/development/configuration/multiple/import` | `ConfigMultipleImportForm` (perm `import configuration`) |

## Per-bundle tabs (added dynamically)

`src/Routing/RouteSubscriber.php` iterates every entity type that declares a `field_ui_base_route`
and adds these routes (suffix is the entity type id, e.g. `node`). The matching local-task tabs are
declared by `src/Plugin/Derivative/FieldToolsLocalTask.php` under the "Tools" tab on Manage fields.

| Route name pattern | Path suffix on the bundle | Form | Permission |
|---|---|---|---|
| `field_tools.field_bulk_clone_<etid>` | `…/fields/tools/clone-fields` | `FieldBulkCloneForm` | `administer <etid> fields` |
| `field_tools.displays_clone_<etid>` | `…/fields/tools/clone-displays` | `EntityDisplayBulkCloneForm` | `administer <etid> fields` |
| `field_tools.displays_settings_copy_<etid>` | `…/fields/tools/copy-display-settings` | `EntityDisplaySettingsBulkCopyForm` | `administer <etid> fields` |
| `field_tools.export_to_code_<etid>` | `…/fields/tools/export-to-code` | `ConfigFieldsExportToCodeForm` | `administer <etid> fields` |
| `field_tools.export_to_yaml_<etid>` | `…/fields/tools/export-to-yaml` | `ConfigFieldsExportToYamlForm` | `administer <etid> fields` |
| `entity.field_config.<etid>_field_tools_clone_form` | `…/fields/{field_config}/clone` | `field_config.clone` entity form | `field_config.update` access |

For nodes these resolve to e.g. `/admin/structure/types/manage/{node_type}/fields/tools/clone-fields`.

## Single-field "Clone" operation

`hook_entity_operation()` adds a **Clone** operation link to each `field_config` in a bundle's field
list, pointing at `entity.field_config.<etid>_field_tools_clone_form`. `hook_entity_type_build()` also
attaches a **delete** form/route to `field_storage_config` at
`/admin/reports/fields/tools/{field_storage_config}/delete`.

## Acting without the UI

To perform any of these actions programmatically (cheaper than driving forms), call the services in
[../api/services.md](../api/services.md) — e.g. `field_tools.field_cloner`->`cloneField()`.
