# api — run automators from code & expose them as tools

## Automatic generation on save (no code)
The `.module` wires field generation into the entity lifecycle:
`hook_entity_presave`, `hook_entity_insert`, and `hook_entity_update` run any `ai_automator`
configured for that entity/bundle. So for normal content you configure the automator (see
[../configure/ai_automators.md](../configure/ai_automators.md)) and just save the entity —
generation happens via services `ai_automator.entity_modifier`
(`AiAutomatorEntityModifier`) and `ai_automator.rule_runner` (`AiAutomatorRuleRunner`).

## Run a reusable automator chain programmatically
Build a chain by creating an `automator_chain_type` bundle with automated fields, then run it
with the `ai_automator.automate` service (`Drupal\ai_automators\Service\Automate`):

```php
/** @var \Drupal\ai_automators\Service\Automate $automate */
$automate = \Drupal::service('ai_automator.automate');

$automate->getWorkflows();                  // [chain_type_id => label]
$automate->getRequiredFields($type);        // required input fields for a chain type
$automate->getAutomatedFields($type);       // fields that carry an automator (the outputs)

// Create a disposable automator_chain entity, set inputs, run, return generated outputs.
$output = $automate->run($type, [
  'field_source_text' => 'Some input text',
]);
// $output => [output_field_name => value, ...]; the temporary chain entity is deleted after.
```

`run()` throws `AiAutomatorTypeNotFoundException` (unknown chain type) or
`AiAutomatorTypeNotRunnable` (the chain entity could not be saved).

## Expose an automator workflow as an AI agent tool
An `automators_tool` config entity wraps a workflow; ai_automators registers the
`automators_tools` **function group** (`src/Plugin/AiFunctionGroup/AutomatorTools.php`, AI
Core's `#[FunctionGroup]` plugin type) so agents/function-calling can invoke it. Create the
tool at `/admin/config/ai/ai-automators/automators-tool`.

## Other services (from ai_automators.services.yml)
| Service | Class | Role |
|---|---|---|
| `ai_automator.field_rules` | `AiFieldRules` | resolves/loads `AiAutomatorType` rules |
| `ai_automator.rule_runner` | `AiAutomatorRuleRunner` | executes a rule against an entity field |
| `ai_automator.entity_modifier` | `AiAutomatorEntityModifier` | applies automators during entity save |
| `ai_automator.prompt_helper` | `AiPromptHelper` | renders prompts (Twig + tokens) |
| `ai_automator.status_field` | `AiAutomatorStatusField` | manages the `ai_automator_status` field |
| `ai_automator.rule_helper.general` / `.file` | `GeneralHelper` / `FileHelper` | shared rule helpers |
| `ai_automator.automate` | `Automate` | run a chain programmatically (above) |
| `ai_automators.cleanup` | `AiAutomatorCleanupService` | removes orphaned automators |

To alter a run rather than trigger one, use the events in [../extend/ai_automators.md](../extend/ai_automators.md).
