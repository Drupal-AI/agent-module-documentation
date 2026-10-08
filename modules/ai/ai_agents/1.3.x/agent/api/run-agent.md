# Run an agent from code

Agents are executed through the `plugin.manager.ai_agents` manager and the
`ai_agents.agent_helper` service. **Running an agent calls an AI provider, so AI Core must
have a configured provider + API key** (`ai` module) or the run will fail.

- `plugin.manager.ai_agents` — load/instantiate an agent plugin (config-entity agents are
  wrapped as plugins).
- `ai_agents.agent_helper` (`Service\AgentHelper`) — decodes prompts, applies config,
  dispatches validation, and drives the tool-calling loop.
- `ai_agents.field_agent_helper` — helper for field creation/introspection agents.
- `ai_agents.artifact_helper` / `ai_agents.artifact_storage` — collect run artifacts.

```php
/** @var \Drupal\Component\Plugin\PluginManagerInterface $mgr */
$mgr = \Drupal::service('plugin.manager.ai_agents');
$agent = $mgr->createInstance('content_type_agent_triage'); // a config-entity agent id
// Configure the agent with the task/prompt + chosen AI provider, then run its
// solve/execute loop. Inspect AgentHelper + AiAgentInterface for the exact calling
// convention (it evolves between minor versions).
```

Because the exact method names on `AiAgentInterface`/`AgentHelper` vary by version, read
`web/modules/contrib/ai_agents/src/Service/AgentHelper.php` and
`src/PluginInterfaces/AiAgentInterface.php` for the current signatures. For interactive
runs use the **Agent Explorer** submodule instead of wiring this by hand.
