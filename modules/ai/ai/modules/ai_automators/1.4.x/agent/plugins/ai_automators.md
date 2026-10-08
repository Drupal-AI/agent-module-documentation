# plugins — the two plugin types AI Automators defines

Both are attribute-based (attributes in `src/Attribute/`). Discover with the manager service;
implement by adding a class under `src/Plugin/<Type>/` in your module.

| Plugin type | Attribute | Namespace | Interface | Manager service | Alter hook | Purpose |
|---|---|---|---|---|---|---|
| Automator Type (the **rule**) | `#[AiAutomatorType]` | `Plugin/AiAutomatorType` | `AiAutomatorTypeInterface` | `plugin.manager.ai_automator` (`AiAutomatorTypeManager`) | `hook_ai_automator_type_alter` | Generates/amends a field value for one field type. This is what you write to support a new field or a new generation strategy. |
| Process Rule (the **worker type**) | `#[AiAutomatorProcessRule]` | `Plugin/AiAutomatorProcess` | `AiAutomatorFieldProcessInterface` | `plugin.manager.ai_processor` (`AiAutomatorFieldProcessManager`) | `hook_ai_automator_process_alter` | Decides *how/when* a field is processed (direct, queue, batch, action, widget button). Rarely custom-written. |

## `#[AiAutomatorType]` attribute parameters
- `id` — plugin id. Must equal the group or be prefixed `group:sub` (e.g. `llm_string`).
- `label` — `TranslatableMarkup`, shown in the field's automator dropdown.
- `field_rule` — the **target field type** this rule handles (e.g. `string`, `text_long`,
  `image`, `entity_reference`, `taxonomy_term`). A rule only appears for matching fields.
- `target` — (optional) target entity type, for `entity_reference` / `file` rules; `''` otherwise.
- `deriver` — (optional) deriver class.

## Writing an Automator Type rule
Extend a base class from `src/PluginBaseClasses/` (they implement the interface's boilerplate
and the AI Core calls). Common bases: `RuleBase` (generic), `ComplexTextChat` /
`SimpleTextChat` (prompt→text via the `chat` operation), `EntityReference`, `Taxonomy`,
`ImageAltText`, `TextToImage`, `AudioToText`, `Lists`, `Options`, `Address`, `TextToJsonField`.

```php
namespace Drupal\my_module\Plugin\AiAutomatorType;

use Drupal\Core\StringTranslation\TranslatableMarkup;
use Drupal\ai_automators\Attribute\AiAutomatorType;
use Drupal\ai_automators\PluginBaseClasses\ComplexTextChat;
use Drupal\ai_automators\PluginInterfaces\AiAutomatorTypeInterface;

#[AiAutomatorType(
  id: 'llm_string',
  label: new TranslatableMarkup('LLM: Text'),
  field_rule: 'string',
  target: '',
)]
class MyStringRule extends ComplexTextChat implements AiAutomatorTypeInterface {
  public $title = 'LLM: Text';
  // Override generate()/needsPrompt()/generateResponse() etc. as needed.
}
```

Key interface methods you may override: `needsPrompt()`, `advancedMode()`, `helpText()`,
`allowedInputs()`, `placeholderText()`, `tokens()`, `generate()` (produce raw values),
`verifyValue()`, `storeValues()`. Optional marker interfaces in `src/PluginInterfaces/`:
`AiAutomatorDirectProcessInterface` (allow direct/live processing),
`AiAutomatorPostCheckIfEmptyInterface` (custom "is this value empty?" logic for non-`RuleBase`
rules — return `[]` to force re-processing).

Scaffold one with `drush generate plugin:ai:automator-type` — see [../drush/ai_automators.md](../drush/ai_automators.md).

## Shipped worker types (`Plugin/AiAutomatorProcess/`)
`DirectSaveProcessing`, `QueueWorkerProcessor`, `BatchProcessing`, `ActionProcessing`,
`FieldWidgetProcessing`. These are the "worker type" options selectable per automator; write a
new `#[AiAutomatorProcessRule]` plugin only to add a genuinely new execution strategy.

## Shipped rules (examples, not exhaustive)
Dozens live in `src/Plugin/AiAutomatorType/`: `LlmString`, `LlmTextLong`,
`LlmTextCreateSummary`, `LlmImageAltText`, `LlmTaxonomy`, `LlmEntityReference`,
`LlmMediaImageGeneration`, `LlmAudioToTextLong`, `VectorSearchEntityReference`,
`VectorSearchText`, `LlmMetatag`, `LlmAddress`, `LlmJsonField`, `LlmOfficeHours`,
`ViewsExtractor`, `LlmModerationState`, `LlmVideoToHtml`, … Read one alongside its base class
to copy the closest pattern.
