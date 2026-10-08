<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Collection (collection) — agent index

Groups **content and configuration entities** into named, fieldable, revisionable **Collection**
entities via join objects called **Collection items**. A single entity (e.g. a node, or even a
config entity like a menu) can belong to several collections at once, with one marked *canonical*
(primary), and items can be weighted/ordered within a collection. Comparable to the Group module
but without per-collection roles/permissions, and it can collect *configuration* entities too.
Version **3.1.0**. Core `^9.4 || ^10 || ^11`. Package `Collection`. License GPL-2.0-or-later.

## Dependencies (from `collection.info.yml`)

- `dynamic_entity_reference` — the `item` field on collection items is a DER (a collected item can
  be any entity type).
- `drupal:path` (core) — collections have a `path` (URL alias) base field.
- `inline_entity_form` — collection-item forms are embedded inline on the host entity's edit form.
- `key_value_field` — the collection-item `attributes` field.
- README also mentions a core patch (issue 2901412) for full functionality; not required to install.

## The four entity types (from `src/Entity/`)

| Entity type | Kind | Bundle entity | Notes |
|---|---|---|---|
| `collection` | content, editorial (revisionable, translatable, moderatable) | `collection_type` | base fields: `name`, `user_id` (multi-value **Owners**), `path`, `collectible`, `status`, revision/created/changed |
| `collection_item` | content (translatable) | `collection_item_type` | fields: `collection` (ref), `item` (DER, the collected entity), `user_id`, `name` (auto = collected label), `attributes` (key_value), `weight`, `canonical` |
| `collection_type` | config bundle | — | `admin_permission = administer site configuration`; config: `allowed_collection_item_types` |
| `collection_item_type` | config bundle | — | config: `allowed_bundles` (`entity_type.bundle`), `attributes_access` |

Ships one default `collection_item_type.default`, a `mini` entity form mode for collection items,
a `collection_item_delete_action`, and an optional `views.view.collection_items`.

## Access & permissions (from `collection.permissions.yml` + `CollectionAccessControlHandler`)

Static perms: `administer collections` (admin bypass for collection/item CRUD — `restrict access`),
`administer users in collections` (`restrict access`), `access collection overview`,
`view own collections`, `edit own collections`, `delete own collections`. Dynamic per-type perms
(`CollectionPermissions`): `create/view/edit {type} collection`. Collections support **multiple
owners**; "own" access is `in_array(uid, getOwnerIds())`. See [agent/access.md](access.md) for the
full model — the access surface is sound (see that doc).

## What else it provides (from source)

- **Custom route access checks**: `_collection_items_access` (`CollectionItemsAccessCheck`),
  `_collection_item_collection_check` (`CollectionItemCollectionCheck` — asserts the `{collection}`
  and `{collection_item}` route params match).
- **Route providers**: `CollectionRouteProvider`, `CollectionItemRouteProvider`; a
  `route_callbacks` dynamic route (`collection_item.new`) and `CollectionDynamicRoutes` which adds a
  `.../collections` tab to every content entity with a canonical link (gated `edit own collections`).
- **Block** `user_collections_block` (collections a route's user can update).
- **Views**: access plugin `collection_items_access`, argument-default `collection`, and several
  collection-item field plugins.
- **Events** (`CollectionEvents`): collection & collection-item create/update/delete;
  **hook** `hook_collection_item_types_allowed_alter()` (`collection.api.php`).
- **IEF integration** (`CollectionContentEntityFormAlter`): embeds collection-item add/edit forms on
  host entity (e.g. node) forms via the `ief_collection_items` pseudo-field.

## Submodules (documented separately)

- **collection_listings** (experimental; requires `paragraphs`) → paragraph behavior that renders a
  filtered listing of a collection's items. Docs: [modules/collection_listings/3.1.x/](../../../modules/collection_listings/3.1.x/agent/start.md)
- **collection_pathauto** (requires `pathauto`) → prepends the canonical collection's URL alias to a
  collected entity's Pathauto alias. Docs: [modules/collection_pathauto/3.1.x/](../../../modules/collection_pathauto/3.1.x/agent/start.md)

## Solution docs

- **Entity model, fields, bundles, validation constraints, config** → [entities.md](entities.md)
- **Permissions, access control handler, custom access checks, routes** → [access.md](access.md)
- **Services, events, hooks, IEF form integration, block, Views** → [integration.md](integration.md)
