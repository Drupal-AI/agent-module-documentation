# Settings

Config object: `migrate_default_content.settings` (schema
`migrate_default_content.schema.yml`). Form at
`/admin/config/system/migrate-default-content/settings` (route
`migrate_default_content.settings`, requires `administer site configuration`).

| Key | Default | Meaning |
|---|---|---|
| `source_dir` | `../default_content` | Directory holding the content YAML files, relative to the Drupal **site root**. The default points one level above the root (a `default_content/` folder beside `web/`). |
| `migration_override_dir` | `overrides` | Directory (relative to `source_dir`) holding partial migration definitions that override generated ones. |
| `migration_export_dir` | `migrations` | Directory (relative to `source_dir`) where the export-migrations Drush command writes generated migration YAML. |

The **export submodule** (`migrate_default_content_export`) adds one more key to this same
config via a form alter: `content_export_dir` — the directory where exported *content* YAML is
written.

Set via drush:
```
drush config:set migrate_default_content.settings source_dir default_content -y
```

Note: the settings form does not validate that `source_dir` exists (see the `@todo` in
`SettingsForm.php`); a missing directory simply yields no generated migrations.
