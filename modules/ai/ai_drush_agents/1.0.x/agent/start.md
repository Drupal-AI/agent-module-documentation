<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Drush Agents (ai_drush_agents) — agent index

Drush commands that run **AI Agents** (from `ai_agents`) interactively in the terminal, plus two
ready-made agents (Drush-command explainer, config-export explainer) and the tool plugins they use.
Package **AI Tools**. Core `^10.3 || ^11`. License GPL-2.0-or-later. Version 1.0.0-alpha2.

- **Commands, the two bundled agents, and how to run them** → [commands/drush.md](commands/drush.md)
- **The four AiFunctionCall tool plugins the agents call** → [plugins/function_calls.md](plugins/function_calls.md)

## Dependencies

- Drupal module `ai_agents` (which pulls in `ai`). A working AI **provider** must be configured
  through that stack or the commands return nothing.
- Composer: `drupal/ai_agents ^1.1.0`, `sevenecks/markdown-terminal ^0.0.1` (terminal markdown rendering).

## What it provides (all from source)

- **3 Drush command classes** (registered in `drush.services.yml`), no HTTP routes, no permissions,
  no config schema of its own:
  - `Commands\AiAgentCommands` — `agents:run` (alias `agent`): pick/`createInstance()` an
    `ai_agent` entity and chat in a loop (`processAgent()`), rendering replies via `MarkdownTerminal`.
  - `Commands\AiDrushExplainerCommands` — `agents:drush_explain` (alias `agedre`): runs the
    `drush_explain_agent`.
  - `Commands\AiConfigExplainCommands` — `agents:config_export_explain` (alias `agecex`): runs the
    `config_export_explainer` agent.
- **2 `ai_agent` config entities** installed on enable (`config/install/…`), removed on uninstall
  (`ai_drush_agents.install`): `drush_explain_agent`, `config_export_explainer`.
- **4 `AiFunctionCall` plugins** in `src/Plugin/AiFunctionCall/` (`group: information_tools`):
  `GetDrushCommands` (`ai_drush_agents:get_drush_commands`), `GetDrushCode`
  (`ai_drush_agents:get_drush_code`), `GetConfigEntity` (`ai_agent:get_config_entity`),
  `ConfigDiff` (`ai_drush_agents:config_diff`).

## Operating notes

- `agents:run` sets the acting account to user 1 before running the selected agent
  (`AiAgentCommands::runAgent()`), so agents execute with full privileges — this is a CLI
  developer/operator tool.
- Uninstall deletes both shipped `ai_agent` config entities (see `ai_drush_agents_uninstall()`).
