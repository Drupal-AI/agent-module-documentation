# Configure Config Ignore Auto

Route `config_ignore_auto.settings` → **Configuration → Development → Configuration synchronization →
Ignore Auto** (`/admin/config/development/configuration/ignore_auto`, permission `import configuration`).
Config object `config_ignore_auto.settings`:

| Key | Type | Default | Meaning |
|---|---|---|---|
| `status` | bool | `false` | Master switch for auto-tracking. Off by default; on prod override in settings.php. |
| `show_message` | bool | `false` | Show a status message each time a config is auto-ignored. |
| `ignored_config_entities` | sequence | `{}` | The auto-managed ignore list. Do not hand-edit except to remove lines. Always ignored (all directions). |
| `whitelist_config_entities` | sequence | `[core.extension]` | Config names that must **never** be auto-ignored (exact names only). |
| `direction_operations` | sequence | all six | Which `<direction>_<operation>` combos the auto-ignores apply to: `import_create/update/delete`, `export_create/update/delete`. |

Recommended production activation (keeps it off in dev/CI):
```php
// settings.php
$config['config_ignore_auto.settings']['status'] = TRUE;
```

## How it works (source map)

- `ConfigIgnoreAutoEventsSubscriber::configSave/configDelete` (`src/EventSubscriber/`) — on config
  save/delete, if enabled and not whitelisted, diffs `getRawData()` vs original (skips no-op saves), then
  appends the config name (prefixed with the collection for non-default collections) to
  `ignored_config_entities`, writing directly through `config.storage` and resetting the factory cache
  (avoids recursion through decorators like domain_config_ui).
- `config_ignore_auto_config_ignore_ignored_alter()` (`.module`) — merges the ignore list into Config
  Ignore for each selected `direction_operations`, and force-ignores
  `config_ignore_auto.settings:ignored_config_entities` for all operations.
- Safety gates (`config_ignore_auto_is_enabled()` / `config_ignore_auto_should_ignore()`): auto-ignore is
  **suppressed** during `isConfigSyncing()`, `hook_module_preinstall`/`preuninstall`, and when
  `system.maintenance_mode` is set (so hook_update_N config changes are not captured); a warning is shown on
  config forms while in maintenance mode.
- Domain Config UI integration (`src/Hook/DomainConfigUIHooks.php`) marks this module's own settings as
  disallowed for per-domain override.

The settings form itself (`src/Form/Settings.php`) lets you toggle status/message, edit the whitelist and
direction operations, and manually prune the auto-ignored list.
