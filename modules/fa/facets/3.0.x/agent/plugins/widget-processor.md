# Add a custom widget or processor

## Widget (`facets_widget`)
Namespace `Plugin/facets/widget`; extend `WidgetPluginBase` (implements `WidgetPluginInterface`).

```php
namespace Drupal\mymodule\Plugin\facets\widget;

use Drupal\facets\FacetInterface;
use Drupal\facets\Widget\WidgetPluginBase;

/**
 * @FacetsWidget(
 *   id = "my_widget",
 *   label = @Translation("My widget"),
 *   description = @Translation("Custom facet rendering."),
 * )
 */
class MyWidget extends WidgetPluginBase {
  public function build(FacetInterface $facet) {
    $build = parent::build($facet);   // parent gives you a #theme => facets_item_list
    // customise $build here.
    return $build;
  }
  public function getQueryType() { return 'string'; }        // maps to a query_type plugin
  public function defaultConfiguration() { return ['show_numbers' => TRUE] + parent::defaultConfiguration(); }
  // buildConfigurationForm(): expose per-facet widget settings.
}
```

## Processor (`facets_processor`)
Namespace `Plugin/facets/processor`; extend `ProcessorPluginBase` and implement the stage
interface(s) you need: `PreQueryProcessorInterface::preQuery()`,
`PostQueryProcessorInterface::postQuery()`, `BuildProcessorInterface::build()`,
`SortProcessorInterface::sortResults()`.

```php
/**
 * @FacetsProcessor(
 *   id = "my_processor",
 *   label = @Translation("My processor"),
 *   stages = { "build" = 50 },
 * )
 */
class MyProcessor extends ProcessorPluginBase implements BuildProcessorInterface {
  public function build(FacetInterface $facet, array $results) {
    // filter/transform Result objects, return the array.
    return $results;
  }
}
```

- `stages` weights control execution order within each stage.
- Legacy `@Annotation` classes are used (not PHP attributes) — see `src/Annotation/`.
- Run `drush cr` after adding; the plugin appears in the facet settings form.
- Same pattern applies to `query_type`, `url_processor`, `facet_source`, `hierarchy`
  (see [plugin-types.md](plugin-types.md) for their base namespaces).
