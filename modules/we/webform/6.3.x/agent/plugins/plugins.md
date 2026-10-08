# Webform plugin types

Webform defines five plugin types (annotation-based; managers in `src/Plugin/`). Each is
discovered from `src/Plugin/<Type>/` in any module.

| Plugin type | Annotation | Base class | Manager service | Purpose |
|---|---|---|---|---|
| WebformElement | `@WebformElement` | `WebformElementBase` | `plugin.manager.webform.element` | Form field / render element types |
| WebformHandler | `@WebformHandler` | `WebformHandlerBase` | `plugin.manager.webform.handler` | React to submissions (email, remote post, custom) |
| WebformExporter | `@WebformExporter` | `WebformExporterBase` | `plugin.manager.webform.exporter` | Results download formats |
| WebformVariant | `@WebformVariant` | `WebformVariantBase` | `plugin.manager.webform.variant` | A/B variations of a single form |
| WebformSourceEntity | `@WebformSourceEntity` | `WebformSourceEntityBase` | `plugin.manager.webform.source_entity` | Resolve the entity a form is attached to |

## Example: a handler
```php
// modules/custom/mymod/src/Plugin/WebformHandler/SlackWebformHandler.php
namespace Drupal\mymod\Plugin\WebformHandler;

use Drupal\webform\Plugin\WebformHandlerBase;
use Drupal\webform\WebformSubmissionInterface;

/**
 * @WebformHandler(
 *   id = "slack",
 *   label = @Translation("Slack"),
 *   category = @Translation("Notification"),
 *   cardinality = \Drupal\webform\Plugin\WebformHandlerInterface::CARDINALITY_UNLIMITED,
 *   results = \Drupal\webform\Plugin\WebformHandlerInterface::RESULTS_PROCESSED,
 * )
 */
class SlackWebformHandler extends WebformHandlerBase {
  public function postSave(WebformSubmissionInterface $submission, $update = TRUE) {
    $data = $submission->getData();
    // POST $data to Slack…
  }
  // Also: submitForm(), confirmForm(), preSave(), postDelete(),
  // buildConfigurationForm() for handler settings.
}
```

## Example: an element
Extend `WebformElementBase` (or a subclass like `TextBase`, `OptionsBase`, `WebformCompositeBase`)
with an `@WebformElement` annotation; the element renders via a paired Form API `#type`.
See the `webform_example_element` / `webform_example_composite` submodules for full skeletons.

Info-alter hooks let you tweak discovered plugins — see [../hooks/hooks.md](../hooks/hooks.md).
