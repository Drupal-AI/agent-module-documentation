# Write a tool an agent can call (`AiFunctionCall`)

Agents act through **tools**. A tool is an `AiFunctionCall` plugin — that plugin *type* is
defined by the **`ai` core module** (manager `plugin.manager.ai.function_calls`), not by
ai_agents. ai_agents ships ~67 such tools in `src/Plugin/AiFunctionCall/` (e.g.
`CreateContentType`, `EditContentType`, `CreateFieldStorageConfig`, `ListEntityTypes`,
plus an `AiAgentWrapper` that exposes an agent as a callable tool).

- Namespace: `Plugin/AiFunctionCall`
- Manager: `plugin.manager.ai.function_calls` (from `ai` core)
- ai_agents alters tool metadata via `hook_ai_function_call_info_alter()`.

```php
namespace Drupal\mymodule\Plugin\AiFunctionCall;

use Drupal\ai\Attribute\FunctionCall;
use Drupal\ai\Base\FunctionCallBase;
use Drupal\ai\Service\FunctionCalling\ExecutableFunctionCallInterface;

#[FunctionCall(
  id: 'mymodule:do_thing',
  function_name: 'do_thing',
  name: 'Do thing',
  description: 'Performs my module action.',
  // 'context_definitions' declares the typed parameters the model must supply.
)]
class DoThing extends FunctionCallBase implements ExecutableFunctionCallInterface {
  public function execute() { /* read $this->getContextValue(...); do work */ }
  public function getReadableOutput(): string { /* result text back to the model */ }
}
```

Reference the exact base class / attribute in the `ai` module
(`web/modules/contrib/ai/src/`) and copy an existing tool in
`web/modules/contrib/ai_agents/src/Plugin/AiFunctionCall/` as a template. Add the new tool
id to an agent's `tools` list to let it use it ([../configure/agents.md](../configure/agents.md)).
