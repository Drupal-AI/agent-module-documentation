<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Install, configuration, routes & operating flow

## Install / enable

`composer require drupal/entity_import` (pulls `league/csv ^9.27`), then enable `entity_import` (core
`migrate` is the only module dependency). Enable `entity_import_plus` too for the extra process plugins
(it additionally needs `migrate_plus`). No `config/install` defaults ship; there is **no settings form**.

## Config entities & config objects

Defined in `config/schema/entity_import.schema.yml`.

- **`entity_import.type.*`** → `entity_importer` config entity (`src/Entity/EntityImporter.php`, config_prefix
  `type`, `admin_permission = "administer entity import"`). Exported keys: `id`, `label`, `description`,
  `expose_importer` (bool — show it on the import page), `migration_source.source` (`plugin_id` +
  plugin `configuration`), `migration_entity.entity` (`type`, `bundles[]`, `validate` bool),
  `migration_dependencies.optional.migration[]`.
- **`entity_import.field_mapping.*.*.*`** → `entity_importer_field_mapping` config entity
  (`src/Entity/EntityImporterFieldMapping.php`). Keys: `id`, `label`, `name` (machine name), `source`
  (CSV header / source name), `destination` (field name or `field/property`), `processing.plugins[]` +
  `processing.configuration.plugins.<plugin_id>` (per-process `settings` + `weight`), `importer_type`
  (owning importer id), `importer_bundle`.
- **`entity_import.options.*`** → plain config object holding `unique_identifiers.items[]`, each with
  `reference_type` (`field_type` or `entity_key`), `identifier_name`, `identifier_type`,
  `identifier_settings` (JSON string, decoded in `EntityImportSourceBase::getIds()`). These become the
  migration's `getIds()`, so re-imports update rather than duplicate.
- **`entity_import.settings`** — read-only in code (no UI). `EntityImportSourceCSV::getUploadTemporaryUri()`
  reads `temporary_uri` to override the managed-file upload location; unset → core default temp scheme.

Process-plugin settings each have a schema entry `entity_import.migrate.process.<plugin_id>` (callback,
default_value, explode, extract, skip_on_empty, migrate_lookup, …).

## Routes & permissions

All routes in `entity_import.routing.yml` require **`_permission: administer entity import`**; the
`entity_importer` config entity uses the same `admin_permission`. Routes:

| Route | Path | Purpose |
|---|---|---|
| `entity_import.importer.pages` | `/admin/content/importer-pages` | List exposed importers (`EntityImportController::importerPages`) |
| `entity_import.importer.page.import_form` | `/admin/content/entity-importer/{entity_importer}` | Upload + run (`EntityImporterPageImportForm`) |
| `entity_import.importer.page.status_form` | `/…/{entity_importer}/status` | Migration status (`EntityImporterStatusForm`) |
| `entity_import.importer.page.action_form` | `/…/{entity_importer}/action` | Rollback (`EntityImporterPageImportActionForm`) |
| `entity_import.importer.page.log_form` | `/…/{entity_importer}/log` | Log viewer (`EntityImporterLogForm`) |
| `entity_import.importer.page.log_delete_form` | `/…/{entity_importer}/log/{migration}/delete` | Clear log |
| `entity_import.download_template` | `/…/{entity_importer}/download-template` | CSV header template (`EntityImportController::downloadTemplate`) |

Importer CRUD (`add`/`edit`/`delete`/`collection`) is provided by `EntityImporterRouteDefault` under
`/admin/config/system/entity-importer`; field-mapping CRUD hangs off the importer via its own route provider.
The `entity.entity_importer.collection` route is the module's `configure` link.

## Operating flow (from README + forms)

1. Add importer at `/admin/config/system/entity-importer/add`: label, optional description, check **Display
   page** (`expose_importer`), choose the **CSV** source and target entity type/bundle(s), optionally relate
   other migrations. Save.
2. On the importer's **Field Mapping** tab, add mappings: source label → source name (a CSV header),
   pick a destination field/property, optionally select and order process plugins and fill their settings.
3. Define at least one **unique identifier** (Add identifier on the Field Mapping options form) — required or
   the import form errors.
4. Go to `/admin/content/importer-pages`, open the importer, (choose bundle if multiple), upload the CSV(s),
   optionally tick **Update** to overwrite matched entities, click **Import** (runs as a batch via
   `EntityImporterBatchProcess::import`). Optional **Download template** link emits the header row.
5. Use the **status/action** tab to roll back and the **log** tab to inspect messages. After a successful
   import, `EntityImportSubscriber` (POST_IMPORT) calls the source's `runCleanup()` which deletes the
   uploaded managed file(s) unless `skipCleanup()` was set.
