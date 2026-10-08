# Blocks

Three block plugins. The two search-view blocks are **derived once per Search API display**
(`SearchApiDisplayBlockDeriver` walks `plugin.manager.search_api.display` and emits a derivative
`{base}:{view_id}__{display_id}` per display). Both derived blocks return `getCacheMaxAge() = 0`
(never cached — they must track the current results). Place any of them via the normal Block layout
UI; the Advanced Search / Pager blocks appear under category **Islandora**.

## `advanced_search_block` — Advanced Search Block

`Drupal\advanced_search\Plugin\Block\AdvancedSearchBlock` (deriver `AdvancedSearchBlockDeriver`,
admin_label "Islandora Advanced Search"). Renders `AdvancedSearchForm` for the view/display it was
derived from: a repeatable row of *field* select + *is / is not* + value textfield, joined by
*and / or*, with `+`/`-`/Reset buttons (AJAX). Submitting redirects to the display's search page with
`a[N][...]` query params (see [api/query.md](../api/query.md)).

Per-block settings (`blockForm`/`blockSubmit`):

| Setting | Constant | Meaning |
|---|---|---|
| `fields` | `SETTING_FIELDS` | Ordered list of Search API field identifiers shown in the form; chosen via a Visible/Hidden tabledrag table (library `advanced_search/advanced.search.admin`). |
| `context_filter` | `SETTING_CONTEXTUAL_FILTER` | Which of the display's contextual filters (view arguments) selects *direct children* of a collection; used to enable/disable recursive (sub-collection) search. |

`build()` resolves the index via
`plugin.manager.search_api.display` → `createInstance("views_{display_plugin}:{derivative_id}")`.

## `advanced_search_result_pager` — Search Results Pager Block

`Drupal\advanced_search\Plugin\Block\SearchResultsPagerBlock` (deriver
`SearchResultsPagerBlockDeriver`, admin_label "Search Results Pager"). Executes the derived
view/display (after `AdvancedSearchQuery::alterView()` for recursion) and renders: a results summary
("Displaying X - Y of Z"), results-per-page links (from the view pager's exposed
`items_per_page_options`), list/grid display links, an exposed sort-by `<select>`, and the pager.
Attaches `drupalSettings.advanced_search_pager_views_ajax` (view id, display id, `ajax_path`
`/views/ajax`). Honors `no_follow` on its links.

Per-block override settings default to the global settings but win when set:

| Setting | Overrides global key |
|---|---|
| `override_list_on_off` | `list_on_off` |
| `override_grid_on_off` | `grid_on_off` |
| `override-default-display-mode` | `default-display-mode` |

## `search_block` — (Simple) Search Block

`Drupal\advanced_search\Plugin\Block\SearchBlock` (admin_label "Search"; **not** derived). A minimal
keyword box that redirects to a chosen search page. Requires the global `all_fields_on_off` setting
to be enabled — otherwise the block form and the rendered block only show a notice pointing to
`/admin/config/search/advanced`. Renders `Drupal\advanced_search\Form\SearchForm`, whose
`submitForm()` redirects to the configured view route with
`a[0][f]=all`, `a[0][i]=IS`, `a[0][v]=<keyword>`.

Settings (schema `block.settings.search_block`):

| Setting | Meaning |
|---|---|
| `search_view_machine_name` | Route of the target search results page (a Views `page` display route, e.g. `view.<view>.<display>`). |
| `search_textfield_label` | Label for the keyword field. |
| `search_placeholder` | Placeholder text (falls back to "Search collections"). |
| `search_submit_label` | Submit button text (falls back to "Search"). |
| `block_id` | Machine id of the placed block (captured on save so `SearchForm` can reload its settings). |
