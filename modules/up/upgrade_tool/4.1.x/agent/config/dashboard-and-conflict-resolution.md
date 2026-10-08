<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Dashboard & conflict resolution (config workflow)

## Where
- **Upgrade Dashboard:** `/admin/openy/development/upgrade-log/dashboard`
  (controller `OpenyUpgradeLogController::dashboard`; embeds View `openy_upgrade_dashboard`,
  displays `conflicts` and `resolved`). The View itself is access-gated by permission
  `administer openy upgrade log entities`.
- **Per-item diff:** `/admin/openy/development/upgrade-log/{openy_upgrade_log}/diff`
  (`OpenyUpgradeLogDiff`), permission `edit openy upgrade log entities`.
- **Manual merge (YAML editor):**
  `/admin/openy/development/upgrade-log/{openy_upgrade_log}/diff/manual_merge/{target}`
  (`OpenyUpgradeLogManualMerge`), permission `edit openy upgrade log entities`.
- **Settings:** the `openy_upgrade_log.settings` route → `force_mode` checkbox.

## The three resolutions (per config)
Backend terminology is "conflict / resolved"; the UI calls them "Manual Changes / Reviewed".

1. **Keep My Customization** → `OpenyUpgradeLog::applyCurrentActiveVersion()`.
   Sets the entity `status = TRUE` (reviewed) and saves. The site's active config is left
   untouched; it just stops being flagged as pending. Also available as the Views bulk action
   `apply_active_version` ("Keep My Customization (Mark as Reviewed)").
2. **Restore Distribution Version** → `OpenyUpgradeLog::applyOpenyVersion()` →
   `OpenyUpgradeLogManager::applyOpenyVersion($name)`. Reads the shipped YAML from the module's
   `config/install` (then `config/optional`) `ExtensionInstallStorage`, imports it over the active
   config via `updateExistingConfig(..., $delete_log = TRUE)` (a config_import batch), then deletes
   the log entity. **Overwrites local customisations.** Views bulk action `apply_openy_version`
   ("Restore Distribution Version").
3. **Edit Manually** → `OpenyUpgradeLogManualMerge`. Presents the distribution (or a snapshot
   revision's) YAML in a textarea; on submit the decoded YAML is written to the site's active config
   for that config name via `OpenyUpgradeLogManager::updateExistingConfig()`. Use this to hand-merge
   upstream changes into a customised config.

## Diff sources
`OpenyUpgradeLogDiff` compares the **active** config against either:
- the **distribution** version (`ExtensionInstallStorage`, install dir then optional dir), or
- a **saved snapshot** — an earlier revision of the `openy_upgrade_log` entity (revision storage
  `openy_upgrade_tool.config.storage.upgrade_log.revision`).
Rendered with core's `DiffFormatter` (`system/diff` library).

## force_mode
`openy_upgrade_tool.settings:force_mode` (default `1`). When on, a distribution config import is
allowed to override an existing customisation; `ConfigEventSubscriber` first calls
`createBackup()` to snapshot the current value as a revision. When off, `isManuallyChanged()`
treats a tracked config as protected.

## Status semantics
`openy_upgrade_log.status`: `FALSE` = pending review (a "Manual Change"/"conflict");
`TRUE` = reviewed/acknowledged (a "Reviewed Change"/"resolved"). `hook_requirements` surfaces a
runtime warning counting pending items and links to the dashboard.
