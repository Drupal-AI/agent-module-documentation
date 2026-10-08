<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Prompt is a framework that stores reusable prompt configurations as `prompt` config entities and runs them against pluggable AI providers to generate content.

---

Each prompt entity holds a template (with token support), a target provider and model, and mapping to a destination field. Provider integration lives in submodules: `prompt_chatgpt` (OpenAI chat completions), `prompt_gpt3` (OpenAI completions) and `prompt_gladia` (Gladia text/audio). A provider is configured on its own settings form where its API secret key is stored, and a `Prompt: set field value` action (`PromptSetFieldValue`) applies generated output to entity fields, so prompts can be run as part of Views Bulk Operations or other action pipelines. Prompt entities are managed at `/admin/config/system/prompt` and can be enabled/disabled via `entity.prompt.enable` / `entity.prompt.disable` (permission `administer prompt configuration`).

Operational notes: provider API keys are stored in plain module config (e.g. `prompt_chatgpt.settings:secret_key`) as ordinary textfields, so they are exportable with configuration; there is no cost metering or rate limiting, and running a prompt calls a paid third-party API. Typical setup is: enable the base module plus one provider submodule, enter the provider API key, create a prompt entity, and attach the action to a workflow.

---

- Create a reusable prompt configuration as a `prompt` config entity.
- Store a system/role instruction plus a user prompt template.
- Insert entity field values into a prompt using tokens.
- Choose the AI provider (ChatGPT, GPT-3, or Gladia) per prompt.
- Select the model (e.g. gpt-3.5/gpt-4 family) for a prompt.
- Enable the `prompt_chatgpt` submodule for OpenAI chat completions.
- Enable the `prompt_gpt3` submodule for the legacy completions endpoint.
- Enable the `prompt_gladia` submodule for Gladia text and audio transcription.
- Configure the ChatGPT API secret key at `/admin/config/system/prompt/chatgpt`.
- Generate a content suggestion for a node body.
- Chunk long text before sending it to the model to respect length limits.
- Apply generated output to a target field with the set-field-value action.
- Run a prompt across many entities via Views Bulk Operations.
- Enable a prompt entity so it appears in the action pipeline.
- Disable a prompt entity without deleting it.
- Summarize a field's contents into another field.
- Translate or rewrite copy using a provider model.
- Transcribe audio to text via the Gladia provider.
- List and manage all prompt entities from the admin collection.
- Delete a prompt entity that is no longer needed.
- Restrict prompt administration to trusted roles via its permission.
- Debug a prompt request to inspect the assembled payload.
