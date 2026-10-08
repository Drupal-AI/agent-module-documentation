<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Memory Limit Policy AI Agents — agent index

Integrates Memory Limit Policy with `drupal/ai_agents`: registers 15 `AiFunctionCall` tools
(ids `ai_agent:*`) plus a shipped `ai_agent` config entity `memory_limit_policy_agent`. Lets an
LLM create/edit/query `memory_limit_policy` entities and their constraints. Requires the
`ai_agents` module. Enable with `drush en memory_limit_policy_ai_agents -y`.

- **The AiFunctionCall tools, the shipped agent config, and the schema-discovery service** →
  [plugins/ai-function-calls.md](plugins/ai-function-calls.md)

Key facts:
- Tools are `FunctionCall` plugins from the `ai` module (attribute `#[FunctionCall(...)]`),
  ids like `ai_agent:create_memory_limit_policy`; modification tools require permission
  `administer memory limit policies`.
- Shipped agent: config `ai_agents.ai_agent.memory_limit_policy_agent` (triage agent,
  `max_loops: 5`) — see the parent module for the underlying entity/constraint mechanics.
- This submodule defines **no** new plugin type and no constraint plugin; it only drives the
  parent's `memory_limit_policy` entities.
