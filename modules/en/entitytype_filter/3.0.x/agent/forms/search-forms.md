<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Search forms, routes, autocomplete & CSV export

All classes under `Drupal\entitytype_filter`. Install/enable: `drush en entitytype_filter`. Nothing to
configure — no config objects, no settings form, no own permissions.

## Routes (`entitytype_filter.routing.yml`)

| Route id | Path | Handler | Permission |
|---|---|---|---|
| `entitytype_filter.list_fields` | `/admin/entitytypes-filter` | `SearchEntitiesController::entityTypeFilterForm` | `administer content` |
| `entitytype_filter.list_fields_by_type` | `/admin/fieldtypes-filter` | `SearchEntitiesController::fieldTypeFilterForm` | `administer content` |
| `entitytype_filter.autocomplete` | `/admin/entitytype_filter/autocomplete/{config_entity_type}` | `EntitiesAutoCompleteController::handle` (`_format: json`) | `administer content` |

`SearchEntitiesController` (`src/Controller/SearchEntitiesController.php`) is a thin wrapper: each method
calls `formBuilder->getForm()` for the matching form class. Menu links live in
`entitytype_filter.links.menu.yml` under *Content* (`system.admin_content`): a parent *Entity Fields
Search* with children *By Entity Name* and *By Field Type*.

## Form 1 — `FilterEntityTypesForm` (search one bundle's fields by title)

`src/Form/FilterEntityTypesForm.php`, form id `entitytype_filter_form`. DI: `current_user`,
`entity_type.manager`, `plugin.manager.field.field_type`, `entity_field.manager`,
`entitytype_filter.search_service`.

- `buildForm()`: a `select_entity_type` `<select>` whose options come from
  `EntitySearchService::getBundleConfigEntityTypes(TRUE)` (all bundle config entity types). Changing it
  triggers an AJAX callback `selectEntityTypeChange()` that replaces the `autocomplete_ajax_container`,
  revealing a `filter_entity_types` textfield with `#autocomplete_route_name` =
  `entitytype_filter.autocomplete` (route param `config_entity_type` = the selected type).
- `submitForm()` only calls `$form_state->setRebuild(TRUE)`; `validateForm()` is empty. Results are
  rendered in the `filter_entity_types_table` (`#type => table`, header *Field Label* / *Field Type*).
- `getFieldsInfo()` does the work: derives the target content entity type from the selected bundle
  config type's `getBundleOf()`, extracts the chosen bundle id via
  `EntityAutocomplete::extractEntityIdFromAutocompleteInput()`, then keeps only
  `FieldConfigInterface` definitions from `entityFieldManager->getFieldDefinitions()` (i.e. configurable
  fields, not base fields). For each it computes a display label via `getEntityBasedFieldUrl()` and a
  field-type label via `EntitySearchService::recursiveSearchKeyMap()`.
- `getEntityBasedFieldUrl()` builds a Field-UI edit link (`{bundle path}/fields/{field id}`) using the
  per-type `path` from `getBundleConfigEntityTypes(TRUE)`, output through `t()` with `:url`/`@label`
  placeholders (so URL and label are sanitized/escaped by the translation system).
- Attaches library `entitytype_filter/filter_field` (`js/empty_autocomplete.js` clears the textfield and
  results table when the entity-type select changes).

## Form 2 — `FilterFieldTypesForm` (list fields across a type, optional field-type filter, CSV)

`src/Form/FilterFieldTypesForm.php`, form id `entitytype_filter_form`. Extra DI over form 1:
`messenger` and `cache.default`.

- `buildForm()`: `fselect_entity_type` `<select>` (bundle config types, prepended with a `none`
  placeholder) and `fselect_field_type` `<select>` built from
  `fieldTypePluginManager->getGroupedDefinitions(getUiDefinitions())`, prepended with `all`. A
  `download_table_csv` button (id `download_fields_table_as_csv`) triggers CSV export. Results table
  header: *Bundle Machine Name*, *Field Label*, *Field Machine Name*, *Field Type*.
- `buildFilteredFieldsList()`: if the entity type is `none`, adds a warning via `messenger` and returns
  empty. Otherwise it loads all bundle entities of the selected type — cached under
  `entity_storage_{type}` in `cache.default` for 86400 s — and, per bundle, collects configurable fields
  via `getEntityFieldsData()` (which excludes base fields by diffing against
  `getBaseFieldDefinitions()`). Each field is kept when `all` is selected or its type matches
  `fselect_field_type`, then rendered with bundle/label/name/type columns.
- `submitForm()` = `setRebuild(TRUE)`; `validateForm()` empty. Attaches
  `entitytype_filter/filter_fields_by_type`.

## Autocomplete — `EntitiesAutoCompleteController::handle`

`src/Controller/EntitiesAutoCompleteController.php`. Reads `q`, runs it through
`Xss::filter()`, returns `[]` if empty or if `entity_type.manager` has no definition for
`{config_entity_type}`. Builds an **entity query** (`storage->getQuery()`) with
`->condition(label_key, $input, 'CONTAINS')->range(0,10)` (parameterised — no string SQL), sorts by the
`created` key when the type has one, and returns up to 10 `{value,label}` JSON rows. Used only to type
ahead bundle labels for form 1.

## CSV export (client side)

`js/filter_fields_by_type.js`: clicking `#download_fields_table_as_csv` runs `tableToCSV()`, which reads
the rendered results `<table>` in the browser, strips HTML tags from each cell, joins rows, and downloads
a `fields_export.csv` Blob. No server route or file is involved.
