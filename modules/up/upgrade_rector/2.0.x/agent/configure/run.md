<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Run Upgrade Rector against a project

## Prerequisites
- Enable the module: `drush en upgrade_rector -y`. Install via Composer (`composer require drupal/upgrade_rector`) so the `palantirnet/drupal-rector` dependency and the `vendor/bin/rector` binary are present.
- PHP `exec()` must be available. `hook_requirements()` adds a "PHP exec()" line to the Status report; if `exec()` is disabled the module reports an error and cannot run.
- `RectorProcessor::findVendorPath()` looks for the binary at `DRUPAL_ROOT/vendor/bin/rector` first, then `dirname(DRUPAL_ROOT)/vendor/bin/rector` (the usual layout where `vendor/` sits next to the webroot). If neither exists it logs "Rector executable not found" and returns FALSE.

## The form
Route `upgrade_rector.run` → `/admin/reports/upgrade-rector` (menu: Reports), permission `administer software updates`.
Two collapsible sections list every non-core extension:
- **Custom projects** — extensions with no `project` (or `project: drupal`), not under a `/contrib/` path.
- **Contributed projects** — extensions with a drupal.org `project`, or living under `/contrib/`.

Nested extensions are collated: only the topmost extension of a project is listed (sub-modules run as part of their parent). Each section has a "Select project" dropdown and a "Run rector" button. Pick one project and submit.

## What running does
`RectorProcessor::runRector()` (service `upgrade_rector.rector_processor`):
1. Copies `rector-config-template.php` into the temp dir (`<temp>/upgrade_rector/rector-config.php`), substituting `$drupal_root`. The config loads the Drupal 8, 9 and 10 Rector rule sets, autoloads `core/`, `modules/`, `profiles/`, `themes/`, and targets file extensions `php module theme install profile inc engine`.
2. Runs, via PHP `exec()`:
   ```
   cd <vendor-parent> && <vendor>/bin/rector process <DRUPAL_ROOT>/<ext-path> --dry-run --config=<temp>/rector-config.php 2>&1
   ```
   `--dry-run` means **no files are modified** — Rector only reports the changes it would make.
3. Stores the raw output string in the `upgrade_status_rector_results` keyvalue collection, keyed by the extension machine name. Returns TRUE if the output contains `[OK] Rector is done!`.

`processResults()` classifies the run into a `state`:
- **success + empty patch** → "Nothing to patch" (no covered deprecations found — not proof of full compatibility).
- **fail** (no "files with changes" and no OK line) → "Patch error"; the raw log is kept for display/export.
- **mixed / patch present** → "Patch available"; output is reformatted into a unified diff (`Index:` / `--- a/` / `+++ b/` headers), plus the list of applied Rector rules and any error log.

## Viewing and exporting results
- **Result modal** — `upgrade_rector.result` `/admin/reports/upgrade-rector/result/{type}/{project_machine_name}` (opened as an AJAX modal from the form / from Upgrade Status). Shows the diff in a textarea, "List of applied rectors", and an error-log textarea when non-empty.
- **Export** — `upgrade_rector.export` `/admin/reports/upgrade-rector/export/{type}/{project_machine_name}` returns a file download (`Content-Disposition: attachment`):
  - patch present → `<name>-upgrade-rector.patch`
  - nothing to patch → `<name>-results.txt` (`Nothing to patch in <name>`)
  - failure → `<name>-errors.txt` (raw output)
- `{type}` is `module`, `theme` or `profile`; `{project_machine_name}` is the extension machine name. Both routes require `administer software updates`.

## Applying a patch
Patches are suggestions. Apply the exported `.patch` manually against the extension's directory, e.g. `git apply <name>-upgrade-rector.patch` (or `patch -p1 < …`), review the changes (some need further manual work), and run tests before committing. The UI never applies changes for you.

## Upgrade Status integration (optional)
If `drupal/upgrade_status` is also installed, three hooks in `upgrade_rector.module` add integration to its scan form (no effect when Upgrade Status is absent — the module is fully usable through its own form):
- `hook_form_drupal_upgrade_status_form_alter` — adds a "Generate patches for scanned projects with rector." checkbox (default on) and injects "Patch available / Nothing to patch / Patch error" links into the scan result rows.
- `hook_upgrade_status_operations_alter` — when that checkbox is set, duplicates each scan batch operation with a Rector run (`update_rector_run_rector_batch`) for the same extension.
- `hook_upgrade_status_result_alter` — adds the result link to the per-extension "rector" result group.

## Notes
- Results persist in keyvalue until re-run or module uninstall (`hook_uninstall` deletes the whole `upgrade_status_rector_results` collection).
- The UI copy references "Drupal 9 readiness", but the loaded rule sets include Drupal 10 transformations.
- `ProjectCollector` ignores core extensions and the module's own `upgrade_rector_test_*` fixtures.
- No Drush command ships; run through the admin form (or the Upgrade Status batch when integrated).
