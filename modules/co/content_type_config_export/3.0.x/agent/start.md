<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Type Config Export (content_type_config_export) — agent index

Admin-UI export tool that packages one bundle's configuration (or all user roles) into a
downloadable ZIP of per-object YAML files, scoped to that bundle so it avoids a full-site config
export. Package `Custom`. Core `^10 || ^11 || ^12`. License GPL-2.0-or-later. Version 3.0.0.
No composer.json, no declared module dependencies, no config objects/schema, no Drush.

- **Routes, permissions, the export forms, modes, and how a ZIP is built** →
  [config/export.md](config/export.md)

## What it actually is

- Five export routes (`content_type_config_export.routing.yml`), each a local task/operation:
  - `content_type_config_export.export` — `/admin/structure/types/manage/{node_type}/export`
  - `block_type_config_export.export` — `/admin/structure/block-content/manage/{block_content_type}/export`
  - `vocabulary_config_export.export` — `/admin/structure/taxonomy/manage/{taxonomy_vocabulary}/export`
  - `paragraph_type_config_export.export` — `/admin/structure/paragraphs_type/{paragraphs_type}/export`
  - `role_config_export.export` — `/admin/people/export`
- Five controllers in `src/Controller/` (`ContentTypeExportController`, `BlockTypeExportController`,
  `ParagraphTypeExportController`, `VocabularyExportController`, `RoleExportController`). Each loads
  and validates the entity (404 if missing) and renders the matching form.
- Forms in `src/Form/`: bundle exports extend `AbstractExportForm` (shared build/validate/submit +
  ZIP logic); `RoleExportForm` is standalone. All are `FormBase` POST forms.
- One hook class `src/Hook/ContentTypeConfigExportHooks.php` (`entity_operation_alter`, registered
  as an autowired service + `#[LegacyHook]` shim in the `.module`) adds an "Export" operation to
  node_type / block_content_type / taxonomy_vocabulary / paragraphs_type listings, each gated by the
  corresponding permission.

## Permissions (`content_type_config_export.permissions.yml`, all `restrict access: true`)

`export content type configuration`, `export block type configuration`,
`export vocabulary configuration`, `export paragraph type configuration`,
`export role configuration`. Each route requires exactly one of these.

## Notes

- Provides **no** entities, plugins, services beyond the hook class, config objects, schema, or
  Drush commands.
- Exports **structural config only** — never content. It reads config via the config factory
  (`getRawData()`), writes each object as a `*.yml` in a `temporary://` dir, zips the `*.yml` files
  and streams the ZIP as an attachment. It never imports or modifies configuration.
