# Extend — processor plugin type & services

## `FullcalendarViewProcessor` plugin type

The module defines its own plugin type so other modules can alter the calendar's preprocess
variables (colors, event data, options) without patching the style plugin.

- Manager: `plugin.manager.fullcalendar_view_processor`
  (`FullcalendarViewProcessorManager`, extends `DefaultPluginManager`).
- Discovery dir: `Plugin/FullcalendarViewProcessor`.
- Annotation: `@FullcalendarViewProcessor` (`id`, `label`, `field_types`).
- Interface: `FullcalendarViewProcessorInterface`; base class:
  `FullcalendarViewProcessorBase` (abstract `process(array &$variables)`).
- Alter hook: `hook_fullcalendar_view_fullcalendar_view_processor_info(&$info)`.

Implement one in your module at `src/Plugin/FullcalendarViewProcessor/MyProcessor.php`:

```php
namespace Drupal\my_module\Plugin\FullcalendarViewProcessor;

use Drupal\fullcalendar_view\Plugin\FullcalendarViewProcessorBase;

/**
 * @FullcalendarViewProcessor(
 *   id = "my_processor",
 *   label = @Translation("My processor"),
 *   field_types = {}
 * )
 */
class MyProcessor extends FullcalendarViewProcessorBase {
  public function process(array &$variables) {
    // Mutate the calendar variables (e.g. $variables['#attached'],
    // event data, drupalSettings) before render.
  }
}
```

## Services (decorate / call)

Declared in `fullcalendar_view.services.yml`:

| Service | Class | Role |
|---|---|---|
| `fullcalendar_view.view_preprocess` | `FullcalendarViewPreprocess` | Core calendar business logic; **decorate or override** to inject custom event handling. Args: `@language_manager`, `@csrf_token`, `@entity_type.manager`, `@fullcalendar_view.timezone_conversion_service`. |
| `fullcalendar_view.taxonomy_color` | `TaxonomyColor` | Maps taxonomy terms to event colors (`@entity_type.manager`). |
| `fullcalendar_view.timezone_conversion_service` | `TimezoneService` | Timezone conversion for event times. |
| `plugin.manager.fullcalendar_view_processor` | `FullcalendarViewProcessorManager` | The processor plugin manager. |

The README explicitly invites decorating `FullcalendarViewPreprocess` to define your own calendar
business logic. There is no `*.api.php` file; the processor plugin type and these services are the
extension surface.
