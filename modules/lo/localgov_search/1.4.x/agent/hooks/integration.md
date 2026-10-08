# Hooks implemented (integration behaviour)

All in `localgov_search.module` / `localgov_search.install`. None are hooks you invoke — they
are behaviour integrators should know about.

| Hook | Function | Effect |
| --- | --- | --- |
| `hook_entity_bundle_create` | `localgov_search_entity_bundle_create($entity_type_id, $bundle)` | Auto-enrol new node bundles into search. |
| `hook_install` | `localgov_search_install($is_syncing)` | On (non-sync) install, runs the enrol logic for every existing node bundle. |
| `hook_views_pre_render` | `localgov_search_views_pre_render(ViewExecutable $view)` | Tweaks the search page header/empty/title. |
| `hook_preprocess_HOOK` (form) | `localgov_search_preprocess_form(&$variables)` | Adds ARIA search role to the exposed form. |
| `hook_help` | `localgov_search_help($route_name, $route_match)` | Help text on `help.page.localgov_search`. |

## Auto-enrol node bundles

`localgov_search_entity_bundle_create()` runs only for `entity_type_id == 'node'` and:

1. Loads View `localgov_sitewide_search`; if its default display has a `row`, sets
   `row.options.view_modes['entity:node'][$bundle] = 'search_result'` and saves the view.
2. Loads Index `localgov_sitewide_search` and its `rendered_item` field; **only if not
   already set**, sets `view_mode['entity:node'][$bundle] = 'search_index'` in the field
   configuration and saves the index.

Result: a content type created at any time joins search automatically. Removal is manual (see
[configure/search-index.md](../configure/search-index.md)).

## Search page rendering — `localgov_search_views_pre_render()`

Guarded to `#name == 'localgov_sitewide_search'` and
`#display_id == 'sitewide_search_page'`:

- No `?s` parameter → clears `$view->header` and `$view->empty` (blank form before first
  search).
- Has `s` and `total_rows > 0` → sets title to `"{s} - {view title}"` (header title only;
  localgov_core issue #93).

## ARIA — `localgov_search_preprocess_form()`

When the form `#id` is
`views-exposed-form-localgov-sitewide-search-sitewide-search-page`, adds
`role="search"` and `aria-label="Sitewide"` to the form attributes.

## Update hooks

- `localgov_search_update_8001()` — enables the `localgov_search_db` submodule in
  `core.extension` without running its install (its config was already present).
- `localgov_search_update_8002()` — sets `system.schema` for `localgov_search_db` to `8000`
  when it is enabled but has no recorded schema version.
