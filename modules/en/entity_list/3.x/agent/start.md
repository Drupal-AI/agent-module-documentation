<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity list (entity_list) — agent index

A plugin-driven framework for building lists/collections of entities without Views. Defines the
`entity_list` **config entity**; each list wires together an **EntityListQuery** plugin (data
source), an **EntityListDisplay** plugin (rendering via a Layout Discovery layout), plus optional
**EntityListExtraDisplay**, **EntityListFilter** and **EntityListSortableFilter** plugins. Lists
are placed as auto-derived blocks, shown on the entity's canonical admin route, or embedded via a
field formatter.

- Package `Content`. Version dir `3.x` (installed release 3.0.9). License GPL-2.0-or-later.
- Core `^10.1 || ^11`. Depends only on core **`layout_discovery`**; optional `fapi_collapsible`.
- Provides **permissions** (`entity_list.permissions.yml`), **config schema**, **5 plugin managers**
  (`entity_list.services.yml`), a `service.content_filter` service, a block deriver, a field
  formatter, and theme hooks (`entity_list_table`, `region_table`, `entity_list_item`,
  `entity_list_sortable_filters`).
- No composer requirements, no Drush, no external libraries (its JS libraries use core assets only).

## Solution docs

- **Config entity, handlers, routes, permissions, install** →
  [config/entity-list.md](config/entity-list.md)
- **Query plugins (data source): default / contextual / filter** →
  [plugins/query.md](plugins/query.md)
- **Display + extra-display plugins (rendering, layouts, regions)** →
  [plugins/display.md](plugins/display.md)
- **Filter + sortable-filter plugins, filter forms, filter controller, ContentFilterService** →
  [plugins/filters.md](plugins/filters.md)
- **How a list is rendered/placed: view builder, block, reference field formatter, theme, alter hooks** →
  [api/rendering.md](api/rendering.md)

## Quick facts (from source)

- Config entity: `Entity/EntityList.php` (`@ConfigEntityType id="entity_list"`,
  `admin_permission="administer entity list"`, config keys `id,label,query,display,filter,
  sortableFilter,step`). Access handler `Access/EntityListAccessControlHandler.php`.
- Query plugins: `default_entity_list_query`, `contextual_entity_list_query`,
  `filter_entity_list_query` (`src/Plugin/EntityListQuery/`).
- Display plugins: `default_entity_list_display`, `filter_entity_list_display`.
- Extra display: `filters_entity_list_extra_display`, `sortable_filters_entity_list_extra_display`.
- Filters: `search_`, `date_`, `taxonomies_`, `custom_list_entity_list_filter`. Sortable filter:
  `global_entity_list_sortable_filter`.
- Permissions: `view entity list`, `administer entity list`.
- Routes: entity routes via `EntityListHtmlRouteProvider` (AdminHtmlRouteProvider) +
  `entity_list.filters_list|filters_add|filters_remove` (`entity_list.routing.yml`).
