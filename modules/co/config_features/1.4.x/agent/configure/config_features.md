<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The config_feature entity, config object and form

## Entity type

`src/Entity/ConfigFeatureEntity.php` — `@ConfigEntityType(id = "config_feature")`,
`config_prefix = "config_feature"`, `admin_permission = "administer configuration features"`.
Handlers: view builder `ConfigFeatureEntityViewBuilder`, list builder
`ConfigFeatureEntityListBuilder`, forms add/edit `ConfigFeatureEntityForm` and delete
`ConfigFeatureEntityDeleteForm`, HTML route provider `ConfigFeatureEntityHtmlRouteProvider`.

Config object name: `config_features.config_feature.<id>`.

## Config keys (schema `config/schema/config_features.schema.yml`)

| Key | Type | Meaning |
|---|---|---|
| `id` | string | Machine name. |
| `label` | label | Human label. |
| `description` | label | Free text shown on the list page. |
| `weight` | integer | Import/export ordering of features. |
| `status` | boolean | **Active** — when TRUE the feature's configs are pulled out of the main config export and taken from the feature folder on import. |
| `folder` | string | Directory **relative to `site.path`** (e.g. `../config/my_feature`) where the feature's YAML is written/read. Typically a sibling of `config_sync_directory`. |
| `configs_shared` | sequence(string) | Config names to include in the feature. Wildcards (`*`) allowed. Dependencies are pulled in automatically. |
| `configs_excluded` | sequence(string) | Config names to keep out of the feature even if pulled in as a dependency. Wildcards allowed. |

Note the `config_export` list on the entity annotation matches these keys. Some code paths reference
a `storage` key (`folder`/`collection`/`database`) but the form control for it is commented out, so
in 1.4.x the effective storage is always the **folder**.

## Entity form (`src/Form/ConfigFeatureEntityForm.php`)

- Fields: Label, machine `id`, Description, **Folder**, Weight, **Active** checkbox, a
  "Complete Feature" config picker (`complete_picker` multiselect + `complete_text` textarea for
  extra names/wildcards → saved to `configs_shared`), and an "Exclude Feature" picker
  (`exclude_picker` + `exclude_text` → `configs_excluded`).
- The picker offers `configFactory()->listAll()`; the textarea accepts one name per line and is
  sanitised by `filterConfigNames()` — lowercased and stripped to `[a-z0-9_.\-*]` via
  `preg_replace('/[^a-z0-9_\.\-\*]+/', '', …)`.
- `validateForm()` rejects a folder that resolves inside the sync directory
  (`isConflicting()` compares against `Settings::get('config_sync_directory')`).
- `save()` warns if `site.path . '/' . folder` does not yet exist. The widget becomes a `select`
  (instead of `checkboxes`) when `chosen` or `select2_all` is enabled, or when Drupal state
  `config_features_use_select` is set.

## How features are split/merged (`src/ConfigFeaturesManager.php`, `@internal`)

- `getSplitStorage($config)` returns a `FileStorage` at `site.path . '/' . folder`, creating the
  directory (`@mkdir(…, 0777, TRUE)`) and writing a hardening `.htaccess` (`FileSecurity::htaccessLines`)
  if missing.
- `getPreviewStorage()` / `getExportStorage()` use a `DatabaseStorage` on a table named
  `config_feature_preview_<id>` / `config_feature_export_<id>` (table name run through
  `Connection::escapeTable()`).
- `featurePreview()` moves a feature's `configs_shared` (and their dependency closure, via
  `ConfigManager::getConfigEntitiesToChangeOnDependencyRemoval`) out of the transforming storage
  into the feature storage, honouring `configs_excluded`. `mergeFeature()` writes them back on
  import and **rewrites `uuid`** to match the existing/active config so the same object is updated
  across sites rather than recreated.
- Wildcard matching: `inFilterList()` and `ConfigFeatureEntity::configIsExcluded()` build a regex
  from the config-name list with `preg_quote()` and `\*`→`.*`.
