<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entities, routes & access control

## The three entities

- **`association`** (`base_table=association`, `data_table=association_field_data`) — publishable,
  translatable container. Base fields: `uid`, `name` (label), `status` (Active), `created`, `changed`,
  `page` (`association_plugin_settings` — landing-page handler config). Bundle = `association_type`.
  `toUrl('canonical')` is delegated to the landing-page handler's `getPageUrl()`. `preDelete()`
  cascade-deletes all `association_link` rows (access-unchecked query, then storage delete) and calls
  the landing-page handler's `onPreDelete`/`onPostDelete`.
- **`association_link`** (`base_table=association_link`, `internal=TRUE`, `fieldable=FALSE`) — the join
  row. Fields: `association` (ref), `target` (ref, bundle-narrowed to the target entity type via
  `bundleFieldDefinitions`), `entity_type`, `bundle`, `tag`. `AssociationLinkStorageSchema` adds a
  unique key on (`association`,`entity_type`,`target`) and a `target_entity` index. No canonical page
  of its own; `toUrl('canonical')` forwards to the target entity.
- **`association_type`** — config bundle entity (see config/association-types.md).

Member (target) entities get a computed `associations` `EntityReferenceItemList`
(`association_entity_bundle_field_info` in `association.module`, class `AssociationReferenceItemList`)
pointing at their `association_link`, for any type an adapter marks associable.

## Routes (mostly entity-derived, no top-level *.routing.yml)

- `association` routes from `AssociationHtmlRouteProvider`: collection
  `/admin/content/association` (`_permission: access association entity overview page`), add
  `/association/add[/{type}]`, edit/delete, **manage** `/association/{association}/manage` (controller
  `AssociationManagementController::manageContent`, requirement `_association_manage_content_access`).
  The canonical route is intentionally **not** generated (URL is delegated to the landing page).
- `association_link` routes from `AssociationLinkHtmlRouteProvider`: add/edit/delete-content forms
  built by `AssociationLinkController`, each guarded by `_entity_access: association.create_content|
  manage|delete_content` **and** a custom `_create_association_link` check.
- `AssociationRouteSubscriber` (event `RoutingEvents::ALTER`, prio −200) adds a
  `…/association` local-task route for every associable entity's canonical route, guarded by
  `_association_linked_entity_manage_access`.

## How access is enforced

- **Entity access**: `AssociationAccessControlHandler` — admin key bypasses; `view` on an **active**
  association needs `access content`, otherwise falls through to `update`; other ops require the
  per-type permission `{op} association of type {id}`. Field access locks `uid/created/changed` to
  admins and gates `status` behind the `publish` per-type permission.
- **Member entity access**: `association_entity_access` hook → `EntityAdapter::checkAccess()`. If the
  member has an `association_link`: `view` requires the association be viewable (else neutral so the
  entity's own rules apply); `edit/update` require association `manage`; `delete` requires
  `delete_content`; unmatched → forbidden (with cache metadata preserved).
- **Query rewriting**: `association_query_entity_query_alter` + `association_query_views_entity_query_alter`
  (and `association_views_query_alter`, skipped if Group module is on). `EntityAdapter::accessQueryAlter`
  → `AssociatedQueryAlterTrait::buildAccessCondition` LEFT-JOINs the association tables and restricts
  rows to: association types the user may operate on, OR (for `view`) active associations, OR content
  not in any association. Users with the admin key skip the rewrite. All conditions use the DB API's
  parameterized `->condition()`/joins — no string-concatenated SQL.
- **Custom route checkers** (`src/Access/`): `AssociationLinkCreateAccess` (delegates to the behavior's
  `createAccess`), `AssociationManageContentAccess` (OR of manage/create/update), and
  `AssociationLinkedEntityManageAccess` (association `manage` via the negotiator). All fail closed
  (`AccessResult::forbidden()`) when no association resolves.

## Lifecycle hooks (`association.module`)

`hook_entity_update` runs one queue-worker iteration of the entity updaters (batching the rest to
cron) and invalidates member cache tags; `hook_entity_delete` clears the target's links safely;
`hook_user_cancel` unpublishes/reassigns a cancelled user's associations; `hook_module_implements_alter`
forces association's `entity_update` to run last.
