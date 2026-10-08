<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Open Y Upgrade Tool (project `upgrade_tool`, module `openy_upgrade_tool`) — agent index

Config-upgrade helper for the **Open Y / YMCA Website Services** distribution. It records which
configuration a site has **customised away from the distribution's shipped defaults**, shows a
per-item **diff dashboard**, and lets a maintainer keep the customisation or restore the
distribution version. Installed release documented here: **4.2.0** (branch 4.2.x). Core
**`^11` (Drupal 11 only)**. Depends on the **`config_import`** module (drupal.org project `confi`).

**Name mismatch:** drupal.org project is `upgrade_tool`; the module machine name is
**`openy_upgrade_tool`**. `drush en upgrade_tool` fails — enable `openy_upgrade_tool`.

## What it does (mechanism, from source)
- **`ConfigEventSubscriber`** (services.yml → tag `event_subscriber`, priority 800 on `ConfigEvents::SAVE`)
  watches every config save. It keeps a config only if the config belongs to an extension whose
  machine name **contains `openy`** (`OpenyUpgradeLogManager::getOpenyConfigList()` globs each such
  module/theme's `config/install` + `config/optional`). If the save was **not** an Open Y config
  import (global `$_openy_config_import_event` is FALSE) and the data differs from the shipped
  version, it creates/updates a revisionable **`openy_upgrade_log`** content entity holding the
  customised data and logs a warning.
- **Dashboard** — `OpenyUpgradeLogController::dashboard()` at
  `/admin/openy/development/upgrade-log/dashboard`, embedding the `openy_upgrade_dashboard` View
  (displays `conflicts` / `resolved`). "Manual Changes" = `status FALSE` (pending review);
  "Reviewed Changes" = `status TRUE`.
- **Diff form** (`OpenyUpgradeLogDiff`) compares active config against the distribution version
  (read from module `ExtensionInstallStorage`) or a saved snapshot revision, via core `DiffFormatter`.
- **Three resolutions** (entity methods, also exposed as Views bulk **Action** plugins):
  - `applyCurrentActiveVersion()` — Keep My Customization; just sets `status = TRUE`.
  - `applyOpenyVersion()` — Restore Distribution Version; re-imports shipped YAML over active config
    (through config_import) and deletes the log entity.
  - `updateExistingConfig($name, $data)` — Edit Manually; writes YAML from a textarea to active config.
- **Settings** (`openy_upgrade_tool.settings`, schema provided): `force_mode` (default **1**) — lets
  distribution imports override a customisation, taking a backup revision first.

## Programmatic API (used from `hook_update_N` when shipping a new distribution version)
- `openy_upgrade_log.manager` — `loadByName()`, `applyOpenyVersion()`, `updateExistingConfig()`,
  `readConfigFromExtensions()`, status helpers.
- `openy_upgrade_tool.param_updater` (`ConfigParamUpgradeTool`, extends config_import's
  `ConfigParamUpdaterService`) — update a **single nested property** of a config.
- `openy_upgrade_tool.importer` (`ConfigUpdater`) — `setDirectory()` + `importConfigs()` /
  `importConfigSimple()` for full-config / directory imports.
- Plugin type **`config_event_ignore`** (`plugin.manager.config_event_ignore`,
  `@ConfigEventIgnore` annotation) — suppress tracking of change classes (ships a `Views` plugin).

See `agent/config/dashboard-and-conflict-resolution.md` and
`agent/api/programmatic-config-update.md`.

## Gotchas
- **Routing paths in `openy_upgrade_tool.routing.yml` begin with a literal space**
  (`' /admin/openy/development/upgrade-log/…'`) — a packaging slip; verify actual reachability
  (the entity collection route reaches the same controller).
- **False positives on fresh install** (documented in README): duplicate configs installed by
  multiple `openy_*` modules get tracked as "manually updated" because `$_openy_config_import_event`
  is FALSE during install. Clear them on the dashboard or `TRUNCATE openy_upgrade_log`.
- **Tracking is keyed on the extension machine name containing `openy`, not the config name.** A
  config in a non-`openy` module is never tracked, even if its name contains `openy`.
- No Drush commands. No submodules.
