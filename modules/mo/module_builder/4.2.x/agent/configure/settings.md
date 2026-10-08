# Settings & code analysis

Two setup surfaces, both under `/admin/config/development/module_builder` and both gated by the
`create modules` permission.

## Settings form

Route `module_builder.settings` → `/admin/config/development/module_builder/settings`
(`\Drupal\module_builder\Form\SettingsForm`, a `ConfigFormBase`, form id `module_builder_settings`).
Editable config: `module_builder.settings`.

| Field | Config key | Notes |
|---|---|---|
| Module builder data directory | `data_directory` | Textfield, required, prefixed `public://`. Folder inside the site's public files where the Drupal Code Builder (DCB) library stores its processed analysis data. Default `module_builder_data` (from `config/install`). |
| Module generation settings | `generator_settings.module` | A `details` group (`#tree`) built dynamically from the DCB `Configuration` task's data for the `module` component — booleans become checkboxes, options become radios, everything else textfields. Saved as a mapping; schema type is `ignore`, so keys depend on the installed DCB version. These values are passed to the generator for *every* generated module. |

Set via PHP:

```php
\Drupal::configFactory()->getEditable('module_builder.settings')
  ->set('data_directory', 'module_builder_data')
  ->set('generator_settings.module', [/* DCB module-config keys */])
  ->save();
```

Or with Drush: `drush config:set module_builder.settings data_directory module_builder_data`.

Config schema (`config/schema/module_builder.schema.yml`): `module_builder.settings` is a
`config_object` with `data_directory` (string) and `generator_settings.module` (type `ignore`).

## Analyse site code

Route `module_builder.analyse` → `/admin/config/development/module_builder/analyse`
(`\Drupal\module_builder\Form\ProcessForm`, form id `module_builder_process`).

This builds DCB's knowledge of the components that exist *on this site* — hooks, plugin types,
tagged services, etc. — by scanning core, contrib and custom code, and stores the result in the
`data_directory`. Generation reads from this data, so the scaffolding matches the installed core
version and enabled modules rather than a generic template.

- Run it once after install, and again after enabling/updating modules, updating core, or changing
  custom code. An optional **Clear all caches before analysis** checkbox flushes caches first (use
  after custom-code changes).
- Submission runs the DCB `Collect` task via the Batch API: `getJobList()` is chunked into batches
  of 10 and processed by `ProcessForm::batchOperation()` calling `collectComponentDataIncremental()`.
- The form reports the last-updated date and a per-type summary of stored data (from the
  `ReportSummary` task). If the data directory is missing or unwritable, DCB raises a
  `SanityException('data_directory_exists')` and the form shows an error instead of the analysis UI.
- Task handlers are obtained through the `module_builder.drupal_code_builder` service, e.g.
  `getTask('Collect')`, `getTask('ReportSummary')`.

## Installation note

The DCB library is a Composer dependency (`drupal-code-builder/drupal-code-builder ^4.6`); installing
the module with Composer pulls it in. `hook_requirements()` (install phase) fails the install if
`\DrupalCodeBuilder\Factory` cannot be loaded.
