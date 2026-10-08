<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theming the summary

Three theme hooks (registered in `ViewsFiltersSummaryHooks::theme()`), each with an overridable
Twig template in `templates/`:

| Theme hook | Template | Variables |
|---|---|---|
| `views_filters_summary` | `views-filters-summary.html.twig` | `summary`, `options`, `exposed_form_id` |
| `views_filters_summary_items` | `views-filters-summary-items.html.twig` | `summary`, `options` |
| `views_filters_summary_item` | `views-filters-summary-item.html.twig` | `item`, `options` |

`options` carries: `use_ajax`, `show_label`, `show_remove_link`, `show_reset_link`,
`has_group_values`, `reset_link` (`title`, `filter_ids`), and `filters_summary`
(`prefix`, `separator`). Each `item` has `label`, `value`, and a `link` render array
(the remove-`X` link). Grouped items expose `groups` (a list of value items).

Wrapper markup: `<div class="views-filters-summary" data-exposed-form-id="…">` containing an
optional `.prefix`, the `.items` list, and an optional `.reset` link. Each value is a
`<span class="value-container"><strong class="value">…</strong> {link}</span>`.

## Library

`views_filters_summary/views_filters_summary` (attached automatically by the area's render array):

- `js/views-filters-summary.js` — wires the remove-`X` and reset links to the exposed form
  (`data-remove-selector` = `"$id:$value"`, `data-filter-ids` on the reset link); AJAX-aware via the
  `views-filters-summary--use-ajax` class. Depends on `core/jquery`, `core/drupal`, `core/once`.
- `css/views_filters_summary.css` — base styling.

To restyle or change markup, override any of the three templates in your theme. Submodules can add
assets to this library via `hook_library_info_alter` (a11y adds a CSS file; cvfb adds a JS file).
