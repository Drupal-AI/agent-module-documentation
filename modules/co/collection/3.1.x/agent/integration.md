<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Services, events, hooks & form integration

## Services (`collection.services.yml`)

| Service | Class | Purpose |
|---|---|---|
| `collection_item.collection.access_checker` | `Access\CollectionItemsAccessCheck` | tags `_collection_items_access` route check |
| `collection_item.collection.check` | `Access\CollectionItemCollectionCheck` | tags `_collection_item_collection_check` route check |
| `collection.collection_route_context` | `ContextProvider\CollectionRouteContext` | context provider exposing the `{collection}` of the current route (for blocks/layouts) |
| `collection.content_entity_form.alter` | `CollectionContentEntityFormAlter` | embeds collection-item IEF sub-forms on host entity forms |
| `collection.content_manager` | `CollectionContentManager` | query helpers: `getCollectionsForEntity`, `getCollectionItemsForEntity`, `getAvailableCollections` (each takes an `$access` op or FALSE) |
| `collection.route_subscriber` | `Routing\CollectionRouteSubscriber` | route alterations (admin theme + `{collection}` upcasting) |

## Events (`src/Event/`, constants in `CollectionEvents`)

Dispatched from `Collection::save()` / `CollectionItem::save()` / `postDelete()`:

- `collection.entity.create` → `CollectionCreateEvent`
- `collection.entity.update` → `CollectionUpdateEvent`
- `collection_item.entity.create` → `CollectionItemCreateEvent`
- `collection_item.entity.update` → `CollectionItemUpdateEvent`
- `collection_item.entity.delete` → `CollectionItemDeleteEvent`

Each event object exposes the relevant entity (`->collection` / `->collectionItem`). The
collection_pathauto submodule subscribes to the three item events.

## Hooks

- **Provided** (`collection.api.php`): `hook_collection_item_types_allowed_alter(&$allowed_types,
  $collection_type_id, $entity_type_id, $bundle)` — reorder/remove the candidate item types when an
  entity/bundle is allowed by more than one item type (the first survivor is used for auto-created
  items).
- **Implemented** (`collection.module`):
  - `hook_entity_bundle_field_info` — per collection-item-type, rewrites the DER `item` field's
    `entity_type_ids` / `target_bundles` from the type's `allowed_bundles` config.
  - `hook_entity_update` — when a collected entity's label changes, re-saves its collection items so
    their auto `name` follows.
  - `hook_entity_predelete` — deletes collection items referencing a deleted entity (mirror of the
    collection's own cascade delete).
  - `hook_entity_extra_field_info` / `hook_form_alter` — the IEF integration (below).
  - `hook_entity_field_access_alter` — see [access.md](access.md#field-level-access).
  - `hook_entity_operation` / `_alter` — adds "Items", "Edit content", "Remove from collection"
    operation links.
  - `collection_form_node_form_alter` + preview submit handlers — preserve the `?collection=` query
    param across node preview.
  - `hook_theme`, `hook_theme_suggestions_collection`, `hook_toolbar_alter`.

## Inline-entity-form integration (`CollectionContentEntityFormAlter`)

Adds a pseudo-field `ief_collection_items` (via `hook_entity_extra_field_info`) to every
entity_type/bundle allowed by some collection item type. On the host entity form
(`hook_form_alter` → `alterForm`):

- **New host entity + `?collection=<cid>` query param**: `addNewCollectionItem()` embeds a *new*
  collection-item inline form (form mode `mini`, `#save_entity = FALSE`) — but only after checking
  `$collection_from_param->access('update')`, so a user cannot attach content to a collection they
  cannot edit. A trailing submit handler `handleNewCollection()` saves the collection item *after*
  the host is saved (so it can reference the new host id).
- **Existing host entity**: `addExistingCollectionItems()` embeds an *edit* inline form for each
  collection item referencing the host that the user can `update` (via `content_manager`), with the
  canonical one marked `*`.

## Block

`Plugin/Block/UserCollectionsBlock` (`user_collections_block`) — on a user-route page, lists the
collections (of a configured `collection_type`) that the **routed** user has `update` access to;
each row's links (view / add content / view items) are individually `#access`-gated for the
**current** viewer. Cache: per-user context + `collection_list` tag.

## Views integration (`collection.views.inc`, `src/Plugin/views/`)

- Access plugin `collection_items_access` — sets the `_collection_items_access` requirement on the
  view's route (access is actually enforced by the route check, so `access()` returns TRUE).
- Argument-default plugin `collection` — supplies the current route's collection id.
- Field plugins for a collected item's entity-type label, latest-version link, state, and status.
- `CollectionViewsData` / `CollectionItemType` provide the views data.

## Extending (developer notes)

- Add an entity to a collection programmatically: `$collection->addItem($entity)` (returns the new
  `collection_item` or FALSE if already present); remove with `$collection->removeItem($entity)`.
- Find memberships: `\Drupal::service('collection.content_manager')
  ->getCollectionsForEntity($entity, 'view')`.
- React to membership changes via the `CollectionEvents` subscribers rather than entity hooks, since
  the module fires its own events on save/delete.
