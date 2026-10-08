<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Rendering: templates, theme hooks, and the searchbox JS

This widget's on-page behavior comes from three Twig templates, three theme hooks in the `.module`, and one asset
library. The PHP render array is described in [../plugins/searchable-form-checkbox-widget.md](../plugins/searchable-form-checkbox-widget.md).

## Theme hooks — `facets_form_searchbox_widget.module`

- `hook_theme()` registers two theme implementations, each with a `base hook`:
  `facets_item_list__facets_form_searchable_checkbox` (base `facets_item_list`) and
  `facets_result_item__facets_form_searchable_checkbox` (base `facets_result_item`).
- `hook_theme_suggestions_alter()` — when the facet's widget type is `facets_form_searchable_checkbox` and the hook
  is `facets_form_item`, appends the suggestion `facets_result_item__facets_form_searchable_checkbox`.
- `hook_theme_suggestions_input_alter()` — for `#type => checkbox` elements with a `#parents[0]`, appends
  `<theme_hook_original>__<parents[0]>` so per-facet input templates can be targeted.

## Templates — `templates/`

All three are suffixed `--facets-form-searchable-checkbox`:

- **`facets-result-item--...`** — renders `<span class="facet-item__value">{{ value }}</span>`, an optional
  `(-)` deactivate span when `is_active`, and an optional `<span class="facet-item__count">({{ count }})</span>`.
  The `.facet-item__value` span is what the JS reads to match search text.
- **`facets-form-item--...`** — outputs `{{- label }}` plus ` ({{ count }})` when `show_count`.
- **`facets-item-list--...`** — wraps the list in `<div class="facets-widget-<type>">`, prints an optional
  `<h3>{{ title }}</h3>`, a standalone `<input class="facets-widget-searchbox">` scaffold, the `<ul>/<ol>` of
  `{{ item.value }}` items via `attributes.addClass(...)`, an optional dropdown label, and a
  `<div class="facets-widget-searchbox-no-result hide">`. Item values are printed as standard Twig `{{ … }}`
  output.

## Asset library — `facets_form_searchbox_widget.libraries.yml`

`searchable_facets`: `css/searchable-facets.css` (theme) + `js/searchable-facets/scripts.js`, depending on
`core/drupalSettings`, `core/jquery`, `core/drupal`. `searchable-facets.css` toggles row visibility via the
`.show-facet-item-searchable-facets` / `.hide-facet-item-searchable-facets` classes.

## Behavior — `js/searchable-facets/scripts.js`

`Drupal.behaviors.rdsSbdSsrSearch`, attached with `.once('facets-form-searchable-facets')` on `.facets-form`:

- **Search (keyup on `.facets-form-searchable-checkbox-searchbox`)**: reads the input value, upper-cases it, and
  for each `.form-checkboxes .checkbox` row reads that row's `.facet-item__value` text (`.html()`) and toggles
  `show-facet-item-searchable-facets` based on `value.toUpperCase().indexOf(filter) > -1` (case-insensitive
  substring match). Filtering runs only when the query is at least 2 characters; below that it re-applies the
  soft limit.
- **`handleSoftLimit()`**: reads `data-soft-limit` from the `.facets-form-searchable-checkbox` wrapper and shows the
  first N rows (all when 0), hiding the rest with `facet-item-hidden-searchable-facets`; any row whose
  `.facets-form-searchable-checkbox-list-item` checkbox is `checked` is forced visible with `.show()`.
- **`handleShowMoreBtn()`**: counts hidden rows, writes the count into `.show-more-link-count` with `.text()`,
  reveals the "Show more" link, and wires the Show more / Show less clicks to add/remove
  `show-facet-item-searchable-facets soft-limit-item-hidden` on the collapsed rows.
- **`handleNoResults()`**: after each search, if no `.checkbox:visible` rows remain for the facet id it un-hides
  `.no-results-message`, otherwise re-hides it.

The behavior's DOM updates are limited to class toggles, jQuery `.show()`, and `.text()` count updates.
