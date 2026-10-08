# Add a facets_summary processor

`facets_summary` defines its own plugin type: **`facets_summary_processor`**, managed by
`plugin.manager.facets_summary.processor`, annotation `@SummaryProcessor`
(`src/Annotation/SummaryProcessor.php`), namespace `Plugin/facets_summary/processor`.

Extend `ProcessorPluginBase` and implement `BuildProcessorInterface::build()`, which receives
the summary build array and the list of facets and returns a modified render array.

```php
namespace Drupal\mymodule\Plugin\facets_summary\processor;

use Drupal\facets_summary\FacetsSummaryInterface;
use Drupal\facets_summary\Processor\BuildProcessorInterface;
use Drupal\facets_summary\Processor\ProcessorPluginBase;

/**
 * @SummaryProcessor(
 *   id = "my_summary_processor",
 *   label = @Translation("My summary processor"),
 *   stages = { "build" = 40 },
 * )
 */
class MySummaryProcessor extends ProcessorPluginBase implements BuildProcessorInterface {
  public function build(FacetsSummaryInterface $facets_summary, array $build, array $facets) {
    // add/alter items in $build['#items'], then:
    return $build;
  }
}
```

- Built-in examples: `ShowSummaryProcessor`, `ResetFacetsProcessor`, `ShowCountProcessor`,
  `ShowTextWhenEmptyProcessor`.
- The `facets_summary.manager` service (`DefaultFacetsSummaryManager::build()`) runs enabled
  processors when rendering the summary block.
- `drush cr`, then enable it on the summary's settings form.
