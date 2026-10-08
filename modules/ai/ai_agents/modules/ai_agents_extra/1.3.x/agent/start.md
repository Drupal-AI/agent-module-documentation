# ai_agents_extra — agent start

Submodule of [ai_agents](../../../ai_agents/1.3.x/agent/start.md). **Experimental, hidden.**
Adds three `AiAgent` plugins (in `src/Plugin/AiAgent/`): `ViewsAgent`, `Webform`,
`ModuleEnable`. No config screen, routes, or permissions.

- These are code agents — see the parent's [plugins/ai-agent.md](../../../ai_agents/1.3.x/agent/plugins/ai-agent.md)
  for how the `AiAgent` plugin type works, and [configure/agents.md](../../../ai_agents/1.3.x/agent/configure/agents.md)
  to reference them from an agent's `tools`/orchestration.
- Webform agent is backed by `Service\WebformAgent\WebformActions`.
- Needs an AI provider (API key) in AI Core. APIs are unstable (experimental).
