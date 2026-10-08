AI Assistant API is a submodule of AI Core that adds decoupled, reusable "AI Assistants" — configurable chatbot back-ends that talk to an LLM, keep conversation history, and can trigger site actions — without shipping any frontend of their own.

---

The module defines a single `ai_assistant` config entity: each assistant bundles a chosen provider/model (or the site default via the `__default__` sentinel), a system prompt, allowed roles, conversation-history behaviour, and a set of enabled actions. You administer assistants at `/admin/config/ai/ai-assistant` (route `entity.ai_assistant.collection`, gated by the single `administer ai_assistant` permission). At runtime you drive an assistant through the `ai_assistant_api.runner` service (`AiAssistantApiRunner`): set the assistant, pass a `UserMessage`, optionally enable streaming, and call `process()` to get back a normalized `ChatOutput` (or a `StreamedChatMessage` iterator). It defines its own plugin type, `AiAssistantAction` (attribute `#[AiAssistantAction]`, namespace `Plugin/AiAssistantAction`, manager `ai_assistant_api.action_plugin.manager`), so other modules can expose Drupal operations the LLM may invoke and feed context back into the reply. Conversation threads are stored in the private tempstore, keyed per user, with history length controlled by `history_context_length`. Three Symfony events (`AiAssistantSystemRoleEvent`, `PrepromptSystemRoleEvent`, `AiAssistantPassContextToAgentEvent`) let other code rewrite the system prompt or hand context to an agent. If an assistant names an `ai_agent` and the optional `ai_agents` module is installed, the runner delegates the turn to that agent instead. It is explicitly an experimental module and is the back-end that the AI Chatbot submodule renders a UI for.

---

- Build a site chatbot back-end that any custom or decoupled frontend can POST messages to.
- Configure multiple assistants (support bot, editorial helper, search assistant) each with its own prompt and model.
- Pin one assistant to a cheap model and another to a strong model, all through config.
- Fall back to the site's default chat provider/model by setting an assistant's provider to `__default__`.
- Restrict who may run an assistant by selecting allowed roles on the entity.
- Give an assistant conversation memory across a session using `allow_history` = `session` or `session_one_thread`.
- Cap how much prior conversation is resent to the LLM via `history_context_length`.
- Let the LLM trigger real Drupal work (search content, create nodes, etc.) by enabling `AiAssistantAction` plugins.
- Write a custom `AiAssistantAction` plugin to expose your module's logic as an assistant tool.
- Feed action results back into the model's next reply as context.
- Turn on function/tool calling per assistant with the `use_function_calling` flag.
- Provide few-shot examples to the model through an action's `provideFewShotLearningExample()`.
- Roll back state-changing actions on error via an action's `triggerRollback()`.
- Stream an assistant's reply token-by-token to the browser with `streamedOutput(TRUE)`.
- Run an assistant programmatically from custom code through the `ai_assistant_api.runner` service.
- Reset or start a fresh conversation thread with `resetThread()` / `getThreadsKey()`.
- Delegate an assistant's turn to an `ai_agents` agent by setting the `ai_agent` field.
- Rewrite the system prompt globally by subscribing to `AiAssistantSystemRoleEvent`.
- Override the pre-action prompt by subscribing to `PrepromptSystemRoleEvent`.
- Inject request context into a delegated agent via `AiAssistantPassContextToAgentEvent`.
- Show customised error and no-result messages per assistant.
- Pass per-request context (e.g. current entity) into the assistant with `setContext()`.
- Export assistants as configuration and deploy them across environments.
- Pair with the AI Chatbot submodule to get a ready-made block UI for an assistant.
- Enforce per-assistant LLM parameters (temperature, etc.) via `llm_configuration`.
- Debug an agent-backed assistant step-by-step using verbose mode (`setVerboseMode()`).
