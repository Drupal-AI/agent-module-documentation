# Configure Default Content Deploy

Settings form: `Drupal\default_content_deploy\Form\SettingsForm` (form id
`dcd_settings_form`), route `default_content_deploy.settings` at
`/admin/config/development/dcd` (permission `administer site configuration`).
Config object: **`default_content_deploy.settings`** (constant `SettingsForm::CONFIG`).

## Config keys (schema `default_content_deploy.schema.yml`)

| Key | Type | Meaning |
| --- | --- | --- |
| `content_directory` | string | Path where JSON files are written/read. Relative (to `index.php`, e.g. `../content`) or absolute (e.g. `/var/dcd/content`). No default — if unset, export/import throw "Directory for content deploy is not set." A path outside the web root is the usual deployment convention. |
| `text_dependencies` | boolean | Include entities embedded in processed-text (WYSIWYG) fields when exporting references. |
| `skip_export_timestamp` | boolean | Omit the per-entity `export_timestamp` metadata (affects incremental import decisions). |
| `skip_entity_types` | sequence(string) | Entity type IDs never exported indirectly by reference or during a site export. |
| `batch_ttl` | integer | Seconds an orphaned import/export batch queue item lives before `hook_cron` garbage-collects it. Default `14400`. |
| `skip_computed_fields` | boolean | Exclude computed fields from export. |
| `skip_processed_values` | boolean | Exclude processed values from export. |

The `SettingsForm` also renders the shared elements (via `getCommonFormElements()`)
that the `search_api_default_content_deploy` submodule reuses inside the Search API
index form.

## Set the directory (any of these)

settings.php / a settings include (config override):

```php
// Relative to index.php.
$config['default_content_deploy.settings']['content_directory'] = '../content';
// Absolute.
$config['default_content_deploy.settings']['content_directory'] = '/var/dcd/content';
```

Drush:

```bash
drush config-set default_content_deploy.settings content_directory '../content'
drush config-set default_content_deploy.settings batch_ttl 14400
```

PHP:

```php
\Drupal::configFactory()->getEditable('default_content_deploy.settings')
  ->set('content_directory', '../content')
  ->set('skip_entity_types', ['user', 'path_alias'])
  ->save();
```

## UI operations

- **Import** — route `default_content_deploy.import` (`/…/dcd/import`, form
  `ImportForm`, permission `default content deploy import`). Import from a server
  folder, or upload a `.tar.gz` archive whose structure matches an export;
  optional "Force override".
- **Export** — route `default_content_deploy.export` (`/…/dcd/export`, form
  `ExportForm`, permission `default content deploy export`). Choose mode
  (`default` / `reference` / `all`), entity type, bundle, IDs; either write to the
  folder or tick "Export to a tar archive" to be redirected to the download route.
- **Download** — route `default_content_deploy.export.download`
  (`DownloadController::downloadCompressedContent`) streams the compressed export
  (`{temp}/dcd/content.tar.gz`) as an attachment; permission `default content deploy export`.

## Runtime notes

`hook_cron` (`default_content_deploy_cron`) instantiates a `DefaultContentDeployBatch`
queue and calls `garbageCollection()` to delete batch rows named
`default_content_deploy:%` older than `batch_ttl`. Both export and import run as
progressive Batch API operations backed by that queue class.
