<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AiFunctionCall tools, agent config, and schema discovery

## The function-call tools

Each tool is a `FunctionCall` plugin (from the `ai` module) in
`src/Plugin/AiFunctionCall/`, declared with the `#[FunctionCall(id: 'ai_agent:…', …)]`
attribute and implementing `ExecutableFunctionCallInterface` (`execute()` +
`getReadableOutput()`). Modification tools check
`currentUser->hasPermission('administer memory limit policies')`.

Information tools (`group: information_tools`):

| id | function_name | purpose |
|---|---|---|
| `ai_agent:list_memory_limit_policies` | list_memory_limit_policies | list policies (optionally include disabled) |
| `ai_agent:get_memory_limit_policy_info` | get_memory_limit_policy_info | details of one policy |
| `ai_agent:list_constraint_types` | list_constraint_types | all available constraint plugin types |
| `ai_agent:get_constraint_schema` | get_constraint_schema | config fields for a constraint type |
| `ai_agent:get_module_settings` | get_module_settings | read module settings (debug header) |

Modification tools (`group: modification_tools`):

| id | function_name | purpose |
|---|---|---|
| `ai_agent:create_memory_limit_policy` | create_memory_limit_policy | create a policy (policy_id, label, memory, status, weight) |
| `ai_agent:edit_memory_limit_policy` | edit_memory_limit_policy | change label/memory/status/weight |
| `ai_agent:delete_memory_limit_policy` | delete_memory_limit_policy | delete a policy |
| `ai_agent:enable_memory_limit_policy` | enable_memory_limit_policy | set status TRUE |
| `ai_agent:disable_memory_limit_policy` | disable_memory_limit_policy | set status FALSE |
| `ai_agent:set_policy_weight` | set_policy_weight | change evaluation weight |
| `ai_agent:add_policy_constraint` | add_policy_constraint | append a constraint (constraint_id + configuration) |
| `ai_agent:remove_policy_constraint` | remove_policy_constraint | remove a constraint by index |
| `ai_agent:set_module_settings` | set_module_settings | toggle the debug header setting |

`create_memory_limit_policy` context params: `policy_id` (machine name, regex
`/^[a-z0-9_]+$/`, required), `label` (required), `memory` (e.g. `256M`, required),
`status` (bool, default TRUE), `weight` (int, default 0). Its `execute()` calls the
`memory_limit_policy` storage `create([...])->save()` with `policy_constraints => []` — i.e. the
same end state as building the entity by hand.

## Shipped agent config entity

`config/install/ai_agents.ai_agent.memory_limit_policy_agent.yml` installs an `ai_agent`
config entity (id `memory_limit_policy_agent`): a **triage** agent (`triage_agent: true`,
`orchestration_agent: false`), `max_loops: 5`, with a memory-limit-policy system prompt and all
15 tools enabled under `tools:`. Read/modify it via the `ai_agent` entity storage or the config
`ai_agents.ai_agent.memory_limit_policy_agent`.

## Constraint schema discovery service

`memory_limit_policy_ai_agents.constraint_schema_discovery`
(`ConstraintSchemaDiscovery`, args `@plugin.manager.memory_limit_policy.memory_limit_constraint`,
`@entity_type.manager`, `@form_builder`) introspects each constraint plugin's configuration form
so `get_constraint_schema` / `list_constraint_types` can report the required fields for any
constraint type dynamically (including custom ones).

The underlying entity/constraint mechanics (policy fields, evaluation order, the
`MemoryLimitConstraint` plugin type) are documented in the parent module's `agent/` docs.
