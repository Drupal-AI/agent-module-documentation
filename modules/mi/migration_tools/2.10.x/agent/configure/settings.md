# Migration Tools admin settings

Route `migration_tools.migration_tools_admin_form` → `/admin/content/migrate/migration_tools`
(permission: `administer site configuration`). Form class `Form\MigrationToolsAdminForm`. All values
persist in the `migration_tools.settings` config object (no config schema ships, so these are simple
scalars). They only affect **debug/log verbosity** during migration runs — none change migration
behaviour or destinations.

| Config key | Form field | Default | Meaning |
|---|---|---|---|
| `debug` | Enable Debug Logging | `0` | Master switch for verbose migration debug output. |
| `debug_level` | Debug Level | `'3'` | RFC log-level threshold (`0` = All, otherwise `RfcLogLevel` values) for messages emitted via `Message`. |
| `drush_debug` | Enable Drush Debug | `1` | Emit debug output to the Drush console during CLI migrations. |
| `drush_stop_on_error` | Enable Drush Stop On Error | `0` | Halt the Drush migration run on the first error. |

Defaults come from `config/install/migration_tools.settings.yml`. Set them without the UI via:
```bash
drush config:set migration_tools.settings debug 1 -y
drush config:set migration_tools.settings debug_level 3 -y
```
