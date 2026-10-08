<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugin types: ExportDestination, ImportSource, Format

The module defines three attribute-based plugin types, each with a manager service
(`parent: default_plugin_manager`):

| Plugin type | Manager service | Namespace | Attribute | Base class |
|---|---|---|---|---|
| Export destination | `plugin.manager.menu_migration_destination` | `Plugin\menu_migration\ExportDestination` | `#[MenuMigrationDestination]` | `ExportDestinationBase` |
| Import source | `plugin.manager.menu_migration_source` | `Plugin\menu_migration\ImportSource` | `#[MenuMigrationSource]` | `ImportSourceBase` |
| Format | `plugin.manager.menu_migration_format` | `Plugin\menu_migration\Format` | `#[MenuMigrationFormat]` | `FormatBase` |

Built-in plugins: destinations `codebase`, `download`, `another_menu`; sources `codebase`,
`file_upload`; formats `json`, `yaml`, `raw` (raw passes the tree through unchanged).

## Attribute properties

`MenuMigrationDestination` / `MenuMigrationSource` (same shape):

```php
#[MenuMigrationDestination(
  id: 'mydestination',
  label: new TranslatableMarkup('My Destination'),
  allowed_formats: ['json', 'yaml', 'raw'], // REQUIRED as of 4.1.0 (omitting is deprecated)
  multiple: FALSE,   // optional, default TRUE — can it handle multiple menus at once
  cli: TRUE,         // optional, default FALSE — is it usable from Drush
)]
```

`MenuMigrationFormat` only takes `id` + `label`.

## Add an export destination

File `mymodule/src/Plugin/menu_migration/ExportDestination/MyDestination.php`, extend
`ExportDestinationBase`, implement `exportMenu(string $menuName)` (return bool; throw
`MenuMigrationException` on failure). Optionally override `getExportDescription()` (adds lines
to the confirm screen) and `configurationSummary()` (extra lines under the plugin label on the
listing page). Define config schema in `mymodule.schema.yml`:

```yaml
menu_migration.destination_config.mydestination:
  type: source_destination_config_single      # or _multiple if multiple: TRUE
  label: 'My Destination'
  mapping:                                     # only if you add fields beyond menus/format
    extra_config:
      type: string
      label: 'Extra Config'
```

`source_destination_config_single` gives you `format` + a single `menus` string;
`source_destination_config_multiple` gives `format` + a `menus` sequence.

## Add an import source

Same pattern under `Plugin\menu_migration\ImportSource`, extend `ImportSourceBase`, implement
`importMenu(string $menuName)`, use `#[MenuMigrationSource]`, and add a
`menu_migration.source_config.<id>` schema entry.

## Add a format

Extend `FormatBase`, use `#[MenuMigrationFormat(id, label)]`, and implement `encode(array $tree)`,
`decode(mixed $data)`, plus `allowedExtensions()`, `defaultExtension()`, `mimeType()` (used by
file-based sources/destinations like `codebase` and `download`).

Rebuild the plugin cache after adding one: `drush cr`.
