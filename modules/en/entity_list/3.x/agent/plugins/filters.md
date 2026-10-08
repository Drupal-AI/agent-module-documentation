<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EntityListFilter & EntityListSortableFilter plugins

Exposed filter and sort widgets shown in the `filter_entity_list_display` filter regions.

## EntityListFilter

Discovery: `Plugin/EntityListFilterManager` (dir `Plugin/EntityListFilter`, interface
`EntityListFilterInterface`, annotation `Annotation\EntityListFilter`, keys `id`, `label`,
`content_type`, `entity_type`). Service `plugin.manager.entity_list_filter`. Base
`Plugin/EntityListFilterBase.php`.

Contract used by the pipeline:
- `configurationFilter($default_value, $entity_list)` — the admin settings form for the filter
  (base adds `collapsible`, `expanded`, `title_display`).
- `buildFilter($parameters, $entity_list)` — the Form API elements rendered to the visitor (default
  value seeded from the request query param).
- `setFields($settings)` — returns field descriptors `['name'=>…, 'callback_condition'=>…,
  'field_name'=>…, 'operator'?, 'process_params'?]` consumed by `EntityListFilterQuery::buildQuery()`.
- `addCollapsible()` wraps a filter in a `collapsible` element when `fapi_collapsible` is enabled.
- `convertValues()` drops zero-valued checkbox entries.

Shipped filters:
- `search_entity_list_filter` — `SearchEntityListFilter` (entity_type `node`). Textfield; its
  `searchFilter()` callback builds an OR group of `LIKE '%value%'` conditions across the configured
  text fields (values bound by the core entity query — parameterized).
- `date_entity_list_filter` — `DateEntityListFilter`. Date/range filter over created/changed/
  datetime/daterange fields.
- `taxonomies_entity_list_filter` — `TaxonomiesEntityListFilter` (entity_type `node`). Term filter
  (OR/AND via `condition_type`); `taxonomyFilter()` adds bound term-id conditions. `getTerms()` runs
  a `Database::select('taxonomy_term_data')` whose `vid`/order come from saved settings.
- `custom_list_entity_list_filter` — `CustomListEntityListFilter`. Admin-defined option list filter.

`Service\ContentFilterService` (`service.content_filter`, injects `entity_field.manager`) supplies
the field option lists to the admin filter forms, scoped to `node`: `getFieldsTermsFilter()`
(term-reference fields), `getFilterTextFields()` (string/text fields), `getFilterDateFields()`
(date fields), `getAllField()`/`getFieldSortable()`.

## EntityListSortableFilter

Discovery: `Plugin/EntityListSortableFilterManager` (dir `Plugin/EntityListSortableFilter`,
interface `EntityListSortableFilterInterface`, annotation `Annotation\EntityListSortableFilter`,
keys `id`, `label`). Service `plugin.manager.entity_list_sortable_filter`. Base
`Plugin/EntityListSortableFilterBase.php`.

- `global_entity_list_sortable_filter` — `GlobalEntityListSortableFilter`: a visitor-facing sort
  control; `setFields()` yields `['name','field_name','default_value']` and the query plugin applies
  `sort($field_name, $direction)`.

## Filter forms & controller

- `Form\EntityListFilterFormBase` — shared base; on submit redirects with the chosen params in the
  query string so the list re-queries.
- `Form\EntityListFilterForm` (`entity_list_filter_form`) — renders the exposed filter fieldset by
  instantiating each configured filter plugin and merging its `buildFilter()` output; adds Submit +
  a Reset link to `<current>`.
- `Form\EntityListSortableFilterForm` — the sortable-filter counterpart.
- `Form\EntityListFilterParametersForm` — the modal form used when adding a filter to a list.
- `Controller\EntityListFilterController` (routes in `entity_list.routing.yml`, all
  `_permission: 'administer entity list'`): `listEntityListFilter()` builds the AJAX table of
  addable filters (filtered by the plugin's `entity_type`/`content_type` vs the list's selection);
  `addFilter()` returns the parameters form; `removeFilter()` loads the list, unsets the selected
  `filters_exposed`/`sortable_filters_exposed` layout item, saves, and redirects to the edit form.
