<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LocalGov Forms long term storage (localgov_forms_lts) — agent index

An **experimental** LocalGov Drupal submodule that copies `webform_submission` entities into a **second,
operator-declared database** (the `localgov_forms_lts` connection) for long-term retention / data
warehousing, with **optional PII redaction** during copy. Lets the live site purge submissions while a
warehouse copy persists. Package `LocalGov Drupal`. Core `^10 || ^11`, PHP 8.0+. GPL-2.0-or-later.
Depends only on `webform:webform`. Part of `localgov_forms`.

- **Setup, the config form, cron, the Drush command, DB declaration, PII redaction** →
  [config/settings.md](config/settings.md)
- **The copy engine, the bespoke LTS storage/query, the view routes, install schema** →
  [api/storage-and-copy.md](api/storage-and-copy.md)

## What it provides (from source)

- **Second DB**: services `localgov_forms_lts_db` (a `Connection` from `Database::getConnection(key: localgov_forms_lts)`)
  and `localgov_forms_lts.query.sql` (a `QueryFactory` bound to that connection). `Constants::LTS_DB_KEY = localgov_forms_lts`.
- **Copy engine**: `src/LtsCopy.php` (`ContainerInjectionInterface`) — `copy()` copies up to 50
  (`Constants::COPY_LIMIT`) non-draft submissions changed since the last run, tracked via a keyvalue store
  (`localgov_forms_lts` / `last_copied_webform_sub_changed_ts`); applies the PII redactor plugin if configured.
- **Bespoke storage**: `src/LtsStorageForWebformSubmission.php` extends `WebformSubmissionStorage`, swaps in
  the LTS DB connection, disables persistent cache, custom cache-id prefix (`lts_values`), and uses the
  `localgov_forms_lts.query.sql` entity query.
- **Cron / hooks** (`localgov_forms_lts.module`): `hook_cron()` → copies recent submissions and logs a
  success/failure summary to the `localgov_forms_lts` logger channel; `localgov_forms_lts_has_db()` probes
  the connection.
- **Drush**: `src/Drush/Commands/LocalgovFormsLtsCommands.php` — `localgov-forms-lts:copy`
  (alias `forms-lts-copy`, option `--force`), batch-copies all existing submissions.
- **Config**: object `localgov_forms_lts.settings` (`is_copying_enabled` bool default false,
  `pii_redactor_plugin_id` machine_name default ''); schema in `config/schema/`; form
  `src/Form/LTSSettingsForm.php` at route `localgov_forms_lts.lts_config`
  (`/admin/structure/webform/config/submissions-lts`, `_permission: administer site configuration`).
- **Read UI**: `src/WebformSubmissionLtsListBuilder.php` (LTS submissions list, View+Notes ops only) and
  `src/Controller/WebformSubmissionLtsViewController.php` (`viewFromLts` / `noteViewFromLts` / `titleFromLts`),
  wired via routes + task/menu links.
- **PII redactor plugin type** is defined by the **parent** `localgov_forms` module
  (`plugin.manager.pii_redactor`); this submodule only consumes it (optionally, guarded by `container->has()`).

## Routes & access

- `entity.webform_submission.lts_collection` — `/admin/structure/webform/submissions/lts/{submission_view}`.
- `entity.webform_submission.lts_view` — `/admin/structure/webform/manage/{webform}/submission/{webform_sid}/lts`.
- `entity.webform_submission.lts_notes` — `…/submission/{webform_sid}/notes/lts`.
- All three gated by `_custom_access: \Drupal\webform\Access\WebformAccountAccess:checkSubmissionAccess`
  (core webform: `administer webform` / `administer webform submission` / `view any webform submission`).
- `localgov_forms_lts.lts_config` — config form, `_permission: administer site configuration`.

## Key operational facts

- Requires a `$databases['localgov_forms_lts']['default']` connection in `settings.php`; install recreates
  the webform_submission schema there. `hook_requirements()` reports availability at `/admin/reports/status`.
- Copying is **off by default**; enable at the config form. Cron copies ≤50/run — raise cron frequency if
  submissions arrive faster. **Uploaded files are not copied.** Removal of aged LTS records is a future todo.
