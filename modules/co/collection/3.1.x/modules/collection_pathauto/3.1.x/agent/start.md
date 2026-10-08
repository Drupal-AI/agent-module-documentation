<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Collection Pathauto (collection_pathauto) — agent index

Submodule of **[collection](../../../../agent/start.md)** that integrates with **Pathauto**.
Prepends a **canonical** collection's URL alias to the Pathauto alias of the entity it collects.
Version **3.1.0**. Core `^9.4 || ^10 || ^11`. Package `Collection`. Depends on `collection` and
`pathauto`.

## What it does (two moving parts)

1. **`collection_pathauto.module` → `hook_pathauto_alias_alter()`**
   (`collection_pathauto_pathauto_alias_alter(&$alias, &$context)`): for the entity being aliased,
   walks its collection items (`collection.content_manager::getCollectionItemsForEntity`); on the
   first **canonical** item it resolves the collection's alias
   (`path_alias.manager::getAliasByPath('/collection/<cid>')`), sets `$context['original_alias']`,
   prefixes `$alias` with the collection alias, adds `collection_item` / `canonical_collection` to
   `$context`, and invokes `hook_collection_pathauto_alias_alter($alias, $context)` for downstream
   modules. Stops after the first canonical item.

2. **`src/EventSubscriber/CollectionPathautoSubscriber`** (service
   `collection_pathauto_subscriber`, arg `@pathauto.generator`): subscribes to Collection's
   `COLLECTION_ITEM_ENTITY_CREATE/UPDATE/DELETE` events. When the item is canonical and the collected
   entity is a content entity using a `PathautoFieldItemList`, it calls
   `PathautoGenerator::updateEntityAlias($collected_item, 'update')` — so the collected entity's alias
   is (re)generated whenever its canonical membership changes.

## Provided extension point

`collection_pathauto.api.php` documents **`hook_collection_pathauto_alias_alter(&$alias, &$context)`**
for further modifying the already-combined alias.

## Notes

- No routes, permissions, entities, services beyond the one subscriber, config schema, or install
  hooks. Pure Pathauto glue. No security-relevant surface (no user input reaches a sink; aliases go
  through Pathauto/path_alias APIs).
