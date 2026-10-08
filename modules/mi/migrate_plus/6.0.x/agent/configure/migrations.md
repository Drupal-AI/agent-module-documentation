# Migration & migration_group config entities

Migrate Plus adds two config entity types (`src/Entity/Migration.php`,
`src/Entity/MigrationGroup.php`), so migrations live as YAML config instead of code.

## Migration (`migrate_plus.migration.*`)
Config-export keys: `id, class, idMap, field_plugin_method, cck_plugin_method,
migration_tags, migration_group, status, label, source, process, destination,
migration_dependencies`.

`config/install/migrate_plus.migration.beer_node.yml` (abridged):
```yaml
id: beer_node
label: Beers of the world
migration_group: beer
migration_tags: { }
source:
  plugin: beer_node          # or 'url' / 'table' / a custom source
process:
  title: name
  type:
    plugin: default_value
    default_value: article
destination:
  plugin: entity:node
migration_dependencies:
  required:
    - beer_user
    - beer_term
```
Referenced by ID (`beer_node`) — migrate_plus strips the `migration_config_deriver:` prefix
so derived migrations are addressable by their declared `id`.

## Migration group (`migrate_plus.migration_group.*`)
Config-export keys: `id, label, description, source_type, module, shared_configuration`.
`shared_configuration` is merged into every migration in the group
(`migrate_plus_migration_plugins_alter()`), array values merged recursively, migration values
winning on conflict:
```yaml
id: beer
label: Beer Imports
source_type: 'Custom tables'
shared_configuration:
  source:
    constants:
      base_path: 'public://'
```

- Migrations with no `migration_group` fall into the auto-created `default` group.
- Run/inspect these with the Migrate Tools drush commands (`drush migrate:import`, `migrate:status`).
- Being config, they import via `drush config:import` and deploy across environments.
