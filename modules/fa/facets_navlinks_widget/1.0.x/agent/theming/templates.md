<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theming: theme hooks and templates

Defined in `facets_navlinks_widget.module` via `hook_theme()`
(`facets_navlinks_widget_theme()`); two theme hooks, two shipped Twig templates in `templates/`.

## facets_item_list_navlinks

Template `templates/facets-item-list-navlinks.html.twig`. Set as the widget's `#theme` in
`NavLinksWidget::build()`. Variables: `facet`, `items`, `title`, `list_type` (default `ul`),
`wrapper_attributes`, `attributes`, `empty`, `context`.

Markup: a `<div class="facets-widget-{{ facet.widget.type }}">` wrapper; when `facet.widget.type` is set it
adds the `item-list__{type}` class to `attributes`. If there are `items` (or an `empty` message), it prints
an optional `<h3>{{ title }}</h3>`, then wraps the list in a `<nav>` element containing
`<{{ list_type }}{{ attributes }}>` with one `<li{{ item.attributes }}>{{ item.value }}</li>` per item; when
there are no items it prints `{{ empty }}`. The `<nav>` wrapper is the key difference from Facets core's
item-list template. It also emits Facets' cacheable-metadata HTML comment when `cache_hash` is set.

Preprocess: `facets_navlinks_widget_preprocess_facets_item_list_navlinks()` simply calls Facets'
`facets_preprocess_facets_item_list($variables)`, reusing the base widget's variable prep (cache metadata,
attributes objects, etc.).

## facets_result_item_navlinks

Template `templates/facets-result-item-navlinks.html.twig`. Set as each item's `#theme` in
`NavLinksWidget::buildResultItem()`. Variables: `facet`, `raw_value`, `value`, `show_count` (default
`FALSE`), `count`, `is_active` (default `FALSE`).

Markup: `<span class="facet-item__value">{{ value }}</span>`, and when `show_count` is true also
`<span class="facet-item__count">({{ count }})</span>`. No preprocess hook of its own.

## Overriding / styling

Both templates are standard themeable hooks — copy either into your theme's `templates/` directory to
override. Stable CSS/JS hooks the widget adds: `data-drupal-facet-widget-element-class="facets-navlink"` on
each item (see `NavLinksWidget::buildListItems()`) and the `facets-reset` class on the reset link's wrapper.
The module ships no CSS or JS library of its own.
