# The `choices_js` Facets widget

Source: `src/Plugin/facets/widget/ChoicesWidget.php` — `@FacetsWidget(id = "choices_js", label =
"Choices.js")`, extends `\Drupal\facets\Widget\WidgetPluginBase`, implements
`ContainerFactoryPluginInterface`.

## Selecting it

*Search > Facets* → edit a facet → **Widget** = **Choices.js** → Configure. It exposes the standard
Facets widget options (e.g. *Show numbers*); it defines no extra settings form of its own.

## What `build(FacetInterface $facet)` returns

A render array:

```php
[
  '#type' => 'select',
  '#options' => $items,           // [ result_url => "Label" | "Label (count)" ]
  '#required' => FALSE,
  '#value' => $active_items,      // array of active result URLs (pre-selected)
  '#multiple' => !$facet->getShowOnlyOneResult(),
  '#name' => $facet->getName(),
  '#title' => $facet->get('show_title') ? $facet->getName() : '',
  '#attributes' => [
    'data-drupal-facet-id' => $facet->id(),
    'data-drupal-selector' => 'facet-' . $facet->id(),
    'class' => ['js-facets-choices', 'js-facets-widget'],
  ],
  '#attached' => [
    'library' => ['choices_facets/widget'],
    'drupalSettings' => ['choices' => ['facets' => ['hasFacetsWidget' => TRUE]]],
  ],
]
```

Details:
- Options are built by iterating `$facet->getResults()`; results with an empty URL are skipped.
- Counts are appended (`"Label (N)"`) only when the widget's `show_numbers` config is on and the result
  count is not NULL.
- Active results are collected into `#value` so they render selected.
- `#multiple` follows the facet's "show only one result" flag (single-select when true).

## Client side

Library `choices_facets/widget` (`choices_facets.libraries.yml`) loads `js/choices-widget.js` and depends
on `facets/widget` + `choices/choices`. The JS instantiates Choices on the `.js-facets-choices` select
and delegates to the Facets widget JS so selecting an option triggers facet-URL navigation.
