A hidden, experimental submodule of AI Agents that adds a form-driven UI for generating Drupal configuration — content types, fields, and webforms — by describing them to an AI agent.

---

Instead of running agents from code or the Explorer, this submodule wires agents into ordinary Drupal admin forms so a site builder can generate structure in-place. Its main entry point is an "AI-assisted" content-type creation form at `/admin/structure/types/add-ai-assisted` (route `ai_agents_form_integration.ai_assisted_generation`, form `ContentTypes`, permission `create ai assisted content types`), with a `FormHelper` service and a `RouteSubscriber` wiring it up, plus a `Plugin/Derivative/FieldType` deriver for field generation. It depends on `ai_agents` and optionally integrates with `simple_crawler` and `unstructured` to pull in extra context (e.g. crawl a site or parse files) when generating. It is `lifecycle: experimental` and `hidden: true`. Permissions include `create ai assisted webforms` and `create ai assisted field types`. Running it requires a configured AI provider in AI Core.

---

- Create a content type by describing it in a form.
- Generate a set of fields for a new content type with AI.
- Build a webform through an AI-assisted form.
- Seed a content model from a written spec.
- Use a crawled website (with simple_crawler) as generation context.
- Parse an uploaded document (with unstructured) to inform generation.
- Give editors a guided, form-based AI builder (no free-form chat).
- Prototype a content type + fields in one step.
- Add AI-assisted field creation to the field UI.
- Let non-developers scaffold structures safely via forms.
- Draft a webform's fields from a description.
- Speed up repetitive content-type setup.
- Generate consistent field configurations across types.
- Trial AI-assisted config generation before it stabilizes.
- Combine crawled + uploaded context for richer generation.
