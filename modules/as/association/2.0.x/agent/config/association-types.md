<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Association types, permissions, block & config

## Install / enable

`drush en association` (pulls in `node`, plus contrib `token` and `toolshed`). `hook_install`
(`association.install`) sets the module weight to 10 so its entity hooks run after core's. No global
settings form — configuration is per association type.

## Association types (bundles)

Manage at **Structure → Association types** (`/admin/structure/association`, routes from the
`association_type` config entity). An `association_type` (`src/Entity/AssociationType.php`) exports:
`id`, `label`, `searchable`, `useTaskLabel`, `behavior`, `landingPage`. Its config prefix is
`association.type.*`.

- **`behavior`** and **`landingPage`** are each stored as `{ id: <plugin_id>, config: {...} }`. The
  bundle form (`AssociationTypeForm`) lets you pick and configure them. `getBehavior()` /
  `getLandingPageHandler()` instantiate the plugins; a missing plugin logs and falls back to a
  fallback plugin id where the manager supports it.
- **`searchable`** — when TRUE, association member content is flagged for Search API reindex
  (see `SearchApiUpdater`).
- **`useTaskLabel`** — use the type label (vs. generic "Association") for the local task title.
- **Change-locking**: `AssociationType::validateConfigChanges()` (enforced by
  `ConfigValidationEventSubscriber`) forbids changing the `behavior` or `landingPage` plugin id, and
  forbids removing entity types/bundles from a behavior, **once the type has data**.

Content associations are created/listed at **Content → Associations**
(`/admin/content/association`) and edited at `/association/{association}/…`.

## Config schema

`config/schema/association.schema.yml`, `association.field.schema.yml`, `association.block.schema.yml`.
Optional config in `config/optional/`: a `views.view.association_overview` view, publish/unpublish/delete
system actions, and the `association.block` entity view mode. The `page` base field on `association`
uses field type `association_plugin_settings` with an `AssociationPluginFieldSettings` constraint
(`src/Plugin/Validation/Constraint/`).

## Permissions

Declared in `association.permissions.yml` + `AssociationPermissions::getPermissions` callback:

- `administer entity association configurations` (restricted) and `access entity association overview page`.
- **Per-type generated permissions** — for every `association_type`, one permission per operation:
  `{op} association of type {id}` where `{op}` ∈ `publish, create, update, delete, manage,
  create_content, delete_content` (`AssociationPermissions::getBundleOperations` /
  `getBundlePermissionKey`). These gate the manage UI, the add/edit/delete-content forms, and the
  query-alter access filter.

Note the entity annotations use `admin_permission = "administer association configurations"` (an
internal admin-bypass key); grant the concrete per-type permissions above to roles rather than
relying on the admin key.

## Association display block

`association_block` (`src/Plugin/Block/AssociationBlock.php`, base `AssociationBlockBase`) renders the
**active association** (resolved from block/layout-builder context via `association.negotiator`) in a
configurable `view_mode`, optionally limited to selected `bundles`, and can attach an association menu
when `association_menu` is installed (`menu_display`: none/visible/field). `blockAccess()` returns the
association's `view` access, so the block is only shown to users who may view that association.
