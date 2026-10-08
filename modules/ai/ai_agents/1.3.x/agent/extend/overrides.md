# Tweak an agent without forking — `ai_agent_override`

`ai_agent_override` is a config entity (`config_prefix: ai_agent_override`,
`src/Entity/AiAgentOverride.php`) that layers changes onto a parent `ai_agent`: add/remove
tools and modify its prompt, without editing (or forking) the original. Applied by
`ai_agents.override_applier` (`Service\AiAgentOverrideApplier`).

Use it to adapt a shipped agent (e.g. one of the default triage agents) to your site while
keeping the original intact and update-safe.

```
drush config:get ai_agent_override.<id>
```

Manage overrides through the same modeler_api UI as agents. For structural facts inspect
`web/modules/contrib/ai_agents/src/Entity/AiAgentOverride.php` (its `config_export` keys
define exactly what an override can change).
