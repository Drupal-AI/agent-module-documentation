<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# navlinks widget plugin

`src/Plugin/facets/widget/NavLinksWidget.php` — `Drupal\facets_navlinks_widget\Plugin\facets\widget\NavLinksWidget`,
annotated `@FacetsWidget(id = "navlinks", label = "List of navigation links",
description = "Display facets as a list of navigation links")`. Extends Facets'
`Drupal\facets\Widget\WidgetPluginBase`. Selected per facet under the facet's **Widget** setting on the
Facets edit form (`/admin/config/search/facets`); it defines no route or form of its own.

## Configuration (per facet, stored in the facet entity's `widget.config`)

`defaultConfiguration()` adds three keys on top of the parent's:

- `show_reset_link` (bool, default `FALSE`) — checkbox "Show reset link".
- `reset_text` (string, default `$this->t('Show all')`) — textfield "Reset text"; only visible/required
  when `show_reset_link` is checked (`#states` keyed on `widget_config[show_reset_link]`).
- `hide_reset_when_no_selection` (bool, default `FALSE`) — checkbox "Hide reset link when no facet item is
  selected".

`buildConfigurationForm()` adds these three form elements (calling `parent::buildConfigurationForm()`
first, so it inherits the base widget's `show_numbers` etc.). No custom submit/validate; base handling
persists the values. The module ships no config/schema — the values rely on Facets' generic widget config
schema.

## build(FacetInterface $facet)

1. Calls `parent::build($facet)` to get the standard `#items` render array.
2. **Active-link fix-up**: loops `$build['#items']`; for the item whose `#title['#is_active'] === TRUE`,
   it recreates the facet's URL processor via `plugin.manager.facets.url_processor`
   (`createInstance(...getUrlProcessorName(), ['facet' => $item_facet])`), takes the current
   `\Drupal::request()->query->all()`, and re-adds this facet's own filter
   (`getFilterKey()` => `[urlAlias . separator . #raw_value]`) into the link's query via
   `$build['#items'][$delta]['#url']->setOption('query', $params)`. This is what keeps the active facet a
   real, still-selected link instead of a toggle that clears itself. Breaks after the first active item.
3. Calls `addResetLink($facet, $build)`.
4. Sets `$build['#theme'] = 'facets_item_list_navlinks'` and returns.

## addResetLink() (protected)

Runs only when `show_reset_link` is on, there is ≥1 result, and either `hide_reset_when_no_selection` is
off or the facet has active items. It:

- Computes `max_items` = sum of all result counts.
- Rebuilds the URL processor and gets `getActiveFilters()`, unsets this facet's own filter. If other
  filters remain, `facets.utility.url_generator`->`getUrl($active_filters, FALSE)`; otherwise
  `getUrlForRequest($request, $facet_source->getPath())`, strips this facet's filter key and the `page`
  param (returns to first page) and clears the `facets_query` route param.
- Creates `new Result($facet, 'reset_all', $this->getConfiguration()['reset_text'], $max_items)`, sets its
  URL, marks it active when no other facet is in use (`none_active`), builds it with `buildListItems()`,
  adds the `facets-reset` wrapper class, and `array_unshift`es it to the front of `#items`.

## buildListItems() / buildResultItem() (overrides)

- `buildListItems()` — adds `data-drupal-facet-widget-element-class = 'facets-navlink'` to each item's
  `#attributes`.
- `buildResultItem()` — sets each item's `#theme` to `facets_result_item_navlinks`.

## Services used at runtime

`plugin.manager.facets.url_processor` and `facets.utility.url_generator` (both from Facets), plus
`\Drupal::request()`. Fetched via `\Drupal::service()` static calls, not injected.
