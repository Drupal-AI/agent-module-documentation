<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings entity, settings form and installer service

## The "main field" config entity — `entity_version_settings`

`src/Entity/EntityVersionSettings.php` — `@ConfigEntityType(id = "entity_version_settings")`,
`config_prefix => "settings"` (so config objects are named **`entity_version.settings.{id}`**).

- **Exported keys** (`config_export`): `id`, `target_entity_type_id`, `target_bundle`,
  `target_field`. Schema: `entity_version.settings.*.*` in `config/schema/entity_version.schema.yml`.
- **Id** is computed as `{target_entity_type_id}.{target_bundle}` (`id()` / `preSave()`), so there is
  exactly one settings entity per entity-type + bundle.
- The constructor throws `\InvalidArgumentException` if `target_entity_type_id` or `target_bundle` is
  empty.
- `calculateDependencies()` adds a config dependency on the bundle and, when `target_field` is a
  `FieldConfigInterface`, on that field config too.
- Purpose: it records which version field is the **"main"** one for a bundle. The sub-modules
  (`entity_version_history`, `entity_version_workflows`) read `getTargetField()` from this entity to
  know which field to display history for / bump on transitions. A bundle with a version field but
  **no** settings entity is ignored by the sub-modules.

### Storage handler — `EntityVersionSettingsStorage`

`src/Entity/EntityVersionSettingsStorage.php`. On `doPostSave()` (outside installation) it calls
`entityTypeManager->clearCachedDefinitions()` and `routeBuilder->rebuild()` — required because the
history/workflows modules derive link templates and routes from these configs, so a new/changed
mapping must rebuild routes immediately.

## The settings form — `EntityVersionSettingsForm`

`src/Form/EntityVersionSettingsForm.php`, form id `entity_version_settings_form`.

- **Route** `entity_version.settings` → **`/admin/config/entity-version/settings`**, permission
  **`administer entity version`** (`entity_version.routing.yml`). A parent menu route
  `entity_version.index` → `/admin/config/entity-version` requires `access administration pages`.
  Menu links in `entity_version.links.menu.yml` place both under *Configuration*.
- `buildForm()` uses `entity_field.manager->getFieldMapByFieldType('entity_version')` to list every
  entity type + bundle that has at least one version field. It renders: a top-level entity-type
  checkboxes group, per-entity-type bundle checkboxes, and per-bundle a **select of the version
  fields** in that bundle (`#description` "Select a main Version field for this bundle."). When a
  bundle has only **one** version field the select is `#disabled` and pre-set to it.
- `submitForm()` reconciles the form values against existing `entity_version_settings` config:
  unchecking an entity type deletes all its settings; unchecking a bundle deletes that bundle's
  settings; a checked bundle with a chosen field creates or updates the settings entity's
  `target_field`. Status messages are shown via the messenger.

## Programmatic install — `EntityVersionInstaller`

Service **`entity_version.entity_version_installer`** (`src/EntityVersionInstaller.php`,
interface `EntityVersionInstallerInterface`), constructed with the entity type manager.

```php
public function install(string $entity_type = 'node', array $bundles = [], array $default_value = []): void
```

- Creates a **field storage** named `version` (`field_name => 'version'`, `type => entity_version`)
  for `$entity_type` if one does not already exist.
- For each bundle in `$bundles`, creates a field config (`field_name => 'version'`, `label =>
  'Version'`, `cardinality => 1`, `translatable => FALSE`, `default_value => [$default_value]` when a
  default is passed) unless it already exists.

It creates the **field** only; it does **not** create the `entity_version_settings` "main field"
mapping — configure that via the settings form (or create the config entity yourself) so the
sub-modules act on the field.

## Permission, hooks and uninstall

- **Permission** `administer entity version` (`entity_version.permissions.yml`); it is also the
  `admin_permission` of the `entity_version_settings` config entity type.
- **`hook_uninstall`** (`entity_version.install`) loads and **deletes every**
  `entity_version_settings` entity.
- Update **`entity_version_update_8101`** installs the `entity_version_settings` config entity type
  if the definition update manager reports it as newly created (idempotent — bails out otherwise).

## Config example (`entity_version.settings.node.article`)

```yaml
langcode: en
status: true
id: node.article
target_entity_type_id: node
target_bundle: article
target_field: field_version
```
