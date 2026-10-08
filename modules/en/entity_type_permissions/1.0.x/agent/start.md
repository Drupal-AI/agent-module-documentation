<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Type Permissions (entity_type_permissions) — agent index

Generates **per-entity-type / per-bundle access permissions** for content entities and enforces them
via `hook_entity_access()`. A fork of Entity Bundle Permissions with a settings form that selects
which entity types are governed. Depends only on core **`user`**. Core `^8 || ^9 || ^10 || ^11`.
License GPL-2.0-or-later. Version 1.0.3. No config schema, no Drush, no plugin types.

- **Dynamic permission provider + how access is enforced** → [api/access.md](api/access.md)
- **Settings form, config object, route & static permission** → [config/settings.md](config/settings.md)

## What it actually is (from source)

- One service-like class `DynamicPermissions` (`src/DynamicPermissions.php`, `ContainerInjectionInterface`,
  resolved via class resolver). Its `get()` is the `permission_callbacks` entry in
  `entity_type_permissions.permissions.yml` and returns the dynamic permissions.
- One hook, `entity_type_permissions_entity_access()` in `entity_type_permissions.module`, implementing
  `hook_entity_access()`.
- One admin form `Form\SettingsForm` at route `entity_type_permissions.settings_form`
  (`/admin/config/system/entity-type-permissions`), menu link under Configuration → System.
- One static permission `administer entity_type_permissions configuration` gating that form.
- Help text via `entity_type_permissions_help()`.

## Governed entity types

`DynamicPermissions::applies()` / `getApplicableContentEntityTypeDefinitions()` accept only entity
types that are a `ContentEntityTypeInterface`, are **not internal** (`!isInternal()`), and **declare a
bundle entity type** (`getBundleEntityType()`). Of those, only ones selected in
`entity_type_permissions.settings:permissions_filter` actually generate permissions and get checked.

## Permission naming

One permission per bundle: `entity_type_permissions access {entity_type_id} {bundle_id}`, titled
*Access {plural entity-type label} "{bundle label}"*. Details in [api/access.md](api/access.md).
