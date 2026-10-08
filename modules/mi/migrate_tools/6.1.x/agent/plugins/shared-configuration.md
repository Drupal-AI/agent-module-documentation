# migrate_shared_configuration plugin

Defined by `MigrateSharedConfigPluginManager` (service
`plugin.manager.migrate_shared_config`). Lets a module declare source/process settings
once and `include` them from many migrations, reducing duplication.

## Declare shared config
In `MODULE.migrate_shared_configuration.yml` at the module root:
```yaml
d7_shared:
  source:
    key: drupal7
    batch_size: 1000
```
The top-level key is the machine name (`id`); everything under it is the shared
configuration. Default plugin class is `MigrateSharedConfigDefault`; alter with
`hook_migrate_shared_configuration_info_alter()`.

## Use it from a migration
A migration references shared entries via an `include` key (migrate_tools adds `include`
to the `migrate_plus.migration.*` config schema and to the migration entity's
`config_export`):
```yaml
id: my_migration
include:
  - d7_shared
source:
  plugin: d7_node
```
At build time `migrate_tools_migration_plugins_alter()` calls
`migrate_tools.shared_config_include_handler` (`MigrateIncludeHandler`) to merge each
included entry into the migration definition. Implement `MigrateSharedConfigInterface`
(or subclass `MigrateSharedConfigDefault`) for custom merge logic.
