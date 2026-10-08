<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Upgrade Rector (upgrade_rector) — agent index

**Runs Drupal-rector against a chosen custom/contrib extension and produces a downloadable patch that fixes deprecated Drupal API use. Companion to Upgrade Status.**

- **Version:** 2.0.x (2.0.0-alpha3) · Core: ^9 || ^10 || ^11 · Package: Administration
- **Configure route:** `upgrade_rector.run` → `/admin/reports/upgrade-rector` (under Reports)
- **Access:** core permission `administer software updates` (defines none of its own)
- **Composer dep:** `palantirnet/drupal-rector ~0.11` (bundles the `rector/rector` engine); needs PHP `exec()` and a Composer-installed `vendor/bin/rector`
- **No permissions, no config schema, no Drush commands, no blocks, no submodules documented.**

**Surface (all 3 routes require `administer software updates`):**
- `upgrade_rector.run` — the form: select a custom or contrib project, "Run rector".
- `upgrade_rector.result` `/admin/reports/upgrade-rector/result/{type}/{project_machine_name}` — modal showing the diff + applied rules + error log.
- `upgrade_rector.export` `/admin/reports/upgrade-rector/export/{type}/{project_machine_name}` — downloads `<name>-upgrade-rector.patch` / `-results.txt` / `-errors.txt`. `{type}` = module|theme|profile.

**Mechanism:** writes a Rector config from `rector-config-template.php` (Drupal 8/9/10 rule sets), runs `vendor/bin/rector process <ext-path> --dry-run` via `exec()`, stores raw output per extension in the `upgrade_status_rector_results` keyvalue collection, reformats it into a unified diff. Dry-run only — never edits files; patches are applied manually.

**Services:** `upgrade_rector.rector_processor` (RectorProcessor: runRector/processResults/formatResults), `upgrade_rector.project_collector` (ProjectCollector: lists non-core extensions grouped custom/contrib).

**Upgrade Status integration (optional):** if `drupal/upgrade_status` is installed, hooks add a "Generate patches" checkbox to its scan form, run Rector as an extra batch op per project, and inject "Patch available / Nothing to patch / Patch error" links into its results. Works standalone without it.

See [configure/run.md](configure/run.md) for the full workflow, output states, and requirements.

**Access model:** admin-only dev/upgrade tool behind `administer software updates`; runs Rector in `--dry-run` and produces patches for review, never modifying code in place. No findings.
