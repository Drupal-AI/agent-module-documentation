# Migrate Source YAML — agent index

Provides exactly one thing: a Migrate API **source plugin `yaml`** that reads rows from a YAML
file. No admin UI, config object, permission, Drush command, or schema. Depends on core
`migrate`. You use it by referencing it as `source.plugin: yaml` in a migration definition.

- **The `yaml` source plugin: config keys (`file`, `ids`, `fields`), YAML shape, full example,
  gotchas** → [plugins/yaml-source.md](plugins/yaml-source.md)

Key facts:
- Class `\Drupal\migrate_source_yaml\Plugin\migrate\source\Yaml`, `@MigrateSource(id="yaml")`.
- **Required** source settings: `file` (path to the `.yml`) and `ids` (unique-key definition).
  Missing either → `MigrateException` at construct time.
- The YAML file's **top level must be a list of rows**; each row is a map of field → value
  (whole file is `Yaml::parse()`d into an `ArrayIterator`).
- Optional `fields` setting = field name → description (documentational only).
