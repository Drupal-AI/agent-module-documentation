<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Agent Memory — settings, config object, route

## Install / enable

Requires the `ai`, `ai_agents`, and `ai_assistant_api` projects (composer: `drupal/ai ^1.3`,
`drupal/ai_agents ^1.2`, `drupal/ai_assistant_api ^1.3`). Enabling `ai_agent_memory` registers the
`AgentMemoryRunner` decorator over `ai_assistant_api.agent_runner`. **No agent gets persistent
memory until you opt it in** on the settings form — until then every agent uses the stock stateless
runner.

## Route & permission

`ai_agent_memory.routing.yml`:

- **`ai_agent_memory.settings`** — path `/admin/config/ai/agent-memory`, form
  `\Drupal\ai_agent_memory\Form\SettingsForm`, requirement `_permission: 'administer site
  configuration'`.

Menu link (`ai_agent_memory.links.menu.yml`): `ai_agent_memory.settings`, parent
`ai.admin_config_tools` (Configuration → AI). This is the module's only route.

## Config object `ai_agent_memory.settings`

Schema `config/schema/ai_agent_memory.schema.yml` (`type: config_object`), install defaults
`config/install/ai_agent_memory.settings.yml`:

| Key | Type | Default | Meaning |
| --- | --- | --- | --- |
| `enabled_agents` | sequence of string | `[]` | Agent plugin IDs that get persistent cross-turn state. Anything not listed passes through to the stock runner. |
| `max_history_messages` | integer | `100` | Total messages to keep in persisted state before trimming drops middle turns. |
| `keep_recent_turns` | integer | `5` | Number of recent conversation turns the trimmer always preserves. |

## SettingsForm

`src/Form/SettingsForm.php` — extends `ConfigFormBase`, form id `ai_agent_memory_settings`,
editable config `ai_agent_memory.settings`.

- `create()` injects `plugin.manager.ai_agents` with `NULL_ON_INVALID_REFERENCE` (the form still
  builds if the agent plugin manager is unavailable).
- `buildForm()`:
  - `enabled_agents` — a `checkboxes` element; options come from
    `$this->aiAgentPluginManager->getDefinitions()` (`$definition['label'] ?? $id`). If the manager
    is null, the options list is empty.
  - `max_history_messages` — `number`, `#min => 10`, required, default 100.
  - `keep_recent_turns` — `number`, `#min => 1`, required, default 5.
- `submitForm()` saves `array_values(array_filter(...))` of the checkboxes (so only checked agent
  IDs are stored) and casts the two numbers to `(int)`.

## Operating it

1. Enable the module.
2. Visit `/admin/config/ai/agent-memory`.
3. Check the agents that should keep state across turns.
4. Optionally tune `max_history_messages` / `keep_recent_turns`.
5. Save. Enabled agents now resume with prior context on each new turn; the rest are unchanged.

See [../services/memory-runner.md](../services/memory-runner.md) for how these values drive the
persistence state machine and trimming.
