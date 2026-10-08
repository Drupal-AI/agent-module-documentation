<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# D7 Content Import (d7_import) — agent index

Migrates Drupal 7 content into Drupal 11 from XML files. Two entry points: an admin **form**
at `/admin/content/d7-import` (route `d7_import.form`, permission **`administer site
configuration`**) and a family of **Drush commands**. Package `Migration`. Core
`^11`. Depends on core **node, taxonomy, file, path_alias**. License GPL-2.0-or-later. Version 1.2.0.
No config entities, no config schema, no custom permissions, no hooks, no plugin types.

- **Import form: route, permission, form fields, import order, clean option** →
  [config/import-ui.md](config/import-ui.md)
- **Drush commands (`d7-import:all`, `:nodes`, `:terms`, `:files`, `:vocabularies`, `:content-types`, `:aliases`, `:menus`, `:purge`)** →
  [commands/drush.md](commands/drush.md)
- **The seven importer services, ID-preservation mechanism, and D7→D11 field-type mapping** →
  [services/importers.md](services/importers.md)
- **The D7 export script and the XML file formats it produces** →
  [export/d7-export-script.md](export/d7-export-script.md)
- **Submodule `d7_import_webform`** (own tree) →
  [../../modules/d7_import_webform/1.2.x/agent/start.md](../../modules/d7_import_webform/1.2.x/agent/start.md)

## What it actually is

- A two-phase migration tool: an admin runs `d7_export_script/export_content.php` under Drush on
  the **source D7 site** to write XML (`taxonomy.xml`, `nodes.xml`, `files.xml`, `aliases.xml`,
  `menus.xml`, optionally `webforms.xml`), then this module reads that XML on the **D11 site**.
- One form: `ImportForm` (`src/Form/ImportForm.php`, form id `d7_import_form`) — file uploads per
  XML type + a "source files path" textfield + per-type import checkboxes + a "clean first" toggle.
- One route: `d7_import.form` at `/admin/content/d7-import`, requirement
  `_permission: 'administer site configuration'`; menu link under Configuration (`d7_import.links.menu.yml`).
- Drush commands in `D7ImportCommands` (`src/Commands/`, registered via `drush.services.yml`,
  tag `drush.command`). CLI-only; not gated by a Drupal route/permission.
- Seven services registered in `d7_import.services.yml` (see services doc). No entities, no
  config, no hooks are defined by the module.

## Mechanism (from source, high level)

- Each importer parses a `\DOMDocument` and creates core entities via `entity_type.manager`.
- **ID preservation**: create entity with `enforceIsNew()`, then if the assigned id differs from
  the source id, `UPDATE` the id/entity_id across base, `_field_data`, `_revision`, and dedicated
  `*__field_%` tables (`forceNid`/`forceTid`/file `file_managed` update), then
  `ALTER TABLE ... AUTO_INCREMENT` past the max so new inserts don't collide (`repairAutoIncrement`).
- `ContentTypeImporter` analyses `nodes.xml` to build content types + fields, using
  `FieldTypeMapper` for the D7→D11 type map, inferring cardinality from `max_delta`, collecting
  list `allowed_values`, and registering fields on default form/view displays.
- XML is control-character-sanitised before parse (Drush path) via `sanitizeXmlContent()`;
  progress + memory-bound cache resets on long node/alias runs.

## Notes

- Everything here is **admin/CLI only**: the only web route requires `administer site
  configuration`; the "source files path" is a **local server path** (used with `FileSystem::copy`),
  not a fetched URL. Users are not imported (nodes default to UID 1); revisions are not imported.
