<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Admin List Filter (admin_list_filter) — agent index

Adds core's **client-side "filter by name" search box** (the one on `/admin/modules`) to many admin
**config-entity listing pages** by swapping their `list_builder` handler for a filterable subclass.
**Zero config, no permissions, no routes, no server work** — filtering is pure browser JS via
`system/drupal.system.modules`. No dependencies (Pathauto/Metatag supported *if present*). Core
`^10.3 || ^11`. Package `Administration`. License GPL-2.0-or-later. Version 1.0.x.

- **The two traits, the entity_type_alter swap, and the full entity-type map** →
  [api/list-builders.md](api/list-builders.md)

## What it actually is (from source)

- One hook: `admin_list_filter_entity_type_alter()` (`admin_list_filter.module`) calls
  `$entity_types[$id]->setHandlerClass('list_builder', <FilterableXListBuilder>)` for 17 core entity
  types, plus `pathauto_pattern` / `metatag_defaults` only when those entity types exist.
- Two traits in `src/`:
  - `FilterableListBuilderTrait` — for standard `EntityListBuilder` lists: overrides `render()`
    (adds a `#type=search` filter, class `filterable-config-entity-table` on the table, attaches
    `system/drupal.system.modules`) and `buildRow()` (adds `table-filter-text-source` to cells).
  - `FilterableDraggableListBuilderTrait` — for `DraggableListBuilder` (form) lists: overrides
    `buildForm()` to do the equivalent on `$this->entitiesKey` rows.
- 19 thin subclasses in `src/ListBuilder/` (e.g. `FilterableNodeTypeListBuilder extends
  NodeTypeListBuilder`), each just `use`-ing the right trait.
- **No** config, schema, permissions, services, routes, plugins, Drush, submodules, or custom JS/CSS.

## Mechanism (short)

The filter input carries `class="table-filter-text"` + `data-table=".filterable-config-entity-table"`;
searchable cells carry `table-filter-text-source`. Core's `drupal.system.modules` behavior reads the
input and hides non-matching rows in the browser — no AJAX, no query params reach the server, so the
existing core access control and output escaping of each list page are unchanged.
