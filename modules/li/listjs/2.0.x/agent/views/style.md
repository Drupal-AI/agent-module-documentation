<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Listjs Views display style (`listjs_views` submodule)

Submodule **`listjs_views`** (`dependencies: listjs:listjs`, `drupal:views`) adds a Views style
plugin so a View can be rendered as a client-side searchable/sortable List.js widget.

## The plugin

`Drupal\listjs_views\Plugin\views\style\Listjs` (`@ViewsStyle(id = "listjs", theme =
"views_view_listjs")`), extends `StylePluginBase`, `usesFields = TRUE`. Choose it under a display's
**Format → Listjs**. Its options (config schema `views.style.listjs`):

- **`placeholder_text`** (default `Filter`) — the search box placeholder.
- **`filterable_fields`** — per field: `filterable` (bool), `sort` (bool), `sort_text` (string).
  `buildOptionsForm()` renders a fieldset per field of the display with a *Filterable* checkbox
  (default TRUE), a *Sortable* checkbox (default FALSE) and a *Sort text* field (default
  "`<label>` sort").

Default option for `filterable_fields` seeds a `title` entry (`filterable: TRUE, sort: FALSE`).

## Preprocess (`template_preprocess_views_view_listjs()`)

- Builds `value_names`: for each display field that is `filterable == 1` and not excluded, it derives
  the value-name **class** from `elementClasses()`, else `elementWrapperClasses()`, else
  `Html::getClass('views-field-' . $field)`; maps it to that field's `sort` / `sort_text`.
- Builds `items`: for each row, each non-excluded field with non-empty output becomes
  `['wrapper_element' => …, 'attributes' => Attribute(class=[…]), 'data' => ['#markup' => $field_output]]`.
  Row/field classes include `views-field views-field-<name>` when *Create default class* is on, plus
  any wrapper classes.
- `list_id = "{view_id}-{current_display}-wrapper"`; the `<ul>` gets class `list`.
- Attaches `drupalSettings.listJs.valueNames[list_id]` (via `listjs_prepare_list_value_names()`) and
  the `listjs/listjs-init` library — the same behavior as the theme hook drives it.
- Builds `filter_attributes` (`class=search`, `name={list_id}-filter`) and, per sortable value,
  `sort_attributes[value_name]` (`class=sort`, `data-sort=value_name`, `value=sort_text`).

Template `templates/views-view-listjs.html.twig` renders the search input, the sort buttons (only if
any are sortable), and a `<ul class="list">` where each row is an `<li>` of wrapped field cells.

## Practical notes

- The **value name is the field's CSS class**, so if you strip default field classes and set no
  custom class, matching falls back to `views-field-<field-id>` — keep classes consistent or search
  won't find the cell text.
- All of List.js's DOM limits apply: the View must render the **whole** result set on the page for
  the search to be complete. A paged view will only ever filter the current page. Prefer no pager (or
  a high items-per-page) for a small dataset; use exposed filters server-side for large ones.
- Config (`placeholder_text`, `sort_text`) is admin-entered and surfaces through Twig-autoescaped
  attributes and JSON-encoded `drupalSettings` — no injection surface.
