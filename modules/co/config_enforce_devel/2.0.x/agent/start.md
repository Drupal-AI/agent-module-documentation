<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config Enforce - Devel — agent index

info.yml name: **Config Enforce - Devel**. info.yml description: *"Allows some configuration to be read-only."*
Version **2.0.0-beta0** (beta). Core `^10.1 || ^11`. Package `Configuration`.

The **development-only companion UI** for [Config Enforce](https://www.drupal.org/project/config_enforce).
Config Enforce is the runtime that keeps selected config read-only; this module is the authoring tool a
developer uses to *decide* which config objects to enforce, at what strictness, and to **write the resulting
config YAML into module directories in the codebase** so the enforcement ships with the code. README states
plainly: **only install in development environments.**

Depends on `config_devel:config_devel`, `config_enforce:config_enforce`, `multiselect:multiselect`.
Configure route: `config_enforce_devel.settings`.

## What it does (mechanism)

- **Enforced-configs registries.** Enforcement metadata (`enforced_configs`) is stored as config on a *target
  module* and written to that module's `config/install/*.enforced_configs.yml`. This module provides the
  read/**write** subclasses (`TargetModule`, `EnforcedConfigRegistry`, `EnforcedConfigCollection`,
  `TargetModuleCollection`) of Config Enforce's read-only base classes.
- **Marks config for enforcement.** Per-config off-canvas form (`ConfigEnforceForm`) reachable from an
  enforcement indicator injected into config forms via `hook_form_alter`. Choose target module, config
  directory (Install/Optional), enforcement level, and dependencies. Also an "enforce by default" mode with an
  ignore-list.
- **Bulk generation.** `GenerateFromModulesForm` (from a module's shipped config dirs) and
  `GenerateFromActiveStorageForm` (from active storage) create enforcement settings for many configs at once.
- **Creates & installs target modules.** `AddModuleForm` → `TargetModuleBuilder` writes a new
  `<path>/<machine_name>/<machine_name>.info.yml` (from `templates/info.yml.twig`) and enables it via a
  copied-from-core `TargetModuleInstaller` (kernel reboot). On first install, a default target module
  `config_enforce_default` is auto-created in `modules/custom`.
- **Writes config files to disk.** `EnforcedConfigFile` writes/deletes each enforced config's YAML at
  `<target module path>/<config_directory>/<config_name>.yml` (via config_devel's writeback subscriber);
  path is derived from the target module's on-disk location + the chosen config directory. Hashes are tracked
  so config_devel auto-import/export stays in sync (`ConfigDevelHelper`, patched config_devel hooks).
- **Config-delete cleanup.** `ConfigDeleteSubscriber` removes enforcement settings + the on-disk file when an
  enforced config object is deleted.
- **Toolbar** item + tour tips; **Drush** `config-enforce:update` (alias `ceu`) rewrites all enforced config
  files from active storage and refreshes hashes.

## Routes / access

All routes under `/admin/config/development/config_enforce/*` require the core permission
**`administer site configuration`** (no custom permission is defined). Routes: `settings`, `enforced_configs`,
`config_edit/{config_name}`, `generate/modules`, `generate/active_storage`, `module/add`.

## Facts

- Provides: config schema (`config_enforce_devel.settings`), a Drush command, a render element
  (`config_enforce_devel_indicator`), an event subscriber, a toolbar item. **No** module-defined permission.
- No settings form of its own beyond `SettingsForm` (defaults: enforce-by-default, default target module,
  default config directory, enforcement level, enforce-dependencies; plus available target modules and
  ignored configs).
- Patches `config_devel` (issue #3163349) to add auto-import/export hooks — Composer patching must be enabled.
- Companion runtime module documented at `modules/co/config_enforce/`.

See `usage.md` and `human-docs/` for the build-time workflow.
