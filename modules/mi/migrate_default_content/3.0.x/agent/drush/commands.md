# Drush commands

Registered via PHP attributes in `src/Drush/Commands/MigrateDefaultContentCommands.php`
(no `drush.services.yml`).

## `migrate-default-content:export-migrations` (alias `mdcem`)
Generates the migration definitions (same ones used at runtime) and writes each as a YAML file
to `{source_dir}/{migration_export_dir}` (defaults to `default_content/migrations`). Creates the
directory if missing.
```
drush migrate-default-content:export-migrations
drush mdcem
```
Use it to inspect or version-control the exact generated migrations, or as a starting point for
overrides.

To actually **import** the content, use the standard Migrate commands (from `migrate_tools`),
not this module — see [../api/migrations.md](../api/migrations.md):
```
drush migrate:import --tag=migrate_default_content
```

The **export submodule** adds a separate command to generate content YAML from existing site
content — see
[../../../modules/migrate_default_content_export/3.0.x/agent/drush/commands.md](../../../modules/migrate_default_content_export/3.0.x/agent/drush/commands.md).
