<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Edit UUID

Exposes an entity's `uuid` field on its entity edit form (as a text field) for
admin-configured entity types and bundles, so a permitted user can view or set a
custom UUID. Used to align UUIDs across environments for content staging /
deployment / JSON:API. Also ships a `uuid` field formatter to print the UUID on
an entity's view display.

- Core only: `core_version_requirement: ^10 || ^11`, PHP `>=8.1`. No module dependencies.
- Configure route: `entity.edit_uuid_config.collection` → `/admin/config/development/edit-uuid-config`
  (a config-entity list; add one `edit_uuid_config` per entity-type + bundle set).
- Defines 3 permissions, a `edit_uuid_config` config entity, one field formatter plugin
  (`edit_uuid`). Provides config schema. No drush commands, no plugin types.

## Solution docs
- **Choose which entity types/bundles expose the UUID field** → [configure/settings.md](configure/settings.md)
- **Who can see vs. edit the UUID (permissions)** → [permissions/permissions.md](permissions/permissions.md)
- **How the UUID field appears on entity forms and is validated** → [hooks/form-alter.md](hooks/form-alter.md)
- **Show the UUID on an entity's view display** → [fields/formatter.md](fields/formatter.md)

## Key facts
- Config entity type: `edit_uuid_config`, `config_prefix: form` → config objects named `edit_uuid_config.form.<id>`.
- Config keys (config_export): `id`, `label`, `config_key` (entity type id), `config_value` (array of bundle ids), `config_type` (bool; TRUE = show only, disable editing).
- Config entity accessors: `configKey()`, `configValue()`, `configType()` (class `Drupal\edit_uuid\Entity\EditUuidConfig`).
- Permissions: `administer edit_uuid_config configuration`, `show edit_uuid`, `edit edit_uuid`.
- Routes: `entity.edit_uuid_config.collection`, `edit_uuid_config.add`, `entity.edit_uuid_config.edit_form`, `entity.edit_uuid_config.delete_form`.
- Hooks (in `edit_uuid.module`): `hook_form_alter` (injects `$form['uuid']`), `hook_entity_base_field_info_alter` (makes `uuid` view-display-configurable), `hook_help`.
- Form validate callback: `edit_uuid_form_validate`.
- Field formatter plugin id: `edit_uuid` (label "UUID", field type `uuid`).
