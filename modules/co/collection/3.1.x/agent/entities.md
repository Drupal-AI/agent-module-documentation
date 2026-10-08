<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity model, fields, bundles & constraints

## `collection` (content entity — `src/Entity/Collection.php`)

`@ContentEntityType(id = "collection")`, extends `EditorialContentEntityBase`. Revisionable
(`show_revision_ui = TRUE`), translatable, `admin_permission = "administer collections"`,
`bundle_entity_type = "collection_type"`. Moderation handler
`Entity\Handler\CollectionModerationHandler` (Content Moderation aware).

Entity keys: `id = cid`, `revision = vid`, `bundle = type`, `label = name`, `uid = user_id`,
`published = status`, `langcode`, `uuid`.

Base fields (`baseFieldDefinitions()`):

| field | type | notes |
|---|---|---|
| `user_id` | entity_reference → user, **cardinality unlimited** | **Owners** — a collection can have many owners; drives owner-scoped access |
| `name` | string(50), required, translatable | the label |
| `path` | path, computed | URL alias |
| `collectible` | boolean, default FALSE | if TRUE the collection itself may be added to other collections |
| `status` | (inherited) published flag | |
| `created` / `changed` | created/changed | |

Links: canonical `/collection/{collection}`, add-page `/collection/add`, add-form
`/collection/add/{collection_type}`, edit `/collection/{collection}/edit`, delete, admin listing
`/admin/collections`, plus revision routes. `field_ui_base_route = entity.collection_type.edit_form`.

Behaviour:
- `preCreate()` sets `user_id` to the current user (so the creator is the first owner).
- `save()` dispatches `CollectionCreateEvent` / `CollectionUpdateEvent`.
- `postDelete()` **cascades**: deletes all `collection_item` entities belonging to the deleted
  collection.
- Helper API on the entity: `getItems()`, `getItem($entity)`, `findItems($type)`,
  `findItemsByAttribute($k,$v)`, `addItem($entity)` (dedupes, picks a matching item bundle or
  `default`), `removeItem($entity)`, `getOwnerIds()`. All the query helpers use
  `->accessCheck(TRUE)`.

## `collection_item` (content entity — `src/Entity/CollectionItem.php`)

`@ContentEntityType(id = "collection_item")`, `ContentEntityBase`, translatable,
`admin_permission = "administer collections"`, `bundle_entity_type = "collection_item_type"`.
Class-level `constraints = {UniqueItem, SingleCanonicalItem, PreventSelf, PreventUncollectible}`.

Entity keys: `id`, `bundle = type`, `label = name`, `uid = user_id`, `langcode`, `uuid`
(no revision, no published key).

Base fields:

| field | type | notes |
|---|---|---|
| `collection` | entity_reference → collection, required, cardinality 1 | default from route `{collection}` param (`getCollectionParam()`) |
| `item` | **dynamic_entity_reference**, required, cardinality 1 | the collected entity; default allows `node`, extended per item-type by `collection_entity_bundle_field_info()` |
| `user_id` | entity_reference → user | owner of the item |
| `name` | string(255), required | **auto-set to the collected entity's label** in `preSave()`; form-hidden |
| `attributes` | `key_value` (from key_value_field), unlimited, translatable | arbitrary key/value metadata; edit access gated by item-type `attributes_access` |
| `weight` | integer (signed) | ordering within a collection |
| `canonical` | boolean, default FALSE | marks the primary/home collection for the item |

Links live *under* the collection: canonical `/collection/{collection}/items/{collection_item}`,
add-page/add-form under `/collection/{collection}/items/...`, edit, delete, delete-multiple, and
`collection` (the Items tab) `/collection/{collection}/items`. `urlRouteParameters()` injects the
`collection` param from the item's `collection` reference.

Behaviour:
- `preSave()` throws `\LogicException('Collection already has this entity.')` if the target is
  already in the collection (new items only), and syncs `name` to the collected label.
- `save()` dispatches create/update events; `postSave()`/`postDelete()` invalidate the collection's
  and the collected item's cache tags; `postDelete()` dispatches `CollectionItemDeleteEvent`.
- Attribute helpers: `getAttribute`, `setAttribute`, `removeAttribute`, `isCanonical`.

### Validation constraints (`src/Plugin/Validation/Constraint/`)

- **UniqueItem** — an entity may appear only once per collection.
- **SingleCanonicalItem** — at most one canonical collection item per collected entity.
- **PreventSelf** — a collection item cannot collect its own collection.
- **PreventUncollectible** — a collection can only be collected if its `collectible` flag is TRUE.

These are data-integrity guards (each has a matching `*Validator`).

## `collection_type` (config bundle — `src/Entity/CollectionType.php`)

`@ConfigEntityType`, `ConfigEntityBundleBase`, `bundle_of = collection`,
**`admin_permission = "administer site configuration"`**, routes under
`/admin/structure/collection`. Config export: `id`, `label`, `allowed_collection_item_types`.
`getAllowedCollectionItemTypes($entity_type_id, $bundle)` resolves which item types apply to a given
collected entity, and invokes `hook_collection_item_types_allowed_alter()`.
`getAllowedEntityBundles()` returns the reverse map.

## `collection_item_type` (config bundle — `src/Entity/CollectionItemType.php`)

`@ConfigEntityType`, `bundle_of = collection_item`,
**`admin_permission = "administer site configuration"`**, routes under
`/admin/structure/collection_item`. Config export: `id`, `label`, `allowed_bundles`
(`entity_type.bundle` strings), `attributes_access` (`administrators` | `owners` | anything else →
forbidden; consumed by `collection_entity_field_access_alter()`). `postSave()` on a *new* type
disables the `item` component in the `mini` form display (used by the inline-entity-form embed).

> Note: managing the **types** (config bundles) requires `administer site configuration`, whereas
> `administer collections` governs CRUD on the **content** collection/collection_item entities. Older
> README wording implies `administer collections` covers type management — the code gates types on
> `administer site configuration`.

## Shipped config (`config/install/`)

- `collection.collection_item_type.default` — the `default` collection item type.
- `core.entity_form_mode.collection_item.mini` — the `mini` form mode.
- `system.action.collection_item_delete_action` — bulk delete action.
- `config/optional/views.view.collection_items` — optional Views listing.
- `config/schema/collection.schema.yml` — schema for both config bundle types + two views fields.

## Install/update hooks (`collection.install`)

`collection_update_8001/8002/8003` (weight, canonical, longer name fields on collection_item),
`collection_update_9001` (collectible field on collection). No `hook_install`/`hook_schema` beyond
entity storage.
