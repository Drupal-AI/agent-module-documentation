# Configure — Config Patch

## Config object: `config_patch.settings`

| Key | Type | Meaning |
|---|---|---|
| `config_base_path` | string | Relative path prefix prepended to each config file path in the generated patch, so paths match your repo layout (e.g. `web/sites/default/files/config_XXX/sync` or `config`). Must NOT start with `/` (validated). |
| `output_plugin` | string | Default output plugin id for the Patch tab (defaults to `text`). |

Settings form: route `config_patch.settings` → `admin/config/development/config_patch`,
permission **`administer config_patch`** (`restrict access: true`).

### settings.php override (zero-config)

```php
$config['config_patch.settings']['config_base_path'] = 'web/' . $settings['config_sync_directory'];
```

## Routes & permissions

| Route | Path | Permission |
|---|---|---|
| `config.patch` | `admin/config/development/configuration/patch` | `export configuration` |
| `config.patch_per_plugin` | `…/patch/{plugin_id}` | `export configuration` |
| `config_patch.settings` | `admin/config/development/config_patch` | `administer config_patch` |
| `config_patch.clear_cache` | `…/config_patch/clear-cache` | `export configuration` |
| `config_patch.toolbar` | `…/config_patch/toolbar` (AJAX) | `export configuration` |
| `config_patch.revert` | `…/config_patch/revert/{config_names}` | `import configuration` |

All three permissions are restricted (core `export configuration` / `import configuration`
are `restrict access: true`; `administer config_patch` is too). The **Patch** tab renders as a
task beside *Synchronize*; a toolbar widget shows the count of differing config items.

## What it does

`ConfigCompare` (`src/ConfigCompare.php`) diffs active vs sync/export storage with
`sebastian/diff`, honoring Config Ignore when enabled, and hands the per-collection patch set
to the selected output plugin. The revert form (`ConfirmRevertForm`) restores a named config
object from sync (hence the `import configuration` gate).
