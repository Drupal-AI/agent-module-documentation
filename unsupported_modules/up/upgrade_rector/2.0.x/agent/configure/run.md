<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Running rector & reading results

No settings form — the "config" is the run report itself. All three routes require the core
permission **`administer software updates`** (`restrict access: true`).

## Routes

| Route | Path | Handler |
|---|---|---|
| `upgrade_rector.run` | `/admin/reports/upgrade-rector` | `UpgradeRectorForm` (pick a project, run rector) |
| `upgrade_rector.result` | `/admin/reports/upgrade-rector/result/{type}/{project_machine_name}` | `RectorResultController::resultPage` — HTML diff review |
| `upgrade_rector.export` | `/admin/reports/upgrade-rector/export/{type}/{project_machine_name}` | `RectorResultController::resultExport` — downloads `<project>-upgrade-rector.patch` |

`{type}` is the extension type (`module` / `theme` / `profile`); `{project_machine_name}` is
the extension machine name.

## The run form

`UpgradeRectorForm` groups installed projects (from `ProjectCollector::collectProjects()`)
into **Custom projects** and **Contributed projects** details sections, each with a
`Select project` dropdown and a `Run rector` submit button. Submitting runs rector
synchronously on the selected extension and reloads the page with the formatted result.

## What "Run rector" does

`RectorProcessor::runRector(Extension $extension)`:
1. Locates the rector binary via `findVendorPath()` — checks `<DRUPAL_ROOT>/vendor/bin/rector`
   then `dirname(DRUPAL_ROOT)/vendor/bin/rector`. If absent it logs an error and aborts
   (this is the usual "Rector executable not found" case — install module deps with Composer).
2. Writes a generated config to a temp dir (`<temp>/upgrade_rector/rector-config.php`), built
   from the module's `rector-config-template.php` with `$drupal_root` substituted.
3. Runs, via PHP `exec()`:
   ```
   cd <vendor-parent> && <vendor>/bin/rector process <DRUPAL_ROOT>/<extension-path> \
     --dry-run --config=<temp>/rector-config.php 2>&1
   ```
   `--dry-run` means rector reports changes but does **not** modify files.
4. Stores the raw stdout string in the `upgrade_status_rector_results` key/value store, keyed
   by extension name. Success is detected by the presence of `[OK] Rector is done!`.

## Reading / exporting results

- `resultPage` runs the stored raw output through `RectorProcessor::processResults()` and
  renders a diff/textarea (used in the AJAX modal linked from the form and from Upgrade Status).
- `resultExport` returns the patch as a `text/plain` `Response`. States: no result → message;
  success but empty patch → "Nothing to patch in <project>"; otherwise the `.patch` body.

## Upgrade Status integration

`upgrade_rector_form_drupal_upgrade_status_form_alter()` injects a per-project link
(`Patch available` / `Nothing to patch` / `Patch error`) into the Upgrade Status report,
pointing at `upgrade_rector.result`. Reads the same key/value results; requires the
`upgrade_status` module.

## Prerequisites & caveats

- Requires `palantirnet/drupal-rector` installed (it is a Composer `require` of this module,
  resolved into the site's `vendor/`). If `vendor/` isn't reachable from the webroot the run
  fails cleanly with a logged error.
- Output is advisory. It never patches your code and is not a substitute for running tests.
- Runs are synchronous within the request (no batch/queue); large codebases can be slow.
