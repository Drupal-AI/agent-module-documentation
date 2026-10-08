# Define / configure an agent (`ai_agent` config entity)

Agents are `ai_agent` config entities (`config_prefix: ai_agent`, admin permission
`administer ai_agent`, edited via `Form\AiAgentForm` through modeler_api / the Explorer
submodule). Ship them as `config/install/ai_agents.ai_agent.<id>.yml`, or manage with
`drush config:*`. The 3 defaults: `content_type_agent_triage`, `field_agent_triage`,
`taxonomy_agent_config`.

Key config_export keys:
- `system_prompt` — the agent's instructions.
- `tools` — the `AiFunctionCall` tool ids the agent may call.
- `tool_settings` / `tool_usage_limits` — per-tool config and call caps.
- `orchestration_agent`, `triage_agent` — compose/delegate to other agents.
- `max_loops` — bound the tool-calling loop.
- `structured_output_schema` — force JSON output matching a schema.
- `guardrail_set` — attach guardrails.

```yaml
# config/install/ai_agents.ai_agent.my_agent.yml
langcode: en
status: true
id: my_agent
label: 'My agent'
system_prompt: 'You help manage content types. Use the provided tools.'
tools:
  ai_agents:create_content_type: true
  ai_agents:list_entity_types: true
max_loops: 10
```

Inspect existing: `drush config:get ai_agents.ai_agent.content_type_agent_triage`.
Running an agent needs a provider configured in AI Core (an API key) — see
[../api/run-agent.md](../api/run-agent.md). To modify an agent you don't own, prefer an
override — see [../extend/overrides.md](../extend/overrides.md).
