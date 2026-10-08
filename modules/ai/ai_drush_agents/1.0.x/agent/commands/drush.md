<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands & bundled agents

## Install & enable

```bash
composer require drupal/ai_drush_agents
drush en ai_drush_agents -y
```

Pulls in `ai_agents` + `ai`. You must configure an AI **provider** (default chat model) through the
`ai` module first, or every command returns empty output. Commands are registered in
`drush.services.yml` (tag `drush.command`); the module adds no routes, permissions, or UI.

## Commands

| Command | Alias | Class | What it does |
|---|---|---|---|
| `agents:run [agent_id]` | `agent` | `AiAgentCommands` | Interactive chat loop with any `ai_agent` entity. |
| `agents:drush_explain` | `agedre` | `AiDrushExplainerCommands` | Suggests the Drush command for a described task. |
| `agents:config_export_explain` | `agecex` | `AiConfigExplainCommands` | Explains the active-vs-staged config diff. |

### `agents:run` (`AiAgentCommands::runAgent`)

- With no `agent_id`, `selectAgent()` lists all `ai_agent` entities (`loadMultiple()`) and prompts a
  choice; with an id it `createInstance($agent_id)` on `plugin.manager.ai_agents`.
- Sets the current account to **user 1** (`entityTypeManager->getStorage('user')->load(1)` →
  `currentUser->setAccount()`) before running, so the agent runs with full privileges.
- `processAgent()` loops: `io()->ask('You')` → appends a `ChatMessage('user', …)` to chat history →
  `agent->setChatHistory()` → `determineSolvability()` → `agent->solve()`; the assistant reply is
  parsed by `SevenEcks\Markdown\MarkdownTerminal` and printed, then it recurses for the next turn.
  (There is no explicit exit command; end with Ctrl-C.)

### `agents:drush_explain` (`AiDrushExplainerCommands::exportExplain`)

- Prompts once (`io()->ask`), builds `createInstance('drush_explain_agent')`, sets a single-message
  `ChatInput`, runs `determineSolvability()` + `solve()`, renders markdown to the terminal.

### `agents:config_export_explain` (`AiConfigExplainCommands::exportExplain`)

- `createInstance('config_export_explainer')`, seeds the chat with `"Explain the config export"`,
  runs `solve()`, writes the answer out.

## Bundled agents (config entities, `config/install/`)

Both are `ai_agents.ai_agent.*` entities installed on enable and deleted on uninstall
(`ai_drush_agents_uninstall()`).

- **`drush_explain_agent`** — system prompt: a Drush specialist. Default information tool
  `ai_drush_agents:get_drush_commands` (full command list injected up front); tool
  `ai_drush_agents:get_drush_commands` enabled; `max_loops: 10`. (The `drush_explain_agent`
  system prompt also references reading command source — see `get_drush_code` in
  [../plugins/function_calls.md](../plugins/function_calls.md).)
- **`config_export_explainer`** — system prompt: explains what a config export will change.
  Default information tool `ai_drush_agents:config_diff` (the diff is injected into the prompt);
  tools `ai_agent:get_config_schema` and `ai_agent:get_config_entity` enabled so it can load a full
  config/schema when the diff is not enough; `max_loops: 3`.

## Add your own agent

Create any `ai_agent` config entity (via the `ai_agents` UI or config) and run it with
`drush agents:run <your_agent_id>` — no code needed. To give it CLI/config awareness, enable the
tool plugins documented in [../plugins/function_calls.md](../plugins/function_calls.md).
