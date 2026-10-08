# file_mdm — configuration

## Global settings
Form: `Drupal\file_mdm\Form\SettingsForm` at `/admin/config/system/file_mdm`
(route `file_mdm.settings`, permission `administer site configuration`).
Config object `file_mdm.settings` (defaults):
```yaml
metadata_cache:
  enabled: TRUE
  expiration: 172800        # seconds (48h); -1 = permanent
  disallowed_paths: {  }    # URIs/patterns excluded from caching
missing_file_log_level: 3   # RfcLogLevel; how missing files are logged
```

## Per-plugin config entities
Each FileMetadata plugin has a config entity `<provider>.file_metadata_plugin.<id>`
(e.g. `file_mdm.file_metadata_plugin.getimagesize`,
`file_mdm_exif.file_metadata_plugin.exif`, `file_mdm_font.file_metadata_plugin.font`).
It stores a `configuration` array whose `cache` block can override the global cache:
```yaml
configuration:
  cache:
    override: FALSE          # TRUE to use this plugin's own settings
    settings:
      enabled: TRUE
      expiration: 172800
      disallowed_paths: {  }
```
`FileMetadataPluginManager::createInstance()` merges the plugin's `defaultConfiguration()`
with this config entity when instantiating.

Schema: `config/schema/file_mdm.schema.yml` + `file_mdm.data_types.schema.yml`.
