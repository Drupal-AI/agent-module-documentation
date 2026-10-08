# ai_agents_form_integration — agent start

Submodule of [ai_agents](../../../ai_agents/1.3.x/agent/start.md). **Experimental, hidden.**
Form-based UI to generate config/content with agents. No `configure` route.

- **AI-assisted content type form:** `/admin/structure/types/add-ai-assisted`
  (route `ai_agents_form_integration.ai_assisted_generation`, form `ContentTypes`,
  permission `create ai assisted content types`).
- **Permissions:** `create ai assisted webforms`, `create ai assisted field types`
  (+ `create ai assisted content types`, supplied dynamically).
- **Services:** `ai_agents_form_integration.form_helper` (`Service\FormHelper`),
  `ai_agents_form_integration.subscriber` (`Routing\RouteSubscriber`). Field generation uses
  `Plugin/Derivative/FieldType` (a deriver, not a new plugin type).
- **Optional deps:** `simple_crawler`, `unstructured` (extra generation context).

Needs an AI provider (API key) in AI Core. Agent mechanics: see the parent module docs.
