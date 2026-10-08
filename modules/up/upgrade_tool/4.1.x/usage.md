<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Open Y Upgrade Tool records which configuration a site running the Open Y / YMCA Website Services distribution has customised away from the distribution's shipped defaults, so a distribution update knows, per config object, what it may safely overwrite and what the site has taken ownership of.

---

The problem belongs to distributions and is genuinely hard. A distribution ships configuration — content types, views, form/view displays, block layouts — and a site built on it customises some of that. When the distribution releases an update with improved defaults, importing them wholesale destroys the site's customisations, and importing nothing means the site never receives the improvements. This module maintains the record that makes an update decidable: a Symfony config-`SAVE` event subscriber (`ConfigEventSubscriber`) watches every config write, keeps only configs that belong to an extension whose machine name contains `openy` (it scans each such module/theme's `config/install` and `config/optional` directories via `getOpenyConfigList()`), and — when the save was **not** part of an Open Y config import (tracked by the global `$_openy_config_import_event` flag) and actually differs from the shipped version — creates or updates a revisionable `openy_upgrade_log` content entity capturing the customised data. The **Upgrade Dashboard** (`/admin/openy/development/upgrade-log/dashboard`, a Views-embedded controller) lists these as "Manual Changes" (unreviewed, `status = FALSE`) and "Reviewed Changes" (`status = TRUE`); a per-item **diff form** compares the site's active config against the distribution version (read from the module install/optional storage) or against a saved snapshot revision, using core's `DiffFormatter`. From the diff a maintainer chooses one of three resolutions: **Keep My Customization** (`applyCurrentActiveVersion()` — just marks `status = TRUE`), **Restore Distribution Version** (`applyOpenyVersion()` — re-imports the shipped YAML over the active config through config_import's importer and deletes the log), or **Edit Manually** (a YAML textarea whose contents are written to active config via `updateExistingConfig()`). The same three resolutions are exposed as Views bulk-operation **actions** and can be scripted from `hook_update_N` through the public services `openy_upgrade_log.manager`, `openy_upgrade_tool.param_updater` (single-property updates, extends config_import's `ConfigParamUpdaterService`) and `openy_upgrade_tool.importer` (full-config/directory imports). A `force_mode` setting (default on) lets distribution imports override customisations while first taking a backup revision. The package is named `openy_upgrade_tool` (module) under the drupal.org project `upgrade_tool` — `drush en upgrade_tool` fails; enable `openy_upgrade_tool`. It requires Drupal 11 (`^11`) and the `config_import` module (project `confi`). The pattern generalises beyond this one distribution: any site inheriting configuration from a shared upstream — a base profile, a multi-site platform, a recipe applied at build time — has the same ownership problem, and a record of what has been customised is what makes upstream updates applicable rather than theoretical.

---

- Track which distribution config a site has customised, automatically, as configs are saved.
- Review pending "Manual Changes" on the Upgrade Dashboard before applying a distribution update.
- Diff a single config object against the distribution's shipped version.
- Diff a config against an earlier captured snapshot (revision) of your own customisation.
- Keep a customisation and mark it reviewed so it stops flagging on future upgrades.
- Restore the distribution's version of one config, discarding local edits.
- Manually merge distribution changes into a customised config via an in-browser YAML editor.
- Bulk-resolve many flagged configs at once with Views bulk-operation actions.
- Script conflict resolution from `hook_update_N` when releasing a new distribution version.
- Update only a single nested property of a config (via `openy_upgrade_tool.param_updater`) without clobbering local edits to the rest.
- Re-import a full config or a whole directory of configs programmatically (`openy_upgrade_tool.importer`).
- Surface a site-status warning (`hook_requirements`) counting configs pending review after an upgrade.
- Audit configuration ownership across an Open Y association site.
- Roll back an unwanted config change using the captured log/revision history.
- Take an automatic backup revision before force-mode distribution imports overwrite a customisation.
- Distinguish, for maintainers, config a site intentionally owns from config that should follow upstream.
- Reduce the risk of a distribution update destroying site-specific customisations.
- Give distribution maintainers a per-object, decidable upgrade path instead of all-or-nothing config sync.
- Ignore specific config-change classes from tracking via `ConfigEventIgnore` plugins (e.g. Views UI churn).
- Plan and stage a multi-site Open Y platform's config upgrades.
- Document, over time, exactly what each site customised and when.
