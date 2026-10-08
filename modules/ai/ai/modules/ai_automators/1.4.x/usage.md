AI Automators (submodule of `ai`) lets AI and other tools automatically generate, amend or evaluate the value of a field when content is created or saved — driven by per-field configuration attached through Field UI.

---

AI Automators sits on top of AI Core: you attach an *automator* to a field (via the field's config form in Field UI), pick a *rule* (an `AiAutomatorType` plugin matched to that field's type), write a prompt with token support, and the value is generated whenever a matching entity is saved. Rules are attribute-based plugins living in `Plugin/AiAutomatorType/` — there are dozens shipped (LLM text, taxonomy, image alt-text, text-to-image, audio-to-text, entity reference by vector search, JSON, address, and more), each extending a base class in `src/PluginBaseClasses/`. A second plugin type, `AiAutomatorProcessRule` (the "worker type", in `Plugin/AiAutomatorProcess/`), decides *how/when* processing runs: directly on save, via a queue, a batch, an action, or a field-widget button. The `ai_automator` config entity stores each attachment (rule, worker type, entity type, bundle, field, prompt, token, guardrail set). Automators can be sequenced so one field feeds the next, and grouped into reusable `automator_chain` bundles (content entities) that the `ai_automator.automate` service can run programmatically and that can be exposed to agents as an `AutomatorsTool` / AI Core function group. Behaviour is observable and alterable through Symfony events (should-process, process-field, value-change, verbose info) and two alter hooks. It requires AI Core with a working provider, the Token module, and Field UI (only while configuring).

---

- Auto-generate a node's summary field from its body with an LLM when the node is saved.
- Produce SEO meta description / metatag values from page content automatically.
- Generate image alt text for uploaded images using a vision model.
- Create a taxonomy-term reference (auto-tagging) by classifying content with the LLM.
- Translate or rewrite a text field into another field automatically.
- Generate a text-to-image illustration into a media/image field from a text prompt.
- Transcribe an uploaded audio file into a text field (audio-to-text) and summarize it.
- Extract structured data from a video into HTML/text/string fields.
- Populate a JSON or custom field with model-generated structured output.
- Fill an email, telephone, link, or address field by extracting it from source text.
- Build a FAQ field from an article body.
- Populate an entity-reference field by vector-searching existing content (RAG-style linking).
- Chain automators so one generated field becomes the input to the next.
- Defer heavy generation to a queue worker instead of blocking the save request.
- Run generation as a batch for bulk backfilling existing content.
- Trigger an automator from a field-widget button in the edit form on demand.
- Add a custom field type's own automator by writing a new `AiAutomatorType` plugin.
- Scaffold that plugin quickly with `drush generate plugin:ai:automator-type`.
- Apply a guardrail set to an automator so generated values are policy-checked.
- Use tokens in prompts to inject other field values or entity data.
- Run a reusable `automator_chain` from custom code via the `ai_automator.automate` service.
- Expose an automator workflow to AI agents as a tool via `automators_tool` / the `automators_tools` function group.
- Override whether a field should be (re)processed by subscribing to `ShouldProcessFieldEvent`.
- Alter generated values before they are written by subscribing to `ValuesChangeEvent`.
- Only regenerate empty fields, or force regeneration on edit, via the automator's edit-mode / checkIfEmpty logic.
- Add verbose debugging output during a run by listening to `VerboseInformationEvent`.
- Restrict who can configure automators with the `administer ai_automator` permission.
- Register a new worker/processing strategy by implementing an `AiAutomatorProcessRule` plugin.
- Integrate automator runs into ECA or CKEditor workflows via the sibling AI submodules.
