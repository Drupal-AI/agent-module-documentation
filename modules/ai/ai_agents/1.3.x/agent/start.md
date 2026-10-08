# ai_agents — agent start

Framework that lets AI agents perform Drupal actions via function-call **tools**. Depends on
`ai` (AI Core — provider access; needs an API key to actually run) + `modeler_api` (agent
admin UI). Agents are edited through modeler_api / the Explorer submodule; there is **no**
`configure` route in this module. Ships 3 default triage agents (content-type, field,
taxonomy).

- Define/edit an agent (`ai_agent` config entity) → [configure/agents.md](configure/agents.md)
- Write an `AiAgent` plugin (code agent) → [plugins/ai-agent.md](plugins/ai-agent.md)
- Write a tool an agent can call (`AiFunctionCall`) → [plugins/function-call-tool.md](plugins/function-call-tool.md)
- Tweak an existing agent without forking (`ai_agent_override`) → [extend/overrides.md](extend/overrides.md)
- Run an agent from code → [api/run-agent.md](api/run-agent.md)
- Hook the agent lifecycle (events) → [extend/events.md](extend/events.md)
- Permissions → [permissions/permissions.md](permissions/permissions.md)

Submodules (own docs): `ai_agents_explorer` (run/debug UI), `ai_agents_extra` (Views/Webform/
Module agents), `ai_agents_form_integration` (AI-assisted config forms), `ai_agents_extra_tools`
(deprecated). Tools are `AiFunctionCall` plugins — that plugin *type* lives in the `ai` core
module; ai_agents ships ~67 of them.
