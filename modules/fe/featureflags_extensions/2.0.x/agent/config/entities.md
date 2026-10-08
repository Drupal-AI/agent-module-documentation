<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config entities, forms & CRUD

Two config entity types hold the per-flag bindings. Each is keyed by the **feature flag's id** (one binding
entity per flag), and both are edited two ways: standalone admin CRUD, and a per-flag form/tab.

## Config entity types

### `featureflags_routes` — `src/Entity/FeatureflagsExtensionsRoutes.php`
- `config_prefix: featureflags_extensions_routes`, `admin_permission: administer featureflags_extensions_routes`.
- `config_export`: `id`, `routes`. `routes` is a single string (newline-separated route machine names).
  Accessors `getRoutes(): ?string` / `setRoutes(string)`.
- Handlers: `list_builder` = `FeatureflagsExtensionsRoutesListBuilder` (columns: Machine name, Status);
  `add`/`edit` = `FeatureflagsExtensionsRoutesForm`; `delete` = core `EntityDeleteForm`.

### `featureflags_permissions` — `src/Entity/FeatureflagsExtensionsPermissions.php`
- `config_prefix: featureflags_extensions_permissions`,
  `admin_permission: administer featureflags_extensions_permissions`.
- `config_export`: `id`, `permissions`. `permissions` is an array of permission ids.
  Accessors `getPermissions()` / `setPermissions()`.
- Handlers: `list_builder` = `FeatureflagsExtensionsPermissionsListBuilder`; `add`/`edit` =
  `FeatureflagsExtensionsPermissionsForm`; `delete` = core `EntityDeleteForm`.

Config schema for both is in `config/schema/featureflags_extensions.schema.yml` (id, label, uuid, description).

## Standalone CRUD routes (`featureflags_extensions.routing.yml`)

All gated by the matching `administer featureflags_extensions_routes` / `_permissions` permission:
- `entity.featureflags_routes.collection` — `/admin/structure/featureflags-extensions-routes` (list).
- `entity.featureflags_routes.add_form` / `.edit_form` / `.delete_form`.
- The same four for `featureflags_permissions` under `/admin/structure/featureflags-extensions-permissions`.
Add-form action links come from `featureflags_extensions.links.action.yml`. These are standard Entity Form API
forms (POST + core CSRF token; delete is a confirm form). `FeatureflagsExtensionsRoutesForm` /
`...PermissionsForm` expose Label, machine-name id, an Enabled checkbox and Description.

## Per-flag forms (the usual way to set bindings)

`featureflags_extensions.module` wires two extra forms onto every `featureflag` entity:
- `hook_entity_type_alter` sets form classes `routes` = `RoutesForm`, `permissions` = `PermissionsForm`, and link
  templates `routes-form` / `permissions-form` (the flag's edit-form path + `/routes` or `/permissions`).
- `hook_entity_operation` adds **Routes** (weight 20) and **Permissions** (weight 25) operations to each flag.
- Task links (`featureflags_extensions.links.task.yml`) add Edit / Routes / Permissions tabs on the flag edit form.

Routes (`featureflags_extensions.routing.yml`), both gated by the base module's `administer featureflag entities`:
- `entity.featureflag.routes_form` — `/admin/structure/feature-flags/manage/{featureflag}/routes` → `RoutesForm`.
- `entity.featureflag.permissions_form` — `.../permissions` → `PermissionsForm`.

### `RoutesForm` — `src/Form/RoutesForm.php`
Extends `FeatureFlagsExtensionsForm`. `buildForm()` shows one `textarea` (`routes`) pre-filled from the flag's
`featureflags_routes` entity. `submitForm()` calls `setRoutes()` + `save()` and redirects to the flag collection.

### `PermissionsForm` — `src/Form/PermissionsForm.php`
Extends `FeatureFlagsExtensionsForm`; injects `user.permissions`. `buildForm()` renders a `checkboxes` element of
all site permissions (permission ids have `.` replaced with `__` for use as checkbox keys). `submitForm()` saves
the selection into the flag's `featureflags_permissions` entity.

### `FeatureFlagsExtensionsForm` (base) — `src/Form/FeatureFlagsExtensionsForm.php`
Abstract `FormBase`. `getConfigEntity()` reads the `featureflag` route parameter and calls
`featureflags_extensions.service`'s `getExtension($flag, $this->getConfigEntityType(), TRUE)` — loading, or
creating on first save, the binding entity for that flag. Subclasses implement `getConfigEntityType()`
(`featureflags_routes` / `featureflags_permissions`).

## Lifecycle

`featureflags_extensions.module` hooks keep bindings in sync with flags:
`hook_ENTITY_TYPE_insert` / `_update` call the (currently no-op) `_featureflags_extensions_featureflag_upsert()`;
`hook_ENTITY_TYPE_delete` loads and deletes the flag's `featureflags_routes` and `featureflags_permissions`
entities so bindings are removed when the flag is deleted.
