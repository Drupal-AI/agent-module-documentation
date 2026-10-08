# plugins — the `AiAssistantAction` plugin type

This module defines **one** plugin type: **`AiAssistantAction`** — a piece of Drupal logic
an assistant can plan for, trigger, and feed results back from.

| | |
|---|---|
| Attribute | `#[AiAssistantAction]` (`src/Attribute/AiAssistantAction.php`) |
| Plugin namespace | `Plugin/AiAssistantAction` (in any module) |
| Interface | `AiAssistantActionInterface` |
| Base class | `Base\AiAssistantActionBase` |
| Manager service | `ai_assistant_api.action_plugin.manager` (`AiAssistantActionPluginManager`) |
| Alter hook | `hook_ai_assistant_action_info_alter()` |

An assistant only runs actions whose plugin id is listed in its `actions_enabled` field.

## Attribute — the id pattern gotcha

`#[AiAssistantAction(id, label, deriver?)]`. Per the attribute docs, the `id` must equal
its group or be prefixed with it, e.g. group `foo` → id `foo` **or** `foo:bar`. A
mismatched id makes the plugin undiscoverable.

## Interface contract

`AiAssistantActionInterface extends PluginFormInterface, ConfigurableInterface`. The base
class implements the setters and storage helpers; you typically override:

| Method | Purpose |
|---|---|
| `listActions(): array` | the actions this plugin exposes (id → label/description) |
| `listUsageInstructions(): array` | text injected into the system prompt so the LLM knows how to use it |
| `listContexts(): array` | contexts made available to the assistant |
| `provideFewShotLearningExample(): array` | few-shot examples teaching the trigger format |
| `getFunctionCallSchema(): array` | parameter schema when function calling is on (base returns `action` + `query`) |
| `triggerAction(string $action_id, array $parameters): void` | **do the work** |
| `triggerRollback(): void` | undo a state change if a later step fails |

Injected by the runner before `triggerAction()`: `setAssistant()`, `setAiProvider()`
(an AI Core provider proxy), `setThreadId()`, `setMessages()` (conversation history).

## Base helpers (`AiAssistantActionBase`)

Extend the base (it wires `create()` with `tempstore.private`) and use its tempstore-backed
helpers to communicate results back to the model:

- `setOutputContext($key, $text)` — text merged into the next model turn as action results.
- `storeActionContext($key, $data)` / `getActionContext($key)` — persist context across a
  `session` thread.
- `setStructuredResults($key, $array)` / `setOutputTokens($key, $val)` — structured output
  and replaceable output tokens.

## Skeleton

```php
namespace Drupal\my_module\Plugin\AiAssistantAction;

use Drupal\ai_assistant_api\Attribute\AiAssistantAction;
use Drupal\ai_assistant_api\Base\AiAssistantActionBase;
use Drupal\Core\StringTranslation\TranslatableMarkup;

#[AiAssistantAction(
  id: 'my_module',
  label: new TranslatableMarkup('My action'),
)]
class MyAction extends AiAssistantActionBase {

  public function listActions(): array {
    return ['do_thing' => ['label' => 'Do thing', 'description' => '…']];
  }

  public function listUsageInstructions(): array {
    return ['Call do_thing when the user asks to …'];
  }

  public function triggerAction(string $action_id, array $parameters = []): void {
    // …do work…
    $this->setOutputContext('my_module', 'Done: ' . $parameters['query']);
  }

  // PluginFormInterface / ConfigurableInterface methods as needed.
}
```

Enable the action on an assistant by adding its id to `actions_enabled`
(see [../configure/ai_assistant_api.md](../configure/ai_assistant_api.md)).
