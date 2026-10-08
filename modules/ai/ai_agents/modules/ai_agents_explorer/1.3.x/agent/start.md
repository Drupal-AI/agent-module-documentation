# ai_agents_explorer — agent start

Submodule of [ai_agents](../../../ai_agents/1.3.x/agent/start.md). Interactive UI to run/debug
agents. No config screen (no `configure` route).

- **Run/debug UI:** `/admin/config/ai/agents/explore` (route `ai_agents_explorer.explorer`,
  form `AiAgentExplorerForm`). Backing endpoints: `.../explore/start` (POST),
  `.../explore/poll/{uuid}` (GET). All require `use the agent explorer`.
- **Stores runs as** `ai_agent_decision` content entities (`base_table ai_agent_decision`,
  admin permission `administer ai_agent_decision`).
- **Permissions:** `use the agent explorer`, `administer ai_agent_decision`.
- **Service:** `ai_agents_explorer.post_request_subscriber` logs each run.

Needs a configured AI provider (API key) in AI Core. For agent definition/tools see the
parent module's docs.
