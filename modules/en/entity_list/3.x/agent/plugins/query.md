<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EntityListQuery plugins (the data source)

Plugin type that fetches the entity IDs shown in a list. Discovery:
`Plugin/EntityListQueryManager` (dir `Plugin/EntityListQuery`, interface
`EntityListQueryInterface`, annotation `Annotation\EntityListQuery` with keys `id`, `label`).
Service `plugin.manager.entity_list_query`. Base `Plugin/EntityListQueryBase.php`.

The view builder calls, in order: `buildQuery()`, then `hook_entity_list_query_alter` /
`hook_entity_list_query_<id>_alter`, then `execute()` → an array of entity IDs which are loaded with
`storage->loadMultiple()` (see [../api/rendering.md](../api/rendering.md)).

`EntityListQueryBase` stores `$this->entity` (the EntityList) and `$this->settings` (the `query`
config mapping); default `getEntityTypeId()` returns `settings['entity_type']`.

## `default_entity_list_query` — `DefaultEntityListQuery`

A thin wrapper over a core `EntityTypeManager` entity query. Ctor injects `entity_type.manager`,
`entity_type.bundle.info`, `language_manager`.

- `settingsForm()` — select the entity type (content entity types only), bundles (checkboxes),
  language (`auto` = current content language), items-per-page, use-pager.
- `buildQuery()` — `storage->getQuery()`, adds an OR condition group over the bundle key for the
  selected bundles, a `langcode` condition (resolving `auto` to the current language), and either
  `pager($items_per_page)` or `range(0, $items_per_page)`.
- Passthrough helpers proxy the core query: `condition/exists/notExists/range/pager/sort/count/
  and|orConditionGroup/addTag/hasTag/addMetaData/getMetaData`.
- `execute()` → `query->execute()`.

## `contextual_entity_list_query` — `ContextualEntityListQuery`

Lists the entities referenced by an entity-reference field on a *contextual* host entity instead of
running an entity query. Ctor also injects `entity_field.manager` and `current_route_match`.

- `settingsForm()` — select entity type, bundle, a `target` entity-reference field
  (`getAvailableFields()` reads the `entity_reference` field map), and a `use_host` checkbox.
- `getHostEntity()` — if `use_host` is set, uses `EntityList::getHost()` (set by the reference field
  formatter); otherwise `routeMatch->getParameter(entity_type)` (the entity in the current route).
- `getReferencedEntities()` / `execute()` — returns the IDs of `$host->{target}->referencedEntities()`.
- `getEntityTypeId()` / `getBundles()` — derived from the target field's `target_type` /
  `handler_settings.target_bundles`.
- `buildQuery()` is a no-op — this plugin reads a reference field directly rather than running an
  entity query.

## `filter_entity_list_query` — `EntityListFilterQuery` (extends `DefaultEntityListQuery`)

Adds request-driven exposed filtering and sorting on top of the default query. Ctor additionally
injects `request_stack`, `plugin.manager.entity_list_filter`, `plugin.manager.entity_list_sortable_filter`.

`buildQuery()`:
1. Calls `parent::buildQuery()` (so the base conditions still apply).
2. Applies contextual filters from `filter.filters_contextual` (e.g. `status`/`promote`/`sticky`
   → `condition($key, TRUE)`), and contextual sorts from `sortableFilter.sortable_contextual.sort_array`.
3. Reads the active display's exposed filter/sortable-filter settings, instantiates each
   `EntityListFilter`/`EntityListSortableFilter` plugin and calls `setFields()` to get field descriptors.
4. For each filter field, reads the request param `request->get($field['name'])`, optionally runs
   `process_params`, then applies it via the field's `callback_condition` callback, or
   `condition($name, $params, $operator|IN|=)`. Sortable fields become `sort($field_name, $param)`.

Because field names/operators/callbacks come from **saved config** (not the request) and values are
passed as bound entity-query conditions, request input reaches the query only as parameterized
condition values.

## Extending

Add a class in `Plugin/EntityListQuery/` with `@EntityListQuery(id=…, label=…)` extending
`EntityListQueryBase` (or `DefaultEntityListQuery`) implementing `buildQuery()`, `execute()`,
`getEntityTypeId()`. Alter an existing list's built query in code with
`hook_entity_list_query_alter(&$query_plugin, $entity_list)` or the per-list variant.
