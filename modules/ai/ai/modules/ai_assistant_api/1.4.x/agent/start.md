# ai_assistant_api (AI Assistant API) 1.4.x — agent index

Submodule of **ai** (AI Core). Adds decoupled **AI Assistants**: a configurable
chatbot back-end (`ai_assistant` config entity) that talks to an LLM through AI Core's
provider layer, keeps conversation threads, and can trigger site **actions**. It ships no
frontend of its own (the `ai_chatbot` submodule provides one). Experimental module.

Mental model: configure an **`ai_assistant`** entity (prompt + provider/model + roles +
enabled actions), then drive it at runtime through the **`ai_assistant_api.runner`**
service — set the assistant, pass a `UserMessage`, call `process()` → `ChatOutput`.

- **Configure an assistant** (entity, fields, settings, permission) → [configure/ai_assistant_api.md](configure/ai_assistant_api.md)
- **Run an assistant from code** (runner service, streaming, threads, events, agent delegation) → [api/ai_assistant_api.md](api/ai_assistant_api.md)
- **Add an action the LLM can call** (`AiAssistantAction` plugin type) → [plugins/ai_assistant_api.md](plugins/ai_assistant_api.md)

Depends on `ai:ai`. Optional integration with `ai_agents` (delegate a turn to an agent).
