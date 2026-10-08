<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views dynamic fields and filters (views_dynamic_fields_and_filters) — agent index

Conditionally **keeps or drops a Views display's fields and filters** based on request-parameter
values, evaluated at build time. Site-building convenience — no custom code, no view cloning.
Package `custom`. Depends only on core **`views`**. Core requirement `^8.8 || ^9 || ^10 || ^11`.
License GPL-2.0-or-later. Version 1.2.0 (branch dir `1.x`).

- **The display extender, its config/schema, the dff parameter mapping and the condition/expression
  DSL, and how the pre_build hook applies it** → [plugins/display_extender.md](plugins/display_extender.md)

## What it actually is

- One plugin: **`DynamicFieldsAndFilters`** (Views display extender, id
  `views_dynamic_fields_and_filters`, title *"Dynamic fields and filters"*, `no_ui = FALSE`) in
  `src/Plugin/views/display_extender/DynamicFieldsAndFilters.php`, extending core
  `DisplayExtenderPluginBase`.
- One hook: **`views_dynamic_fields_and_filters_views_pre_build()`** in the `.module` file — the
  only runtime entry point; it excludes non-matching fields (`options['exclude'] = TRUE`) and
  `unset()`s non-matching filters before the query is built.
- `hook_install()`/`hook_uninstall()` register/deregister the extender in
  `views.settings:display_extenders`. `hook_update_810001()` renames legacy config keys.
- **No** routes, **no** permissions of its own, **no** services, **no** Drush, **no** new entity
  or plugin type. Config schema only (`views.display_extender.views_dynamic_fields_and_filters`).
- Configured **per Views display** in the *advanced* column of the Views edit UI (requires the core
  *administer views* permission like any Views edit).

## Mechanism (from source)

- Admin maps up to 9 request-parameter names to aliases **`dff1`–`dff9`** (per display), plus two
  toggles: `case_insensitive` and `add_query_cache_tags`.
- Each field/filter's **administrative title** may carry a condition, e.g.
  `dff1|page|Custom title`. `isDffLabel()` detects the `^dff[1-9]\|` pattern; `testLabel()` splits
  on `|`, resolves each `dffN` to its live request value via `$view->getRequest()->get()`, and
  calls `evaluateCondition()`. Non-dff labels always pass (returned `TRUE`).
- `evaluateCondition()` supports plain loose `==`, `{neq|in|nin|gt|lt|cn|ncn:value}` expressions,
  array values (true if any element matches), numeric coercion for `gt`/`lt`, and optional
  case-insensitive comparison. Chaining with `AND`/`OR`/`XOR` (up to 10 operators per label).
- `extendCacheIfEnabled()` adds the `url.query_args` cache context when the display cache is on and
  `add_query_cache_tags` is set (so Serializer/RSS variants cache correctly).
- It only **hides** existing fields and **removes** existing filters — it never adds fields the view
  did not already define. Hiding a field is a display change, not an access change (standard Views
  behavior: field/entity access is enforced separately by core).

## Config shape

Stored under the display's `display_extenders.views_dynamic_fields_and_filters`:
`parameters.dff1…dff9` (strings) and `settings.case_insensitive` / `settings.add_query_cache_tags`
(booleans). Schema in `config/schema/views_dynamic_fields_and_filters.views.schema.yml`. Full DSL,
form, validation and config example in [plugins/display_extender.md](plugins/display_extender.md).
