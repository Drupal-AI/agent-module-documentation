# How migrations are generated and run

## Generation
`migrate_default_content_migration_plugins_alter()` (in `.module`) calls
`migrate_default_content.migration_generator` → `generateMigrations()` and merges the result
into the migration plugin definitions. So every `ENTITY_TYPE.BUNDLE.yml` in `source_dir`
becomes a migration definition automatically — there is nothing to declare per file.

The generator (`\Drupal\migrate_default_content\MigrationGenerator`) reads each file via a
`Source` plugin (the `yaml` plugin, id from `Plugin/MigrateDefaultContent/Source/Yaml.php`),
derives the entity type / bundle / langcode from the filename, computes the field list from the
YAML keys, and builds a migration whose:
- **source** is the `yaml` migrate source (`migrate_source_yaml`), `ids` keyed on the first
  column (`type: string`), plus `langcode` / `source_langcode` constants.
- **process** maps handle entity references, reference-revisions, layout sections, password
  hashing (`ContentIdToRevisionReference`, `NormalizeEntityReference`, `PasswordHash`,
  `LayoutArrayToLayoutSection` process plugins under `src/Plugin/migrate/process/`).
- **destination** is the entity type.

## Tags and groups
All generated migrations are tagged `migrate_default_content` and grouped by entity type,
so you can run a whole set or one entity type.

## Running
Use the standard Migrate API / drush commands (module adds no import command of its own):
```
drush migrate:import --tag=migrate_default_content     # import everything
drush migrate:import --group=<entity_type>             # one entity type's group
drush migrate:status                                   # list generated migrations
drush migrate:rollback --tag=migrate_default_content   # roll back
```
(`migrate_tools` provides these drush commands.)

## Overrides
`migration_override_dir` (default `overrides`, relative to `source_dir`) lets you drop partial
migration definitions to override the generated ones. `migration_export_dir` (default
`migrations`) is where `drush migrate-default-content:export-migrations` writes the fully
generated YAML migration definitions (see [../drush/commands.md](../drush/commands.md)).
