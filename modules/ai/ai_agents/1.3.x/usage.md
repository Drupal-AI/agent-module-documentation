AI Agents makes a Drupal site "taskable" by AI: it provides a framework where configurable agents use function-call "tools" to inspect the site and perform real actions — creating content types, fields, taxonomy, and more — driven by any AI provider.

---

An **agent** is defined either as an `ai_agent` config entity (with a system prompt, an allowed set of tools, tool/usage limits, optional orchestration and triage sub-agents, and an optional structured-output schema) or as an `AiAgent` code plugin. When run, an agent loops: it sends the task and its available tools to an AI model, receives tool calls, executes them against Drupal, and feeds results back until the task is done. The tools themselves are `AiFunctionCall` plugins (a type defined by the `ai` core module); AI Agents ships dozens — e.g. create/edit content types, create field storage/config, list entity types — and other modules can add more. It depends on `ai` (AI Core, which talks to the providers) and `modeler_api` (which supplies the admin UI for editing agents, optionally with BPMN diagrams via `bpmn_io`). Ships three ready-to-use triage agents (content-type, field, taxonomy) as default config. An `ai_agent_override` config entity lets you tweak an existing agent's prompt and tool set without forking it. A validation plugin type (`AiAgentValidation`) checks agent output, and an event system exposes the full request/response/tool lifecycle. Submodules add an interactive Explorer for running/debugging agents, extra experimental agents (Views, Webform, module enabling), and a form-based UI to generate configuration with AI. Running agents requires a configured AI provider in AI Core (an API key). It turns natural-language instructions into concrete site-building operations.

---

- Let an AI agent create a new content type from a plain-English description.
- Add fields to an entity type by asking an agent.
- Generate a taxonomy vocabulary and terms via an agent.
- Build a Webform from a description (with ai_agents_extra).
- Create a Drupal View through the Views agent (experimental).
- Enable a module on request via the ModuleEnable agent (experimental).
- Define a custom agent as an `ai_agent` config entity with its own prompt + tools.
- Restrict which tools an agent may call (least-privilege agent config).
- Set per-tool usage limits / max loop counts to bound an agent run.
- Compose agents: a triage/orchestration agent that delegates to sub-agents.
- Override an existing agent's prompt/tools without forking (`ai_agent_override`).
- Write a custom `AiFunctionCall` tool so agents can perform your module's actions.
- Write a custom `AiAgent` plugin for a bespoke workflow.
- Add output validation with an `AiAgentValidation` plugin.
- Run and debug an agent interactively in the Agent Explorer.
- Inspect an agent's recorded decisions (ai_agent_decision entities).
- Drive site configuration from natural language in a form (form integration).
- Expose an agent as a CKEditor AI action.
- Expose an agent as an AI Assistant action.
- Subscribe to agent lifecycle events (request/response/tool start/finish).
- Build a structured-output agent that returns JSON matching a schema.
- Add guardrails to an agent via a guardrail set.
- Edit agents visually as BPMN diagrams (with bpmn_io).
- Give content teams an AI helper that safely performs Drupal admin tasks.
- Prototype site structure quickly by describing it to an agent.
