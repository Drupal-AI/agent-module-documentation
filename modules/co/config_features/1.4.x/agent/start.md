<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config Features (config_features) — agent index

Packages a **named set of configuration** (a "feature") into its own storage so it can be
**exported from one Drupal site and imported into another**, reconciling the per-site **UUID
differences** so matching config is *updated* rather than duplicated. A code-level fork of
**Config Split** (same split/merge engine, config-transform event subscriber, and admin routes),
repurposed for cross-site config sharing. info.yml name **"Config Features"**, version **1.4.1**,
package **Config**, core `^9.4 || ^10 || ^11`, no module dependencies, `security_advisory_coverage:
not-covered`.

- **The `config_feature` config entity, its config object/schema, and the entity form** →
  [configure/config_features.md](configure/config_features.md)
- **Operations (activate/deactivate/import/export/diff, batch download), routes, controllers, the
  manager, the config-transform subscriber** → [operations/config_features.md](operations/config_features.md)
- **Permissions** → [permissions/config_features.md](permissions/config_features.md)

## What it actually is (from source)

- One config entity type **`config_feature`** (`src/Entity/ConfigFeatureEntity.php`,
  `config_prefix: config_feature`, `admin_permission: administer configuration features`). Each
  feature stores: `id`, `label`, `description`, `weight`, `status`, `folder`, `configs_shared`,
  `configs_excluded` (schema `config_features.config_feature.*` in
  `config/schema/config_features.schema.yml`).
- Admin UI under **Config → Development → Configuration** at
  `/admin/config/development/configuration/config-feature` (collection route
  `entity.config_feature.collection`, list builder `ConfigFeatureEntityListBuilder`).
- A **config transform** event subscriber (`EventSubscriber/ConfigSubscriber.php`) hooks
  `STORAGE_TRANSFORM_EXPORT`/`STORAGE_TRANSFORM_IMPORT`: on export it *removes* an active feature's
  configs from the main export and writes them to the feature's folder; on import it *merges* them
  back. The heavy lifting is in `ConfigFeaturesManager` (service `config_features.manager`).
- A `.module` `hook_form_config_export_form_alter` adds an **"Export in batch"** button to the core
  config export screen and (when `config_batch_export` is present) hides its batch button;
  `hook_file_download` serves the generated private tarballs.

## Provides

- **Entity type:** `config_feature` (config entity).
- **Service:** `config_features.manager` (`ConfigFeaturesManager`, marked `@internal`); event
  subscriber `config_features.config_event_subscriber`.
- **Permission:** `administer configuration features` (`restrict access: true`). Download routes
  additionally require the core **`export configuration`** permission.
- **Config schema** for the feature entity. **No** Drush commands, **no** plugin types, **no**
  hook_install/schema.

## Not to be confused with

Despite the name, this is **not** the classic *Features* module (`features`) and shares no code with
it. It is Config Split's mechanism (folders of split config + UUID handling) branded as
"features" for moving config between sites.
