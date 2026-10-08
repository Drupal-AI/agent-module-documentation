<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views filter plugin(s) & how they attach

The module does **not** define a new plugin *type*; it registers Views **filter** plugins
and wires them onto existing data columns.

## Plugins

| Plugin id | Class | Extends | Provided by |
|---|---|---|---|
| `entityreference_filter_view_result` | `Drupal\entityreference_filter\Plugin\views\filter\EntityReferenceFilterViewResult` | core `ManyToOne` | this module |
| `entityreference_filter_view_result_search_api` | `…filter\EntityReferenceFilterViewResultSearchApi` | `EntityReferenceFilterViewResult` + `SearchApiFilterTrait` | submodule `entityreference_filter_search_api` |

Both use the attribute `#[ViewsFilter("…")]`. Config schema:
`views.filter.entityreference_filter_view_result` (the Search API one inherits it).

## How the filter is attached — `hook_views_data_alter()`

`EntityReferenceFilterHooks::viewsDataAlter()` scans all Views data and, for every column
that identifies a content-entity id, adds a **new** filter handler
`{column}_entityreference_filter` whose `filter.id` is `entityreference_filter_view_result`.
It targets:

- entity **id columns** on a base/data table (nid, uid, tid, …),
- **entity-reference fields** ending in `_target_id` (resolves the reference `target_type`),
- id columns exposed through a Views **relationship**,
- **Search API** indexed fields — but only if the Search API submodule's plugin
  (`entityreference_filter_view_result_search_api`) is installed; otherwise that field is
  skipped. The Search API variant id is used for `search_api_index` tables.

Each generated handler records `filter_base_table` = the target entity's base/data table,
which the options form uses to list only eligible Entity-Reference view displays. Titles are
suffixed "(entityreference filter)" / "(ef)".

## How options are built (`ReferenceViewOptionsBuilder::buildOptions()`)

Given `reference_display` = `"view_name:display_id"` and the resolved arguments, it:
loads the view, checks `access($display_id)`, sets items-per-page to unlimited, executes the
display, and returns an ordered `entity_id => rendered_label` map. Missing view → `NULL`;
access-denied → `NULL`; the filter treats those as an empty list.

## Supporting services (autowired)

- `FilterArgumentsResolver` — parses `reference_arguments` (`!n` / `#n` / `[identifier]` /
  literal) into concrete contextual args, and reports the controlling filter identifiers.
- `ReferenceViewOptionsBuilder` — runs the reference display and builds the option list.
- `FilterDependencyResolver` — builds the filter dependency graph, `detectCycle()` for the
  circular-dependency validation, and `computeEffectiveValue()` for the AJAX cascade.

AJAX endpoint: route `entityreference_filter.ajax` →
`EntityReferenceFilterAjaxController::ajaxFiltersValuesRebuild` (POST, `access content`),
rebuilds dependent filters' options client-side via `EntityReferenceFilterRebuildCommand`.

## Writing your own variant

Subclass `EntityReferenceFilterViewResult` and annotate with a new `#[ViewsFilter("…")]` id
(this is exactly what the Search API submodule does, adding `SearchApiFilterTrait`). You then
route data columns to it from your own `hook_views_data_alter()`.
