# Write an `AiAgent` plugin (code agent)

For agents whose logic is code rather than config, implement the `AiAgent` plugin type.
(Most agents are config entities — see [../configure/agents.md](../configure/agents.md) —
use a plugin when you need custom PHP behaviour.)

- Namespace: `Plugin/AiAgent`
- Attribute: `Drupal\ai_agents\Attribute\AiAgent` (attribute-based discovery)
- Interface: `Drupal\ai_agents\PluginInterfaces\AiAgentInterface`
- Manager: `plugin.manager.ai_agents`
- Bundled examples: `src/Plugin/AiAgent/ContentType.php`, `FieldType.php`, `TaxonomyAgent.php`
  (6 plugins total on a stock install)

```php
namespace Drupal\mymodule\Plugin\AiAgent;

use Drupal\ai_agents\Attribute\AiAgent;
use Drupal\ai_agents\PluginBase\AiAgentEntityWrapper;   // or implement AiAgentInterface directly
use Drupal\Core\StringTranslation\TranslatableMarkup;

#[AiAgent(
  id: 'my_agent',
  label: new TranslatableMarkup('My agent'),
)]
class MyAgent extends AiAgentEntityWrapper {
  // Implement the AiAgentInterface methods: id/label, the tools it offers,
  // how it builds its prompt, and how it processes the model's tool calls.
}
```

Validate an agent's output with an `AiAgentValidation` plugin (namespace
`Plugin/AiAgentValidation`, attribute `Drupal\ai_agents\Attribute\AiAgentValidation`,
manager `plugin.manager.ai_agent_validation`). Inspect the base classes in
`web/modules/contrib/ai_agents/src/Plugin/AiAgent/` before implementing.
