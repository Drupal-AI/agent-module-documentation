<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EntityListDisplay & EntityListExtraDisplay plugins (rendering)

## EntityListDisplay

Plugin type that turns the queried entities into a render array. Discovery:
`Plugin/EntityListDisplayManager` (dir `Plugin/EntityListDisplay`, interface
`EntityListDisplayInterface`, annotation `Annotation\EntityListDisplay`, keys `id`, `label`).
Service `plugin.manager.entity_list_display`. Base `Plugin/EntityListDisplayBase.php` (stores
`$this->entity` and `$this->settings` = the `display` config mapping).

The view builder calls `$plugin->render($entities, $view_mode)`.

### `default_entity_list_display` — `DefaultEntityListDisplay`

Ctor injects `entity_type.manager`, `entity_display.repository`, `plugin.manager.core.layout`.

- `render($items, $view_mode)` — resolves the layout plugin (`getLayout()`, default
  `filter_entity_list_display`), builds region content via `getRenderedLayoutItems()`, calls
  `$layout->build(...)`, adds wrapper attributes (class `entity-list` + list id + `custom_class`),
  and sets `#cache` tags `<entity_type>_list` and `config:entity_list.entity_list.<id>`.
- `settingsForm()` — custom classes, layout select, and a `region_table` element (`#type =>
  region_table`) whose rows are the draggable layout items.
- `getAvailableLayoutItems()` — the placeable items: `total` (singular/plural text), `items`
  (custom classes, **view mode**, empty text), `pager_1`, `pager_2`. View-mode options come from
  `getAvailableViewModesOptions()` (intersection across the selected bundles).
- `getRenderedLayoutItems($entities, $layout_items)` — groups enabled items by region:
  - `items` → for each entity a `#theme => entity_list_item` element whose `#element` is
    `getViewBuilder(entity_type)->view($entity, view_mode)`; empty text otherwise.
  - `total` → `formatPlural()` of the pager total (only when a pager is used).
  - `pager_1`/`pager_2` → `#type => pager` (only when `usePager()`).
- `getRenderedItems()` — alternate helper using `viewMultiple()`.

### `filter_entity_list_display` — `FilterEntityListDisplay` (extends default)

Adds exposed filter/sortable-filter regions. Ctor also injects `form_builder`.

- `getAvailableLayoutItems()` — adds `filters` and `sortable_filters` placeable items.
- `getRenderedLayoutItems()` — same as default for `items/total/pager`, plus:
  - `filters` → `formBuilder->getForm(Form\EntityListFilterForm, $entity_list, $filter_keys, $params)`
    built from `filter.filters_exposed.layout_items` rows whose region is `filters`.
  - `sortable_filters` → `formBuilder->getForm(Form\EntityListSortableFilterForm, …)` from
    `sortableFilter.sortable_filters_exposed.layout_items`.
- `asFilters()` / `asSortableFilters()` — whether those regions are enabled (used by
  `EntityListFilterQuery` to decide which filters to apply).
- `getFiltersSettings()` / `getSortableFiltersSettings()` — the per-filter settings passed to the
  query plugin.
- `render()` — adds the `url` cache context (the list varies by request query string).

## EntityListExtraDisplay (v3+ configuration tabs)

Plugin type providing extra configuration tabs in the list form. Discovery:
`Plugin/EntityListExtraDisplayManager` (dir `Plugin/EntityListExtraDisplay`, interface
`EntityListExtraDisplayInterface`, annotation `Annotation\EntityListExtraDisplay`). Service
`plugin.manager.entity_list_extra_display`. Base `Plugin/EntityListExtraDisplayBase.php`.

- `filters_entity_list_extra_display` — `FiltersEntityListExtraDisplay`: the *Filter* tab. Builds
  `filters_contextual` checkboxes (`status`/`promote`/`sticky`), filter settings (title, description,
  submit title, class), and the exposed-filter `region_table`. `getAvailableLayoutItems()` /
  `createFilterAvailableLayoutItem()` instantiate each `EntityListFilter` plugin and merge its
  `configurationFilter()` form plus a *Remove* link to `entity_list.filters_remove`. "Add Filters"
  links to `entity_list.filters_list`.
- `sortable_filters_entity_list_extra_display` — `SortableFiltersEntityListExtraDisplay`: the
  *Sortable filter* tab, same pattern for `EntityListSortableFilter` plugins.

## Layouts, templates, theme

- `entity_list.layouts.yml` defines `default_entity_list_display` and `filter_entity_list_display`
  layouts (Layout Discovery), with twigs under `layouts/`.
- `entity_list.module` `hook_theme()` registers `entity_list_table`, `region_table`,
  `entity_list_item`, `entity_list_sortable_filters`; preprocess for the table hooks delegates to
  core `template_preprocess_table`. Suggestion alters add `entity_list_item__<list_id>` and
  `form__entity_list_filter_form__<list_id>`.
- Custom render elements: `Element/EntityListTable.php`, `Element/RegionTable.php` (the draggable
  region table used by the display/extra-display settings forms).
