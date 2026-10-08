<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Search API Mark Outdated (search_api_mark_outdated) — agent index

Visually flags rows in a **Search API view** whose underlying content entity has been edited since
the search index last indexed it — i.e. the copy the search results are showing is stale until the
index catches up. "Outdated" here means *index-stale*, **not** age/freshness: it has nothing to do
with how old content is or any configurable time threshold. The mechanism is entirely state-driven.
On `hook_entity_update()` the module records the changed entity's Search API combined id(s) in
`State` under a per-index key; when Search API finishes (re)indexing those items it fires
`SearchApiEvents::ITEMS_INDEXED`, and an event subscriber removes them from the outdated set. A Views
field plugin (`search_api_mark_outdated_state_field`) reads that state per result row and renders a
hidden `<div data-is-outdated="0|1">`; an optional JS library then adds a `search-api-outdated` CSS
class to the row's `<tr>` so a theme can style stale rows.

There is no UI, settings page, route, permission, or drush command. All configuration is the single
`add_row_class` option on the Views field, added per view. The module only tracks **content
entities** (`ContentEntityInterface`) and respects search_api's `search_api_skip_tracking` flag.

- Depends on: `search_api:search_api` (composer: `drupal/search_api:^1.16`).
- Core: `^9 || ^10 || ^11`. Package: `search_api`.
- No settings page / `configure` route. No permissions. No drush. Provides config schema
  (`views.field.search_api_mark_outdated_state_field`). Defines **no plugin types** (it supplies one
  Views field *plugin*).

## What you'd do → where

- **Add the outdated marker to a Search API view / configure `add_row_class` / style stale rows** →
  [views/mark-outdated-field.md](views/mark-outdated-field.md)
- **Query, set, or clear the outdated state from code; understand the tracking lifecycle, the manager
  service, the entity-update hook and the ITEMS_INDEXED subscriber** →
  [api/manager.md](api/manager.md)

## Key facts (real machine names)

- Services: `search_api_mark_outdated.manager` (`Drupal\search_api_mark_outdated\SearchApiManager`;
  args `@entity_type.manager`, `@state`); `search_api_mark_outdated.search_api_subscriber`
  (`EventSubscriber\SearchApiSubscriber`; tagged `event_subscriber`; arg the manager).
- Hooks implemented: `hook_entity_update()` (in `.module`), `hook_views_data_alter()` (in
  `.views.inc`).
- Event subscribed: `SearchApiEvents::ITEMS_INDEXED` → `SearchApiSubscriber::onItemsIndexed()`.
- Views field plugin id: `search_api_mark_outdated_state_field` (`@ViewsField`, class
  `Plugin\views\field\SearchApiStateField`, uses `SearchApiHandlerTrait`). Real field: `id`. Exposed
  on every `search_api_index_<id>` views table via `hook_views_data_alter()`.
- Views field option: `add_row_class` (boolean, default `TRUE`).
- Library: `search_api_mark_outdated/row-class` (`js/row-class.js`, dep `core/drupal`).
- JS behavior: `Drupal.behaviors.searchApiMarkOutdatedAddClass`. Renders attribute
  `data-is-outdated="0|1"`; JS adds CSS class `search-api-outdated` to the row `<tr>`.
- State keys: `search_api_mark_outdated_<index_id>` — array of outdated Search API combined ids for
  that index.
- Config schema: `views.field.search_api_mark_outdated_state_field` (maps `add_row_class` boolean).
- Manager public API: `entityUpdate(array $indexes, ContentEntityInterface $entity)`,
  `itemsIndexed(IndexInterface $index, array $item_ids)`, `setOutdated(IndexInterface $index, array $ids)`,
  `isOutdated(IndexInterface $index, string $id): bool`.
