<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration Inspector: routes & service

## Routes (all require `administer site configuration`)

| Route | Path | Controller | Purpose |
| --- | --- | --- | --- |
| `acquia_cms_support.config_sync` | `/admin/config/development/acquia-cms-support` | core `SystemController::systemAdminMenuBlockPage` | Landing menu block ("Acquia CMS - Configuration Inspector"). |
| `acquia_cms_support.config_overridden` | `.../overridden-config` | `Controller\AcquiaCmsConfigSyncOverridden::build` | Lists ACMS config objects whose active value differs from the shipped value, each with a parity %. |
| `acquia_cms_support.config_unchanged` | `.../unchanged-config` | `Controller\AcquiaCmsConfigSyncUnchanged::build` | Lists ACMS config objects still identical to shipped defaults. |
| `acquia_cms_support.config_diff` | `.../diff/{name}/{type}/{storage}/{source_name}/{target_name}` | `Controller\AcquiaCmsConfigDiff::diff` | Two-way YAML diff (Staged vs Active) for one config object, rendered as a diff table/modal. `{name}` is a module or profile, `{type}` = `module`/`profile`, `{storage}` = `install`/`optional`. |

## Service `acquia_cms_support.config_service` — `AcquiaCmsConfigSyncService`

`@internal`. Args: `config.factory`, `config.storage` (active/target), `config.import_transformer`.

| Method | Returns | Purpose |
| --- | --- | --- |
| `getOverriddenConfig(StorageInterface $syncStorage)` | array of `['name','parity']` | Config objects (created/updated in the change list) with parity < 100. |
| `getUnChangedConfig(StorageInterface $syncStorage)` | array of names | Config objects at 100% parity (or all shipped names if there are no changes). |
| `getParity($configFile, StorageInterface $syncStorage)` | int 0–100 | Line-diff parity between active and shipped YAML, after stripping `_core`/`uuid`/`default_config_hash`. |
| `getInstallStorage($path)` / `getOptionalStorage($path)` | `FileStorage` | Build a `FileStorage` for a module's `config/install` or `config/optional`. |
| `removeNonRequiredKeys(array $data)` | array | Drops volatile keys before comparison. |

Comparison uses core `StorageComparer` between the module's shipped `FileStorage` and active config. This
is a diagnostic surface only — it never writes config (to re-import shipped config, use
`drush acms:config-reset` from acquia_cms_common).
