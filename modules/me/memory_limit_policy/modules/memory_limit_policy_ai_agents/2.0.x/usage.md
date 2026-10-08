<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Memory Limit Policy AI Agents lets an AI agent manage memory limit policies and their constraints through natural language, by registering a set of `AiFunctionCall` tools and a ready-made `ai_agent` config entity ("Memory Limit Policy Agent") for the AI Agents module.

---

This submodule bridges Memory Limit Policy with `drupal/ai_agents`. It registers 15 `AiFunctionCall` plugins (ids prefixed `ai_agent:`) that an LLM can invoke: information tools (`list_memory_limit_policies`, `get_memory_limit_policy_info`, `list_constraint_types`, `get_constraint_schema`, `get_module_settings`) and modification tools (`create_memory_limit_policy`, `edit_memory_limit_policy`, `delete_memory_limit_policy`, `enable_memory_limit_policy`, `disable_memory_limit_policy`, `set_policy_weight`, `add_policy_constraint`, `remove_policy_constraint`, `set_module_settings`). Each tool is an executable function call that operates on the `memory_limit_policy` entity storage and enforces the `administer memory limit policies` permission. It ships a preconfigured `ai_agent` config entity `memory_limit_policy_agent` (a triage agent, `max_loops: 5`) wired to all these tools with a domain system prompt. A `ConstraintSchemaDiscovery` service (`memory_limit_policy_ai_agents.constraint_schema_discovery`) introspects each constraint plugin's configuration form so the agent can discover the required fields for any constraint type dynamically. It requires the `ai_agents` module to be installed.

---

- Create a memory limit policy from a plain-English request ("give editors 512M on admin pages").
- Ask the agent to list all configured memory limit policies and their status.
- Have the agent add a constraint (role, path, HTTP method, etc.) to an existing policy.
- Let the agent discover which constraint types are available on the site.
- Ask for the configuration schema of a specific constraint type before configuring it.
- Enable or disable a policy by name via the agent.
- Reorder policies by setting weights through natural language.
- Remove a constraint from a policy by index.
- Toggle the debug-header module setting via the agent.
- Query a single policy's details (memory, weight, status, constraints).
- Build multi-constraint policies conversationally (path AND role AND query param).
- Use the shipped "Memory Limit Policy Agent" as a triage agent in an AI Assistant.
- Let a non-developer manage performance tuning without touching config forms.
- Have the agent negate a constraint when the user asks for "except" conditions.
- Automate policy creation as part of a larger AI-driven site setup flow.
- Inspect module settings (debug headers) through the agent.
- Delete an obsolete policy by name.
- Combine with other AI Agents tools in an orchestrated workflow.
- Prototype memory policies quickly during development via chat.
- Expose memory tuning to an AI chatbot backed by the AI module.
