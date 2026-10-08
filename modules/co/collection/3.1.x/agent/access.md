<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions, access control & routing

## Permissions (`collection.permissions.yml` + `CollectionPermissions`)

Static:

| Permission | Effect | `restrict access` |
|---|---|---|
| `administer collections` | Full bypass for collection & collection_item CRUD (it is the `admin_permission` of both content entity types); also configures item `attributes` when `attributes_access = administrators` | yes |
| `administer users in collections` | Manage owners of any collection | yes |
| `access collection overview` | View the `/admin/collections` listing | no |
| `view own collections` | View collections you own (incl. unpublished) | no |
| `edit own collections` | Edit collections you own; add/remove items; also view/revert revisions | no |
| `delete own collections` | Delete collections you own (and revisions) | no |

Dynamic, per collection type (`CollectionPermissions::collectionTypePermissions`, wired via
`permission_callbacks`): `create {type} collection`, `view {type} collection`,
`edit {type} collection` (the last also permits viewing/reverting revisions).

**Ownership is multi-valued.** A collection's `user_id` field is unlimited-cardinality; "own" means
`$account->id()` is in `getOwnerIds()` (`CollectionOwnerTrait::isOwner`), and anonymous (uid 0) is
explicitly excluded.

## `CollectionAccessControlHandler` (governs both `collection` and `collection_item`)

Single handler for both entity types. For a `collection_item`, access is decided against its
**parent collection** (`$entity->collection->entity`) — viewing/editing an item is an operation on
its collection. Logic:

1. `administer collections` → allowed (short-circuit).
2. **view**: (`view own collections` AND owner — includes unpublished) OR
   (`view {type} collection` AND collection published). Else neutral.
3. **update / view+revert revisions**: (`edit own collections` AND owner) OR `edit {type} collection`.
4. **delete / delete revision**:
   - for a `collection_item`, treated as an *edit* of the collection (same rule as update);
   - for a `collection`, only (`delete own collections` AND owner).
5. **create** (`checkCreateAccess`): for `collection`, `create {bundle} collection`; for
   `collection_item`, `edit {bundle} collection` OR (`edit own collections` AND owner of the
   `{collection}` route param).

Default is `AccessResult::neutral()` with an explanatory reason — nothing is granted by omission.
This is a proper, restrictive handler; there is no anonymous view/edit leak by default (a collected
item is reachable only if the viewer already has view access to its collection).

## Custom route access checks (`collection.services.yml`)

- **`_collection_items_access`** → `Access\CollectionItemsAccessCheck::access()`. Guards the Items
  listing (`entity.collection_item.collection`) and any View reusing that path. Requires
  `administer collections`, OR (`edit own collections` AND owner), OR `edit {type} collection`. Only
  works on routes carrying an upcast `{collection}` param (the route subscriber ensures upcasting).
- **`_collection_item_collection_check`** → `Access\CollectionItemCollectionCheck::access()`. A
  consistency guard on the item canonical/edit/delete routes: asserts the upcast `{collection}`
  equals `{collection_item}`'s own `collection` entity, so you cannot address an item via a
  collection it does not belong to.

## Route providers & dynamic routes

- **`CollectionRouteProvider`** (extends `AdminHtmlRouteProvider`): overrides only the collection
  listing route to require `access collection overview` (instead of the `administer collections`
  admin permission).
- **`CollectionItemRouteProvider`**: builds item routes nested under `{collection}`; canonical/edit/
  delete get `_collection_item_collection_check`; the Items listing route (`getCollectionRoute`) gets
  `_collection_items_access`. Add-page uses `CollectionItemController::addPage` (filters bundles to
  those allowed by the collection type and the user has create access to).
- **`collection.routing.yml`**: `collection_item.new`
  (`/collection/{collection}/items/new`, controller `CollectionNew::content`) guarded by
  `_custom_access: CollectionItemsAccessCheck::access` — i.e. edit access to the collection. Also
  registers `route_callbacks` → `CollectionDynamicRoutes::routes`.
- **`CollectionDynamicRoutes`**: for every *content* entity type with a canonical link (except
  `collection_item`), adds `.../collections` (e.g. `/node/{node}/collections`), controller
  `ContentEntityCollectionsController::content`, requirement `_permission: edit own collections`.
  The controller then lists only the collection items referencing that entity **that the current
  user can `view`** (`CollectionContentManager::getCollectionItemsForEntity($entity, 'view')`), so
  it discloses only collections the user already has view access to.
- **`CollectionRouteSubscriber`**: forces the admin theme on `/collection/{collection}/items` and
  ensures the `{collection}` param is upcast on any route containing it (e.g. Views).

## Field-level access (`collection_entity_field_access_alter` in `collection.module`)

- `collection_item.item` (the collected reference) is editable **only while the item is new** — you
  cannot repoint an existing collection item at a different entity.
- `collection_item.attributes` edit access is driven by the item type's `attributes_access`:
  `administrators` → requires `administer collections`; `owners` → requires collection ownership;
  anything else → forbidden.

## Security posture (summary)

Entity queries in user-facing paths use `accessCheck(TRUE)`; the one service that uses
`accessCheck(FALSE)` (`CollectionContentManager::getCollectionItemsForEntity`) re-filters every
result through `$collection_item->access($access)` before returning. Delete/edit flows are standard
FAPI (CSRF-protected); there are no custom GET mutation routes; no raw SQL; titles/labels render
through Twig autoescaping / core formatters. No access-control leak was found in the reviewed
source.
