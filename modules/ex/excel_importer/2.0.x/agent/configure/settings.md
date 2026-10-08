# Settings

Route `excel_importer.admin_settings` → **`/admin/config/content/excel_importer`**, gated by
permission `administer excel_importer`. Form `Drupal\excel_importer\Form\ExcelImporterSettingsForm`
(a `ConfigFormBase`, form id `excel_importer_admin_settings`). A menu link
(`excel_importer.links.menu.yml`) places it under *Administration › Configuration › Content authoring*.

## Config object: `excel_importer.settings`

Schema `config/schema/excel_importer.schema.yml`; install default `config/install/excel_importer.settings.yml`.

| Key | Type | Meaning | Install default |
|---|---|---|---|
| `allowed_types` | `sequence` of `string` | Content-type machine names that may be imported into. A worksheet's title must match one of these to be processed. | `['article']` |
| `introduction` | `text_format` (only the value string is stored) | HTML shown above the upload field on `/excel-import`. | intro `<p>` with placeholder guideline/template links |

## Form fields

- **`excel_importer_introduction`** — a `text_format` element; the submit handler saves only
  `['value']` (`introduction`); the chosen text format is intentionally **not** persisted
  (`@todo Save both value and format` in code).
- **`excel_importer_types`** — `checkboxes` built from `node_type_get_names()` (all content types on
  the site). On submit the selected values are `array_filter`ed, `sort`ed, and saved to
  `allowed_types`.

## Set without the UI

Via Drush:

```sh
drush config:set excel_importer.settings allowed_types.0 article -y
drush config:set excel_importer.settings allowed_types.1 page -y
drush config:set excel_importer.settings introduction '<p>Upload your XLSX.</p>' -y
```

Via PHP:

```php
\Drupal::configFactory()->getEditable('excel_importer.settings')
  ->set('allowed_types', ['article', 'page'])
  ->set('introduction', '<p>Upload your XLSX.</p>')
  ->save();
```

The import form reads `allowed_types` to decide which sheets to process and which node bundles to
create, so a bundle must be listed here before any of its rows import.
