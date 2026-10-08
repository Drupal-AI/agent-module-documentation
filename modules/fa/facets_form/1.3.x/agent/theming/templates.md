<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theming facet option labels

## The theme hook — `facets_form_item`
Each facet option label is rendered through the `facets_form_item` theme hook (called from
`FacetsFormWidgetTrait::getOptionLabel()` via `renderInIsolation`). Variables:
`facet`, `facet_source`, `widget`, `value`, `label`, `show_count` (bool), `count`, `depth` (int).

Base template: `templates/facets-form-item.html.twig`. Shipped per-widget variants:
`facets-form-item--facets-form-dropdown.html.twig`, `facets-form-item--facets-form-checkbox.html.twig`.

## Theme suggestions
`hook_theme_suggestions_facets_form_item()` provides, in order of increasing specificity:
- `facets_form_item__<WIDGET_PLUGIN_ID>`
- `facets_form_item__<WIDGET_PLUGIN_ID>__<FACET_SOURCE_PLUGIN_ID>`

When turning a suggestion into a filename, replace `_` with `-` and `:` with `--`. Example — to
override the Dropdown item for source `search_api:views_page__search__page_1`:
```
facets-form-item--facets-form-dropdown--search-api--views-page--search--page-1.html.twig
```
To restyle all Dropdown items regardless of source, override
`facets-form-item--facets-form-dropdown.html.twig`.

## Dropdown indentation
`template_preprocess_facets_form_item__facets_form_dropdown()` passes `indent` =
the dropdown widget's `child_items_prefix` config, so the template can prefix child options by depth.

## Checkbox indentation
The checkbox widget wraps each checkbox in `depth` nested `<div class="{indent_class}">` elements via
its `indentCheckboxes()` after-build callback (`indent_class` is a widget setting, default
`indented`) — no template change needed for the wrappers.

## Data attributes for JS/theming
Widget wrappers carry `data-drupal-facets-form-widget` (plugin id) and
`data-drupal-facets-form-facet` (facet id); the whole form carries `data-drupal-facets-form`
(source id). Checkbox/dropdown elements also expose their hierarchy as
`data-drupal-facets-form-ancestors` (JSON).
