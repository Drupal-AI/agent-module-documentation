<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Building an in-form facet widget

Facets Form does not define a new plugin type — it reuses the **Facets widget** plugin type
(`@FacetsWidget`, `plugin.manager.facets.widget`). To make a widget usable inside a facets form,
implement `\Drupal\facets_form\FacetsFormWidgetInterface`.

## Contract
```php
interface FacetsFormWidgetInterface extends \Drupal\facets\Widget\WidgetPluginInterface {
  // Turn the submitted form values into active filter values for the URL generator.
  public function prepareValueForUrl(FacetInterface $facet, array &$form, FormStateInterface $form_state): array;
}
```
A facet becomes "eligible" (rendered in the form and offered in the block's facet limiter) purely by
using a widget that implements this interface (`instanceof FacetsFormWidgetInterface`).

## Recommended base
Extend Facets' `ArrayWidget` and `use \Drupal\facets_form\FacetsFormWidgetTrait`. The trait provides:
- `prepareValueForUrl()` — a default that returns the non-zero submitted values' keys.
- `processItems()` / `doProcessItems()` / `doProcessAncestors()` — flattens the facet result tree
  into `$this->processedItems` keyed by raw value, each with `label`, `default`, `depth`, `children`,
  `ancestors`.
- `getOptionLabel()` — renders each option label via the `facets_form_item` theme
  (`renderInIsolation`), passing facet, source, widget, value, label, `show_count`, `count`, `depth`.

Typical widget skeleton (see shipped `CheckboxWidget` / `DropdownWidget`):
```php
/**
 * @FacetsWidget(
 *   id = "my_form_widget",
 *   label = @Translation("My widget (inside form)"),
 * )
 */
class MyWidget extends ArrayWidget implements FacetsFormWidgetInterface, ContainerFactoryPluginInterface {
  use FacetsFormWidgetTrait;

  public function build(FacetInterface $facet) {
    $items = parent::build($facet)[$facet->getFieldIdentifier()] ?? [];
    $this->processItems($items, $facet);
    return [ $facet->id() => [ '#type' => '...', '#options' => ..., ... ] ];
  }

  public function buildConfigurationForm(array $form, FormStateInterface $form_state, FacetInterface $facet): array {
    return [ /* your settings */ ] + parent::buildConfigurationForm($form, $form_state, $facet);
  }

  // Optional: override prepareValueForUrl() for non-checkbox value shapes.
}
```

## How build output is consumed (`FacetsForm::buildForm`)
- The form calls `facets.manager` `build($facet)` and stamps the outer element with
  `data-drupal-facets-form-widget` = plugin id and `data-drupal-facets-form-facet` = facet id, then
  nests it under `$form['facets'][<facet_id>]`.
- Ordering follows facet weight.
- If a widget ships a JS snippet (see [hooks/events.md](../hooks/events.md)) and a subscriber enabled
  the JS event, the matching `facets_form/plugin.<id>` library is attached.

## Value / query side
`prepareValueForUrl()` returns strings used as the facet's active items in the redirect URL. The
actual filtering is done by the facet's **query type** (core Facets for the string widgets;
submodules ship their own `@FacetsQueryType` — e.g. date range, fulltext — and register it via
`hook_facets_search_api_query_type_mapping_alter()`). If your widget needs custom query behavior,
ship a query type and return its id from the widget's `getQueryType()`.
