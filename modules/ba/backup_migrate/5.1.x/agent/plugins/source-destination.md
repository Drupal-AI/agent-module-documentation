# Source & Destination plugins

Two annotation-based plugin types (managers in `backup_migrate.services.yml`:
`plugin.manager.backup_migrate_source`, `plugin.manager.backup_migrate_destination`):

| Plugin type | Annotation | Namespace | Manager |
|---|---|---|---|
| Source | `@BackupMigrateSourcePlugin` | `Plugin/BackupMigrateSource/` | `SourcePluginManager` |
| Destination | `@BackupMigrateDestinationPlugin` | `Plugin/BackupMigrateDestination/` | `DestinationPluginManager` |

Built-in sources: `DefaultDBSourcePlugin`, `MySQLSourcePlugin`, `EntireSiteSourcePlugin`,
`DrupalFilesSourcePlugin`, `FileDirectorySourcePlugin`. Built-in destination:
`DirectoryDestinationPlugin`.

To add one, create a class in your module's matching `Plugin/BackupMigrateSource/` (or
`.../BackupMigrateDestination/`) namespace, add the annotation (`id`, `title`,
`description`, `type`), and extend the corresponding Drupal entity plugin base under
`src/Drupal/EntityPlugins/`. The underlying backup engine plugins (the actual read/write
logic) live in `src/Core/Source/` and `src/Core/Destination/` and implement the
Core `PluginInterface`; subclass those to add real transport (e.g. remote/cloud storage).
