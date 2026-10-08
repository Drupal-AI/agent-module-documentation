# Write a Tool plugin

A tool is a class in `<your_module>/src/Plugin/tool/Tool/` extending `ToolBase` with a `#[Tool]`
attribute. Manager: `plugin.manager.tool` (`Drupal\tool\Tool\ToolManager`); interface
`ToolInterface`; attribute `Drupal\tool\Attribute\Tool`; alter hook `hook_tool_info_alter()`.

## Complete example

```php
namespace Drupal\my_module\Plugin\tool\Tool;

use Drupal\Core\Access\AccessResult;
use Drupal\Core\Access\AccessResultInterface;
use Drupal\Core\Plugin\Context\ContextDefinition;
use Drupal\Core\Session\AccountInterface;
use Drupal\Core\StringTranslation\TranslatableMarkup;
use Drupal\tool\Attribute\Tool;
use Drupal\tool\ExecutableResult;
use Drupal\tool\Tool\ToolBase;
use Drupal\tool\Tool\ToolOperation;
use Drupal\tool\TypedData\InputDefinition;

#[Tool(
  id: 'greeting_tool',                       // see id/group rule below
  label: new TranslatableMarkup('Greeting Tool'),
  description: new TranslatableMarkup('Generates a greeting message.'),
  operation: ToolOperation::Transform,       // Explain | Read | Transform | Trigger | Write
  destructive: FALSE,                        // hint callers to confirm before running
  input_definitions: [
    'name' => new InputDefinition(
      data_type: 'string',
      label: new TranslatableMarkup('Name'),
      description: new TranslatableMarkup('The name to greet.'),
    ),
    'greeting' => new InputDefinition(
      data_type: 'string',
      label: new TranslatableMarkup('Greeting'),
      description: new TranslatableMarkup('The greeting to use.'),
      required: FALSE,
    ),
  ],
  output_definitions: [
    'message' => new ContextDefinition(
      data_type: 'string',
      label: new TranslatableMarkup('Message'),
      description: new TranslatableMarkup('The generated message.'),
    ),
  ],
)]
final class GreetingTool extends ToolBase {

  protected function doExecute(array $values): ExecutableResult {
    $message = ($values['greeting'] ?? 'Hello') . ', ' . $values['name'] . '!';
    return ExecutableResult::success(
      new TranslatableMarkup('Greeting generated.'),
      ['message' => $message],           // keys must match output_definitions
    );
  }

  protected function checkAccess(array $values, AccountInterface $account, bool $return_as_object = FALSE): bool|AccessResultInterface {
    // Enforce whatever permission/entity access this action needs.
    return $return_as_object ? AccessResult::allowed() : TRUE;
  }
}
```

Only two methods are abstract on `ToolBase`: `doExecute(array $values): ExecutableResult` and
`checkAccess(array $values, AccountInterface $account, bool $return_as_object = FALSE)`. `ToolBase`
is `final __construct` (DI: `current_user`, `event_dispatcher`) — override `create()`, not the
constructor, if you need extra services.

## `#[Tool]` attribute fields

| Field | Meaning |
|---|---|
| `id` | Plugin id. **Constraint:** must equal the group or be `group:suffix` (e.g. group `foo` → id `foo` or `foo:bar`); other patterns silently fail to register. |
| `label`, `description` | `TranslatableMarkup`. |
| `operation` | `ToolOperation` enum. `isModifying()` TRUE for `Write`/`Trigger`; `isIdempotent()` TRUE for `Explain`/`Read`. Callers use this to decide confirmation/retry. |
| `destructive` | Bool hint; encourages confirmation (does not block execution). |
| `input_definitions` | Map of name → `InputDefinition` (or `ListInputDefinition`/`MapInputDefinition`/`EntityInputDefinition`). |
| `input_definition_refiners` | Map of input → dependency inputs; requires the class to implement `InputDefinitionRefinerInterface` (else the definition throws). Lets one input's definition be recomputed from others' values. |
| `output_definitions` | Map of name → core `ContextDefinition` (or `EntityContextDefinition`). Leave empty to auto-fill from inputs. |
| `deriver` | Optional deriver class. |
| `forms` | Map of form-op → form class/`FALSE`. `configure` and `execute` default to the module's generic forms if unset (see `ToolManager::processDefinition`). |

## Input definitions

`InputDefinition($data_type, $label, $description, $required = TRUE, $multiple = FALSE, $default_value = NULL, $constraints = [], $locked = FALSE)`.
Wraps core Typed Data. Variants:

- `ListInputDefinition(..., item_definition: <InputDefinition>)` — a typed list.
- `MapInputDefinition(..., property_definitions: [name => InputDefinition, …])` — a keyed map.
- `EntityInputDefinition($data_type, …)` — e.g. `data_type: 'entity:node'`; extends
  `EntityContextDefinition`.
- Factories: `InputDefinition::fromConfigSchema($schema)`, `InputDefinition::fromDataDefinition($def)`.
- `setLocked(TRUE)` hides an input from the advertised definitions (`getInputDefinitions()` excludes
  locked unless `$include_locked`), while still accepting/using it internally.

## Results — `ExecutableResult`

- `ExecutableResult::success(TranslatableMarkup $message, array $context_values = [])`
- `ExecutableResult::failure(TranslatableMarkup $message, array $context_values = [])`

`ToolBase::execute()` calls `doExecute()`, catches `\Throwable` into an `ExecutableResult::failure`,
and — on success — copies each returned context value whose key matches an `output_definition` into
the tool's typed outputs. Read them with `getResultStatus()`, `getResultMessage()`,
`getOutputValues()`, or the invoker-formatted `getFormattedResult()`.

## Validation constraint

The module ships a `FieldExists` validation constraint
(`Plugin/Validation/Constraint/FieldExistsConstraint`) — attach it to a string input that must name
an existing field.

## Adapters (`tool.typed_data_adapter` plugin type)

To teach the framework a new value type (schema generation, validation, coercion, JSON-Schema
mapping), add a plugin in `Plugin/tool/TypedData/Adapter/` (manager
`plugin.manager.tool.typed_data_adapter`, base `TypedDataAdapterBase`, attribute
`Attribute\TypedDataAdapter`). Core ships adapters for boolean, string, text, email, number, list,
map, select, entity, undefined.
