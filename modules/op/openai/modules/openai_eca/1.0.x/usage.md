OpenAI ChatGPT ECA exposes the OpenAI endpoints as ECA (Event-Condition-Action) actions, so no-code workflows built with the ECA module can call chat, completion, embedding, moderation, text-to-speech, and speech-to-text through the core `openai.api` service.

---

The submodule provides six ECA Action plugins (base `OpenAIActionBase`), each wrapping an
`openai.api` method: `openai_eca_execute_chat` (chat), `openai_eca_execute_completion`
(completions), `openai_eca_execute_embedding` (embeddings), `openai_eca_execute_moderation`
(moderation), `openai_eca_execute_tts` (text-to-speech), and `openai_eca_execute_speech`
(speech-to-text). It depends on the `eca` module; you add these actions to ECA models
(BPMN/Camunda-style) to trigger OpenAI on Drupal events and store the result in ECA tokens for
later steps. It has no admin config of its own — configuration is per ECA action instance.
Requires the OpenAI API key on the parent module.

---

- Call OpenAI chat from an ECA no-code workflow.
- Run a completion as a step in an ECA model.
- Generate embeddings for content within an automation.
- Moderate submitted content automatically via ECA.
- Convert text to speech as part of a workflow.
- Transcribe audio (speech-to-text) in an ECA process.
- React to Drupal events (entity save, etc.) with an OpenAI call.
- Store OpenAI output in ECA tokens for downstream actions.
- Auto-tag or classify content on save using AI.
- Build approval flows that flag content via moderation.
- Enrich entities with AI-generated fields on create/update.
- Trigger AI summaries when an article is published.
- Chain multiple OpenAI actions in one workflow.
- Automate notifications with AI-written text.
- Prototype AI automations without writing code.
- Reuse the shared `openai.api` service and API key across actions.
- Integrate OpenAI into existing ECA-based business rules.
- Generate audio versions of content automatically.
