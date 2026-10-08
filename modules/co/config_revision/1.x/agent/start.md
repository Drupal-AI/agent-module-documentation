<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config Revision (config_revision) — agent index

Adds a **revision history (diff + revert) to configuration entities**. Package `Configuration`.
Depends only on core **`system`** (dev/test also pulls `webform`). Core `^10 || ^11`, PHP `8.1`,
license GPL-2.0-or-later. Version `1.x` (installed release `1.0.0-beta1`). Not covered by a security
advisory policy.

- **Enable, the settings form, opting config types in, how a revision is captured, view/revert
  routes and permissions** → [config/settings.md](config/settings.md)
- **The entities, storage, forms, route providers, hooks and services it defines** →
  [api/entities.md](api/entities.md)

## What it actually is (from source)

- One **content entity** `config_revision` (`src/Entity/ConfigRevision.php`,
  `EditorialContentEntityBase`): revisionable, publishable, owned, non-translatable. Base fields
  `name` (the target config id), `config` (a `map` holding the raw config array), `changed`, plus
  revision-log metadata. Base table `config_revision`, revision table `config_revision_revision`.
- One **config entity** `config_revision_type` (`src/Entity/ConfigRevisionType.php`,
  `ConfigEntityBundleBase`): the bundle of `config_revision`; one bundle per opted-in config entity
  type. `config_prefix = type`.
- **Hooks** (`config_revision.module` → `src/EntityHooks.php`): `hook_entity_insert`/`_update`
  create/clone a `config_revision` and save a new revision for any `ConfigEntityInterface` whose
  type is opted in; `hook_entity_delete` removes the revision record.
- **Settings form** `AdminSettingsForm` at route `config_revision.settings`
  (`/admin/config/development/config-revision`, permission `administer config_revision`), config
  object `config_revision.settings` (key `enabled_entity_types`).
- **Route providers** `RouteProvider` (collection/CRUD) and `RevisionRouteProvider`
  (version-history/view/revert) add the entity's HTML + revision routes; **revert** uses
  `src/Form/RevisionRevertForm.php` (confirm form with a YAML diff table).
- **Permissions** (`config_revision.permissions.yml`): `administer config_revision type`,
  `administer config_revision`, `view config_revision`.
- **Service**: logger channel `logger.channel.config_revision`. **Views data** via
  `src/ViewsData.php`. **List builder** `src/ListBuilder.php`. No plugins, no Drush commands.

## Depends on

- Core `system` only. The revision UI is documented to need core patch #2350939 to work fully.
- `diff.formatter` (core Diff) is used by the revert form to render the change preview.
