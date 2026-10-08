<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Allowed-values-functions report page

## Route

`allowed_values_functions.reports_fields` (`allowed_values_functions.routing.yml`):

- path `/admin/reports/fields/allowed-values-functions`
- `_controller: \Drupal\allowed_values_functions\Controller\AllowedValuesFunctionsController::reportFields`
- `_title: 'Allowed Values Functions'`

It is surfaced as a **local task** (`.links.task.yml`) and a **menu link** (`.links.menu.yml`),
both `base_route`/`parent = entity.field_storage_config.collection` — i.e. it appears alongside the
Field UI *Field storage* listing (that route is provided by core's **field_ui**, though field_ui is
not a declared module dependency).

## What it renders

`AllowedValuesFunctionsController::reportFields()` (`src/Controller/AllowedValuesFunctionsController.php`):

- Calls `$this->collection->listFunctions()` and groups callables by
  `entity_type_id . '.' . field_name`.
- Builds a `#type => 'table'` render array. Header: *Field name*, *Allowed values functions*.
- Column 0 is the field key set as `#plain_text` (escaped). Column 1 is an
  `#theme => 'item_list'` of the `Class::method` callable strings (`list_style => comma-list`,
  wrapper class `allowed-values-functions-list`).
- Rows are `ksort()`ed by field name. Empty text: *"No allowed_values_functions set to any field."*

Read-only page: it only lists the bindings discovered from code (`getCallable()` strings); it does
not execute the callables, and there is no form, action, or state change on this route.

## Operating

1. `drush cr` after adding/removing `#[AllowedValuesFunction]` attributes (discovery is compile-time).
2. Visit `/admin/reports/fields/allowed-values-functions` to confirm each expected
   `entity_type.field_name` row lists the intended `Class::method`.
3. A missing row usually means the attribute's `entityTypeId`/`fieldName` doesn't match a real field
   storage, or caches weren't rebuilt.
