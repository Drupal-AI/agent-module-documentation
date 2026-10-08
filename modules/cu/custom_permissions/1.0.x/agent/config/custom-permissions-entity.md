<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The custom_permissions config entity & dynamic permission builder

## Install / enable

`drush en custom_permissions -y`. No dependencies, no libraries, no config to import. After
enabling, grant **`administer custom_permissions`** to trusted admin roles (it is not granted by
default). This is a powerful administrative permission — holders can create the permission strings
your site's access model relies on — so treat it like other site-administration permissions.

## The entity type (`src/Entity/CustomPermissions.php`)

`@ConfigEntityType id = "custom_permissions"`, `config_prefix = "custom_permissions"` → config
objects are stored as `custom_permissions.custom_permissions.<id>`. Exported fields
(`config_export`): `id`, `label`, `description`. Also carries core config-entity `status`
(enabled/disabled) and `uuid`. `admin_permission = "administer custom_permissions"`. Handlers:
`list_builder` = `CustomPermissionsListBuilder`; forms `add`/`edit` = `CustomPermissionsForm`,
`delete` = core `EntityDeleteForm`. `CustomPermissionsInterface` is an empty marker extending
`ConfigEntityInterface`.

## Admin UI, routes, permission

Defined in `custom_permissions.routing.yml`; **every** route requires
`_permission: "administer custom_permissions"`:

| Route | Path | Purpose |
|-------|------|---------|
| `entity.custom_permissions.collection` | `/admin/people/custom-permissions` | list (`_entity_list`) |
| `entity.custom_permissions.add_form` | `/admin/people/custom_permissions/add` | add (`_entity_form: custom_permissions.add`) |
| `entity.custom_permissions.edit_form` | `/admin/people/custom-permissions/{custom_permissions}` | edit |
| `entity.custom_permissions.delete_form` | `/admin/people/custom-permissions/{custom_permissions}/delete` | delete confirm |

Links: an action link "Add custom permissions" on the collection
(`custom_permissions.links.action.yml`); a menu link and a local task under *People*
(`links.menu.yml`, `links.task.yml`, both `parent`/`base_route` = `entity.user.collection`).

The entity annotation's `links` reference `/admin/structure/custom-permissions/…`, but the routes
above win, so the working URLs are the `/admin/people/…` ones.

## The form (`src/Form/CustomPermissionsForm.php`)

`EntityForm` with fields:

- `label` — textfield "Title", maxlength 255, required.
- `id` — `machine_name`, `#machine_name.exists` = `CustomPermissions::load` (uniqueness checked
  only against existing custom_permissions entities), disabled once the entity is not new.
- `description` — textarea (optional).
- `status` — "Enabled" checkbox (default = current status).

`save()` writes the entity, adds a status message ("Created new example …" / "Updated example …"),
and redirects to the collection. (The success-message wording says "example" — a leftover from the
scaffolding template; cosmetic only.)

## Dynamic permission builder (`src/PermissionBuilder.php`)

Registered in `custom_permissions.permissions.yml`:

```yaml
administer custom_permissions:
  title: "Administer custom permissions"
permission_callbacks:
  - \Drupal\custom_permissions\PermissionBuilder::buildPermissions
```

`PermissionBuilder implements ContainerInjectionInterface`, injects `entity_type.manager`.
`buildPermissions()`:

1. Loads **all** `custom_permissions` entities (`loadMultiple()`).
2. For each entity where `status()` is TRUE, adds
   `$permissions[$entity->id()] = ['title' => t('Custom Permissions: @entity_label', …),
   'description' => t('@entity_description', …)]`.
3. Returns the array — merged by core's `PermissionHandler` into the site's permission list.

So the **entity machine name becomes the permission machine name**, and the permission is offered
on `/admin/people/permissions` for assignment to roles. **Disabled** entities contribute no
permission (deleting or disabling one removes it from the offer list; core will drop it from any
role that had it on the next permission rebuild). Title and description are passed as `t()`
arguments via `@`-placeholders, so they are HTML-escaped when rendered.

Important behavioural notes for agents:

- Defining a custom permission only creates a *name*. It grants nothing and gates nothing until a
  site builder wires it somewhere (a View's access, a route `_permission`, a menu link) **and** a
  user with core's `administer permissions` assigns it to a role on `/admin/people/permissions`.
  This module does not assign permissions to roles.
- Choose a machine name that does not collide with an existing permission id; the `exists`
  callback only checks other custom_permissions entities, not core/contrib permission strings.

## Config schema (`config/schema/custom_permissions.schema.yml`)

`custom_permissions.custom_permissions.*` → type `config_entity`, mapping: `id` (string),
`label` (label), `uuid` (string), `description` (string). Entities are exportable/importable via
standard configuration management.

## List builder (`src/CustomPermissionsListBuilder.php`)

Columns: Title (`label`), Machine name (`id`), Status ("Enabled"/"Disabled"), plus the default
operations (edit/delete) from `ConfigEntityListBuilder`.
