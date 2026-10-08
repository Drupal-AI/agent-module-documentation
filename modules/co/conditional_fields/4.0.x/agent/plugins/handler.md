# Handler plugins (`ConditionalFieldsHandler`)

The module DEFINES a plugin type that maps a field widget's value into a core States API
`#states` array. Add one when core/contrib ships a widget whose value shape isn't handled.

- Plugin manager: `plugin.manager.conditional_fields_handlers`
  (`Drupal\conditional_fields\ConditionalFieldsHandlersManager`, extends `DefaultPluginManager`,
  implements `FallbackPluginManagerInterface`).
- Discovery dir: `src/Plugin/conditional_fields/handler/`
- Annotation: `@ConditionalFieldsHandler` (`src/Annotation/ConditionalFieldsHandler.php`) — only
  field is `id`.
- Interface: `ConditionalFieldsHandlersPluginInterface`; base class:
  `ConditionalFieldsHandlerBase`.
- Alter hook: `hook_handler_info_alter()` (the manager calls `alterInfo('handler_info')`).

Handler ids follow `states_handler_{widget}` and are resolved from the dependent field's widget
type; unmatched widgets fall back to the default handler (`DefaultStateHandler` /
`states_handler_string_textfield`).

## Skeleton
```php
namespace Drupal\my_module\Plugin\conditional_fields\handler;

use Drupal\conditional_fields\ConditionalFieldsHandlerBase;

/**
 * @ConditionalFieldsHandler(
 *   id = "states_handler_my_widget",
 * )
 */
class MyWidget extends ConditionalFieldsHandlerBase {

  /**
   * Build the #states fragment for this widget.
   *
   * @return array
   *   A states array keyed by state, e.g. ['visible' => [$selector => ['value' => $v]]].
   */
  public function statesHandler($field, $field_info, $options) {
    $state = [];
    // Read $options['state'], ['condition'], ['selector'], ['value'|'values'],
    // ['values_set'] (WIDGET/AND/OR/XOR/NOT/REGEX) and shape the selector value
    // your widget expects.
    return $state;
  }
}
```
Built-in handlers to model against: `Select`, `Checkbox`, `OptionsButtons`, `EntityReference`,
`Number`, `DateDefault`, `LinkField`, `TextDefault`.
