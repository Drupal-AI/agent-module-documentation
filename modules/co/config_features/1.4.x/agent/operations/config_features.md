<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Operations, routes and controllers

All routes live under `/admin/config/development/configuration/config-feature`. Defined in
`config_features.routing.yml` plus the entity's HTML route provider
(`ConfigFeatureEntityHtmlRouteProvider`, giving collection/canonical/add/edit/delete).

## Route map

| Route | Path suffix | Handler | Access requirement |
|---|---|---|---|
| `entity.config_feature.collection` | `/config-feature` | `ConfigFeatureEntityListBuilder` | `administer configuration features` |
| `entity.config_feature.enable` | `/{f}/enable` | `ConfigFeatureController::enableEntity` | `administer configuration features` |
| `entity.config_feature.disable` | `/{f}/disable` | `ConfigFeatureController::disableEntity` | `administer configuration features` |
| `entity.config_feature.activate` | `/{f}/activate` | `ConfigFeatureActivateForm` (form) | `_custom_access` → perm + `!status` |
| `entity.config_feature.deactivate` | `/{f}/deactivate` | `ConfigFeatureDeactivateForm` (form) | `_custom_access` → perm + `status` |
| `entity.config_feature.import` | `/{f}/import` | `ConfigFeatureImportForm` (form) | `_custom_access` → perm + (`status` or collection storage) |
| `entity.config_feature.export` | `/{f}/export` | `ConfigFeatureExportForm` (form) | `_custom_access` → perm + `status` |
| `config_features.diff` / `.diff_collection` | `/{f}/{op}/diff/…` | `ConfigFeatureDiffController::diff` | `administer configuration features` |
| `config_features.export_download` | `/{f}/export-download-batch` | `ConfigBatchExportController::downloadExport` | `export configuration` |
| `config_features.export_download_file` | `/{f}/export-download-batch/{file}` | `ConfigBatchExportController::downloadExportFile` | `export configuration` |
| `config_features.export_download_full` | `/full/export-download-batch-full` | `ConfigBatchExportFullController::downloadExport` | `export configuration` |
| `config_features.export_download_full_file` | `/full/export-download-batch-full/{file}` | `ConfigBatchExportFullController::downloadExportFile` | `export configuration` |

Every `_custom_access` callback (`::access(AccountInterface $account)` on the four forms) is
`AccessResult::allowedIfHasPermission($account, 'administer configuration features')` **and-ed** with
a status condition, then cached on the feature. So the four config-changing forms are gated by the
same restricted permission as the rest of the UI.

## The operations

- **Enable / Disable** (`ConfigFeatureController`): flip only the feature entity's `status` boolean
  and save; they do **not** themselves import config. Redirect back to the collection.
- **Import** (`ConfigFeatureImportForm` + `ConfigImportFormTrait`): builds a `StorageComparer`
  between `manager->singleImport($feature, …)` and the active storage, shows the changelist with
  per-item **"View differences"** links (`config_features.diff`), and on submit runs a core
  `ConfigImporter` batch (`launchImport()`) — this writes the feature's config into the active
  configuration.
- **Activate** (`ConfigFeatureActivateForm`): like import but from `singleActivate()` and it also
  turns the feature on.
- **Deactivate** (`ConfigFeatureDeactivateForm`): `singleDeactivate()` removes the feature's config
  from active storage (optionally exporting it first) and sets `status=FALSE` in the imported
  transformation.
- **Export** (`ConfigFeatureExportForm`): shows the diff between the preview and the folder target
  and offers a **Download** link to the batch export; there is no direct submit.
- **Diff** (`ConfigFeatureDiffController::diff`): renders a two-way config diff for a given
  `{operation}` (`activate`/`deactivate`/`import`/`export`) and `{source_name}`/`{target_name}`;
  unknown operation or missing feature → redirect to `system.404`.

## Batch export / download

- `ConfigBatchExportController` (per-feature) and `ConfigBatchExportFullController` (whole site,
  reachable via the "Export in batch" button injected into the core config export form by
  `_config_full_batch_export_export_button_callback`) both extend core `ConfigController`.
- They build a `.tar` (gzipped to `.tar.gz` when `zlib` is loaded) of config YAML into a **private**
  managed file (`private://config-feature--<id>.tar.gz` or `private://configs.tar.gz`), using a
  persistent lock (`lock.persistent`, IDs `config_feature_batch_export_download` /
  `config_batch_export_full_download`, 600s) so two runs can't collide; `isLocked()` disables the
  button and makes `downloadExportFile()` throw `AccessDeniedHttpException`.
- `hook_file_download()` in `.module` sets the `Content-disposition` and only serves the private
  file when the current user has **`export configuration`** and the target filename starts with
  `config-feature--` or equals `configs.tar.gz`. Downloaded files are aged out via file cron
  (`setChangedTime(1)`).

## Config-transform integration

`ConfigSubscriber` subscribes to `ConfigEvents::STORAGE_TRANSFORM_EXPORT` and
`STORAGE_TRANSFORM_IMPORT`, iterating all features by `weight` and delegating to
`ConfigFeaturesManager::exportTransform()` / `importTransform()`. This is what makes an active
feature's config leave the normal `drush config:export` output and be read back from its folder on
`drush config:import`.
