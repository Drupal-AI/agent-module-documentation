<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Rendering & placement: view builder, block, field formatter, alter hooks

## EntityListViewBuilder

`src/EntityListViewBuilder.php` (the `entity_list` `view_builder` handler; implements
`EntityViewBuilderInterface`). Injects `entity_type.manager`, `language_manager`, `theme.registry`.

`build($entity_list, $view_mode)` (via `view()`):
1. `$query_plugin = $entity_list->getEntityListQueryPlugin();`
2. `$query_plugin->buildQuery();`
3. Invokes alter hooks `entity_list_query` and `entity_list_query_<list_id>` with
   `($query_plugin, $entity_list)`.
4. `$entity_ids = $query_plugin->execute();` then
   `$entities = storage->loadMultiple($entity_ids);`
5. `return $entity_list->getEntityListDisplayPlugin()->render($entities, $view_mode);`

`getCacheTags()` returns `entity_list_view`; `resetCache()` mirrors core's view builder.
`viewMultiple()`, `buildComponents()`, `viewField()` are no-ops.

## Block placement

`Plugin/Block/EntityListBlock` (`@Block id="entity_list_block"`,
`deriver = Plugin\Derivative\EntityListBlock`). The deriver enumerates every saved `entity_list`
config entity and creates a block derivative per list (`entity_list_block:<list_id>`), labelled with
the list label and carrying a config dependency on the list. `build()` loads the list and returns
`getViewBuilder('entity_list')->view($entity_list)`. `getCacheTags()` adds `<entity_type>_list` and
(optionally) a `config:context.context.<id>` tag.

Block visibility/placement is governed by core block access; a placed list block renders through the
view builder above.

## Reference field formatter (embed a list on a host entity)

`Plugin/Field/FieldFormatter/EntityListReferenceFieldFormatter`
(`@FieldFormatter id="entity_list_reference_field_formatter"`, `field_types = {entity_reference}`)
extends core `EntityReferenceEntityFormatter`. Its `viewElements()` iterates
`getEntitiesToView($items, $langcode)` (so core reference access/recursion protection applies to the
referenced entities), and before rendering each entity calls `$entity->setHost($items->getEntity())`
when the target supports it — this is how a `contextual_entity_list_query` with `use_host` obtains
its host entity. Each entity is then rendered with its own view builder in the chosen view mode.

Use this formatter on an entity-reference field that points at `entity_list` entities to display a
list inline on the host entity.

## Theme & assets

- Theme hooks (see [../plugins/display.md](../plugins/display.md)): `entity_list_table`,
  `region_table`, `entity_list_item`, `entity_list_sortable_filters`; twigs under `templates/`.
- `entity_list.libraries.yml`: `region-table` (js/region-table.js) and `sortable-filters`
  (js/sortable-filters.js) — both depend only on core JS (`core/jquery`, `core/drupal`,
  `core/once`, etc.). No external/CDN libraries.
- `entity_list_get_pager_infos()` (in `entity_list.module`) computes start/end/total/current-page
  for the *total* display element.

## Extension points (developer summary)

- Add a data source: an `@EntityListQuery` plugin (see [../plugins/query.md](../plugins/query.md)).
- Add a rendering style: an `@EntityListDisplay` plugin.
- Add a configuration tab: an `@EntityListExtraDisplay` plugin.
- Add exposed widgets: `@EntityListFilter` / `@EntityListSortableFilter` plugins
  (see [../plugins/filters.md](../plugins/filters.md)).
- Alter queries: `hook_entity_list_query_alter(&$query_plugin, $entity_list)` and
  `hook_entity_list_query_<list_id>_alter()`.
- Plugin info alter hooks exist per manager (e.g. `entity_list_entity_list_display_info`).
