<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Routes, permissions and access control

## Routes (generated, not in routing.yml)

`drupacle.routing.yml` is empty. All routes come from
`DrupacleConnectionHtmlRouteProvider` (`src/DrupacleConnectionHtmlRouteProvider.php`), which extends
core `AdminHtmlRouteProvider`, so the connection admin lives under the admin theme. It overrides two
route requirements; the rest come from core entity defaults:

| Route id | Path | Access requirement |
|---|---|---|
| `entity.drupacle_connection.collection` | `/admin/drupacle/connections` | `_permission: view drupacle connections` (overridden in `getCollectionRoute()`) |
| `entity.drupacle_connection.add_form` | `/admin/drupacle/connection/add` | `_permission: add drupacle connections` (overridden in `getAddFormRoute()`) |
| `entity.drupacle_connection.edit_form` | `/admin/drupacle/connection/{drupacle_connection}/edit` | `_entity_access: drupacle_connection.update` (core default) |
| `entity.drupacle_connection.delete_form` | `/admin/drupacle/connection/{drupacle_connection}/delete` | `_entity_access: drupacle_connection.delete` (core default) |

Menu: `drupacle.links.menu.yml` places the collection under *Configuration* (`system.admin_config`,
weight 99, title "Drupacle"). Action: `drupacle.links.action.yml` adds "Add Oracle DB connection" on
the collection. Delete is a confirm form (POST); there are no state-changing GET routes.

## Permissions (`drupacle.permissions.yml`)

Static permissions:

- `administer drupacle connections` — `restrict access: true`; this is the entity's `admin_permission`.
- `add drupacle connections`
- `delete drupacle connections`
- `edit drupacle connections`
- `view drupacle connections`

A `permission_callbacks` entry also points at
`DrupacleConnectionPermissions::permissions` (`src/DrupacleConnectionPermissions.php`). That method
loops `DrupacleConnection::loadMultiple()` and merges `buildPermissions()`, but `buildPermissions()`
returns `['%connection' => $label]` rather than a proper permission definition, so the dynamic
callback contributes no usable per-connection permission — the effective gating is the five static
permissions above.

## Access control handler

`DrupacleConnectionAccessControlHandler` (`src/DrupacleConnectionAccessControlHandler.php`) extends
`EntityAccessControlHandler`:

- `update` / `clone` → `edit drupacle connections`
- `delete` → `delete drupacle connections`
- everything else → `parent::checkAccess()`, which falls back to the entity's `admin_permission`
  (`administer drupacle connections`).

So edit and delete forms resolve through this handler to the `edit`/`delete` permissions, while the
collection and add-form routes are gated directly by `view` / `add`. All connection-management
surfaces require one of the module's dedicated permissions; none is exposed to anonymous users by
default and there is no `_access: TRUE` route.
