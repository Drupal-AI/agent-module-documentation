<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration Import - Delete Entities (config_import_de) — agent index

info.yml name **"Configuration Import - Delete Entities"**, version **8.x-1.3**, package `Other`,
core `^8 || ^9 || ^10 || ^11`. No dependencies outside core. No Drush, no defined permissions.

**What it does:** during a Drupal **config import**, if the import would delete a *bundle* config
entity (e.g. a `node_type`, `taxonomy_vocabulary`, comment type, media type) that still has content,
core normally **blocks the whole import** until you manually delete that content. This module
overrides the core validator so it can instead **automatically delete the orphaned content
entities** and let the import proceed. Intended for automated deploys / CI (Jenkins) and
branch-switching where a bundle exists on one branch but not another.

## How it works (from source)

- **Service override** — `src/ConfigImportDeServiceProvider.php` (`ServiceProviderBase::alter`)
  replaces the class of core service **`entity.bundle_config_import_validator`** with
  `Drupal\config_import_de\Event\ConfigImportDeBundleConfigImportValidate`, and injects two extra
  args: `messenger` and `config.factory`. So the module hooks core's existing config-import
  validation event — it adds **no new route or trigger** for importing config.
- **Validator** — `src/Event/ConfigImportDeBundleConfigImportValidate.php` extends core
  `BundleConfigImportValidate` and overrides `onConfigImporterValidate(ConfigImporterEvent $event)`:
  - Reads config object **`config_import_de.config`**: `delete_detected_entities` (default `TRUE`)
    and `debug_mode` (default `FALSE`).
  - If **both are disabled**, it defers to `parent::onConfigImporterValidate()` (core behavior:
    log an error and block the import).
  - Otherwise it walks `$event->getChangelist('delete')`. For each config name that is a config
    entity defining a bundle of another entity type (`$entity_type->getBundleOf()`), it derives the
    bundle id (`ConfigEntityStorage::getIDFromConfigName`) and runs an **entity query**
    (`->condition(bundle_key, $bundle_id)->accessCheck(FALSE)`) for content of that bundle.
  - For each found entity: if `delete_detected_entities` is on it calls **`$entity->delete()`**;
    with `debug_mode` also on it adds a messenger warning naming the deleted `type / id`. If
    deletion is off but `debug_mode` is on, it `logError()`s the entity type/id plus a link to its
    `delete-form` (import still blocked).
- **Settings form** — `src/Form/ConfigImportDeSettingsForm.php` (`config_import_de_settings_form`,
  a `ConfigFormBase`) at route **`config_import_de.settings`** → path
  `/admin/config/development/config_import_de` (menu link under *Development*). Two checkboxes,
  `Delete detected entities` and `Debug mode`, saved into `config_import_de.config`. Route
  requirement: core permission **`import configuration`**. Same route is the info.yml `configure`
  link.
- **Config** — `config/install/config_import_de.config.yml` ships defaults
  (`delete_detected_entities: true`, `debug_mode: false`); `config/schema/config_import_de.schema.yml`
  types both booleans. `config_import_de.module` only implements `hook_help`.

## Key facts

- Deletion happens **only inside a config import** (core's already-`import configuration`-gated
  flow); the module exposes no separate delete/import endpoint.
- It targets **content of a bundle being deleted** — not arbitrary config. The entity query uses
  `accessCheck(FALSE)` so it finds/deletes all content of that bundle regardless of per-entity
  access (appropriate for a deploy-time operation, but see the caution below).
- **Default is delete-on (`delete_detected_entities: true`).** Once enabled, the next import that
  removes a content-bearing bundle will delete that bundle's content. Deletion is **irreversible**;
  use `debug_mode` and backups to preview/guard before a production import.
- Debug messages use `t()` placeholders and `Url::toString()`; the `delete-form` URL is generated
  from the entity, not from request input.

Single-file index: the module is small (one overridden validator + one settings form) so no subdocs
are warranted. Human-oriented walkthrough: [../human-docs/index.md](../human-docs/index.md).
