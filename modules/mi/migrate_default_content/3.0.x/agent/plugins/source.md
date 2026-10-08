# `Source` plugin type

Lets you support content file formats other than YAML. The module ships one: `yaml`.

- **Plugin manager:** `plugin.manager.migrate_default_content.source`
  (`\Drupal\migrate_default_content\SourcePluginManager`).
- **Discovery directory:** `src/Plugin/MigrateDefaultContent/Source/`.
- **Interface:** `\Drupal\migrate_default_content\SourcePluginInterface`
  (base class `BaseSourcePlugin`).
- **Annotation:** `@Source` (`src/Annotation/Source.php`) with:
  - `id` — plugin id.
  - `extension` — the file extension it handles (e.g. `yml`).
  - `dependencies` — array of module machine names; the plugin is **filtered out** if any
    dependency module is not enabled (see `SourcePluginManager::findDefinitions()`).
- **Alter hook:** `hook_migrate_default_content_source_alter()`.

## Shipped plugin
`Yaml` (`@Source(id="yaml", extension="yml", dependencies={"migrate_source_yaml"})`) parses each
file with the Symfony YAML parser to compute the header (union of all record keys) and returns a
`getSourceMigrationDefinition()` that wires the migration's `source` to the `yaml` migrate
source plugin.

## Implementing one
Extend `BaseSourcePlugin`, add the `@Source` annotation, implement `getSourceMigrationDefinition()`
(and the interface getters: `getId`, `getHeader`, `getKey`, `getLanguage`, `getEntityType`,
`getBundle`). The manager exposes files of your `extension` in `source_dir` the same way as YAML.
