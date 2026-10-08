A hidden, experimental submodule of AI Agents that adds extra `AiAgent` plugins — a Views agent, a Webform agent, and a Module-enable agent — for AI-driven building of those Drupal structures.

---

Where the parent `ai_agents` module ships agents for content types, fields, and taxonomy, `ai_agents_extra` extends the coverage with three more code-defined `AiAgent` plugins: a Views agent (build/modify Views), a Webform agent (generate webforms, backed by `Service\WebformAgent\WebformActions`), and a ModuleEnable agent (turn modules on). It is marked `lifecycle: experimental` and `hidden: true`, so it is intended for testing and early adopters rather than production. It depends only on `ai_agents` and adds no routes, permissions, or config of its own — just the plugins. Because these are agents, running them requires a configured AI provider in AI Core. Treat the APIs as unstable between releases.

---

- Ask an agent to create a Drupal View.
- Have an agent add a display or field to an existing View.
- Generate a Webform from a natural-language description.
- Let an agent add fields/handlers to a Webform.
- Enable a required module via the ModuleEnable agent.
- Prototype a listing page by describing it to the Views agent.
- Build a contact/registration form with the Webform agent.
- Test experimental agent capabilities before they stabilize.
- Extend a triage agent to delegate to the Views agent.
- Provide site builders an AI shortcut for Views creation.
- Draft a survey webform quickly with AI.
- Chain module-enable + configuration in an agent workflow.
- Evaluate whether an AI-built View matches requirements.
- Use as a reference implementation for writing your own `AiAgent` plugin.
- Experiment with AI-assisted site assembly end to end.
