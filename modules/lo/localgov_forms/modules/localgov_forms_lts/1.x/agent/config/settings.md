<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Setup, config, cron, and the Drush command

## 1. Declare the LTS database (required)

The module reads/writes a second database keyed `localgov_forms_lts` (`Constants::LTS_DB_KEY`). Add to
`settings.php` (README example):

```php
$databases['localgov_forms_lts']['default'] = [
  'database' => 'our-long-term-storage-database',
  'username' => '…', 'password' => '…', 'host' => '…', 'port' => '3306',
  'driver' => 'mysql', 'prefix' => '',
];
```

`localgov_forms_lts_has_db()` (`.module`) probes it via `Database::getConnection(key: …)`. If absent, the
Drush command and cron copy no-op and `hook_requirements()` reports an error.

## 2. Install

`drush en localgov_forms_lts` (requires `webform`). `hook_install()`
(`localgov_forms_lts.install`) — if the LTS DB is reachable — recreates **all** `webform_submission` entity
storage tables in it. It does this by instantiating an anonymous subclass of
`WebformSubmissionStorageSchema` to call the protected `getEntitySchema()`, then `createTable()`s each table
into the LTS DB inside a transaction (`_localgov_forms_lts_copy_table()`, rollback on error). Check
`/admin/reports/status` → "LocalGov Forms LTS" (from `hook_requirements()`).

## 3. Config form (`LTSSettingsForm`, route `localgov_forms_lts.lts_config`)

- Path `/admin/structure/webform/config/submissions-lts`, `_permission: administer site configuration`
  (task tab under `webform.config`).
- Uses `ConfigFormBase` + `RedundantEditableConfigNamesTrait` (`#config_target` binds fields to the config
  object). Two fields:
  - `is_copying_enabled` (radios Yes/No) → `localgov_forms_lts.settings:is_copying_enabled`.
  - `pii_redactor_plugin_id` (select) → `localgov_forms_lts.settings:pii_redactor_plugin_id`. Options come
    from the parent module's `plugin.manager.pii_redactor` (`Constants::PII_REDACTOR_PLUGIN_MANAGER`) if
    present (`create()` guards with `$container->has(...)`); empty option = no redaction.

### Config object `localgov_forms_lts.settings`
`config/install/localgov_forms_lts.settings.yml`: `is_copying_enabled: false`, `pii_redactor_plugin_id: ''`.
`config/schema/localgov_forms_lts.schema.yml`: `type: config_object`; `is_copying_enabled` boolean,
`pii_redactor_plugin_id` machine_name.

Copying is **disabled by default** — enable it here before cron/Drush will copy without `--force`. For
non-production environments, either set "No" here or override `localgov_forms_lts.settings:is_copying_enabled`
in `settings.php` (README suggests `config_split` too) so dev/stage do not write to the warehouse DB.

## 4. Cron copying (`hook_cron`)

`hook_cron()` → `localgov_forms_lts_copy_recently_added_n_updated_subs()`: returns early unless
`is_copying_enabled`; builds the PII redactor plugin from config (if any); `LtsCopy::create(...)->copy()`
copies **up to 50** (`Constants::COPY_LIMIT`) non-draft submissions changed since the last run; logs a
`Successfully copied … / Failed copies …` summary to the `localgov_forms_lts` logger channel. If your site
receives >50 submissions between cron runs, not all will be copied that cycle — raise cron frequency.

## 5. Drush command (`LocalgovFormsLtsCommands`)

`localgov-forms-lts:copy` (alias `forms-lts-copy`), option `--force`.
- No-ops with an error if the LTS DB is missing.
- Proceeds only if `--force` **or** `is_copying_enabled` is true (else warns "use --force").
- Loads the PII redactor plugin from config; computes batch count from `findCopyTargets()` size /
  `COPY_LIMIT`; runs a Drupal batch (`copyInBatch()` calls `LtsCopy::create(...)->copy()` per batch) via
  `drush_backend_batch_process()`.
- Intended one-off after install to back-fill existing submissions: `drush localgov-forms-lts:copy --force`.

## 6. Per-Webform purge (optional, on the live site)

Because LTS is a separate DB, you can set individual Webforms to purge their live submissions after N days
(each Webform's `Settings > Submissions > Submission purge settings`) while the LTS copy persists — live
data-minimisation plus long-term retention. (This is core Webform purge; LTS just keeps its own copy.)

## Notes
- **Uploaded files are not copied** to LTS (values/metadata only).
- Removal of aged LTS records after a retention period is a documented **todo**, not yet implemented.
- Module lifecycle is `experimental`.
