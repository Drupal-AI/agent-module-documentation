<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Custom Permissions (custom_permissions) — agent index

Defines a **config entity type** (`custom_permissions`) whose enabled instances are each turned
into a **Drupal permission** via a dynamic permission callback. Lets a site builder mint named
permissions from an admin UI instead of a `.permissions.yml` file, then use them in roles, Views,
route `_permission` checks, etc. Package `Custom`. **No dependencies** beyond core. Core
requirement `^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 1.0.1. No Drush, no libraries,
no external services.

- **The entity, its CRUD UI/routes, the dynamic permission builder, config schema, and how to
  operate it** → [config/custom-permissions-entity.md](config/custom-permissions-entity.md)

## What it actually is (from source)

- One config entity type `custom_permissions` (`src/Entity/CustomPermissions.php`,
  `@ConfigEntityType`), `config_prefix = custom_permissions`, exported keys `id`, `label`,
  `description`; `admin_permission = "administer custom_permissions"`. Interface
  `CustomPermissionsInterface` (empty, extends `ConfigEntityInterface`).
- Entity form `Form/CustomPermissionsForm` (add/edit) — fields: label (Title), machine id,
  description (textarea), status (Enabled checkbox). Delete uses core `EntityDeleteForm`.
- List builder `CustomPermissionsListBuilder` — collection table of Title / Machine name / Status.
- **Dynamic permissions**: `PermissionBuilder::buildPermissions()` (wired as a
  `permission_callbacks` entry in `custom_permissions.permissions.yml`) loads all
  `custom_permissions` entities and, for each **enabled** one, returns a permission keyed by the
  entity id with title `Custom Permissions: <label>` and the entity description as the permission
  description. Disabled entities emit nothing.
- Static permission: `administer custom_permissions` (also declared in
  `custom_permissions.permissions.yml`) — gates all module routes.

## Routes & permission (custom_permissions.routing.yml)

All four routes require `_permission: "administer custom_permissions"`:

- `entity.custom_permissions.collection` → `/admin/people/custom-permissions` (`_entity_list`)
- `entity.custom_permissions.add_form` → `/admin/people/custom_permissions/add`
- `entity.custom_permissions.edit_form` → `/admin/people/custom-permissions/{custom_permissions}`
- `entity.custom_permissions.delete_form` → `/admin/people/custom-permissions/{custom_permissions}/delete`

Note: the `links` in the entity annotation point at `/admin/structure/custom-permissions/…`, but
`custom_permissions.routing.yml` defines the real routes under `/admin/people/…`, so the effective
admin path is **`/admin/people/custom-permissions`** (also linked as a task/menu under
*People*). There is no settings form — `configure` is null.

## Config schema

`config/schema/custom_permissions.schema.yml` defines `custom_permissions.custom_permissions.*`
(type `config_entity`) with `id` (string), `label` (label), `uuid` (string), `description`
(string).
