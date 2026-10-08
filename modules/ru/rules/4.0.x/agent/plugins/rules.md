# Plugin types Rules defines & how to add one

Rules exposes several plugin types (each with its own manager service and namespace):

| Plugin type | Namespace | Manager service / class | IDs / notes |
|---|---|---|---|
| `RulesAction` | `Plugin/RulesAction` | `plugin.manager.rules_action` (`RulesActionManager`) | The actions a rule can run. Base `RulesActionBase`. Alter hook `rules_action_info`. |
| `Condition` | `Plugin/Condition` | `Drupal\rules\Core\ConditionManager` | Rules' condition plugins (extends core Condition). Base `RulesConditionBase`. |
| `RulesExpression` | `Plugin/RulesExpression` | `plugin.manager.rules_expression` (`ExpressionManager`) | The engine primitives: `rules_rule`, `rules_action_set`, `rules_action`, `rules_condition`, `rules_and`, `rules_or`, `rules_loop`. |
| `RulesEvent` | `Plugin/RulesEvent` + `*.rules.events.yml` | `plugin.manager.rules_event` (`RulesEventManager`) | Triggerable events; many are derived per entity type/bundle. |
| `RulesDataProcessor` | `Plugin/RulesDataProcessor` | `plugin.manager.rules_data_processor` (`DataProcessorManager`) | Transform action input: `rules_tokens`, `rules_numeric_offset`. |
| `RulesUi` | `*.rules_ui.yml` | `plugin.manager.rules_ui` (`RulesUiManager`) | Registers a UI host for embedded rules (reaction rules, components). |

All actions/conditions are **context-aware**: they declare `context_definitions` (typed_data
based) for inputs and optional `provides` for outputs. Both attribute (`#[RulesAction(...)]`)
and legacy annotation (`@RulesAction`) discovery are supported.

## Add a custom action

Put a class in `your_module/src/Plugin/RulesAction/`, extend `RulesActionBase`, declare context
with the `RulesAction` attribute, and implement `doExecute()` (the base `execute()` maps context
values to `doExecute()` arguments automatically). To inject services, implement
`ContainerFactoryPluginInterface`.

```php
namespace Drupal\your_module\Plugin\RulesAction;

use Drupal\Core\StringTranslation\TranslatableMarkup;
use Drupal\rules\Context\ContextDefinition;
use Drupal\rules\Core\Attribute\RulesAction;
use Drupal\rules\Core\RulesActionBase;

#[RulesAction(
  id: "mymodule_greet_user",
  label: new TranslatableMarkup("Greet a user"),
  category: new TranslatableMarkup("Custom"),
  context_definitions: [
    "account" => new ContextDefinition(
      data_type: "entity:user",
      label: new TranslatableMarkup("User"),
    ),
  ],
)]
class GreetUser extends RulesActionBase {

  protected function doExecute($account) {
    \Drupal::messenger()->addMessage(t('Hello, @name!', ['@name' => $account->getDisplayName()]));
  }
}
```

Actions that write back to an entity should list the variable in `autoSaveContext()` so Rules
saves it after execution. To supply output for later actions, declare `provides` and call
`$this->setProvidedValue()`.

## Add a custom condition

Class in `src/Plugin/Condition/`, extend `RulesConditionBase`, use the `Condition` attribute
(`Drupal\rules\Core\Attribute\Condition`), declare `context_definitions`, and implement
`evaluate()` returning a boolean. See built-ins like `DataComparison`, `EntityIsOfBundle`,
`UserHasRole` for patterns.

## Add a data processor

Class in `src/Plugin/RulesDataProcessor/` with the `RulesDataProcessor` attribute
(`Drupal\rules\Attribute\RulesDataProcessor`), implementing the processor interface's `process()`
to transform an input value before an action receives it (see `TokenProcessor`, `NumericOffset`).
