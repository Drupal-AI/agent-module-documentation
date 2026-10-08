AI Integration - ECA bridges the AI module and ECA (Event-Condition-Action), exposing AI operations — Chat, Embedding, Moderation, Speech-to-Text, Text-to-Speech — as ECA actions you can drop into a no-code ECA model. It replaces the older `ai_eca` submodule and standalone `ai_eca` project.

---

The module provides five ECA `@Action` plugins (`src/Plugin/Action/`): `ai_integration_eca_execute_chat` (Chat), `ai_integration_eca_execute_embedding` (Embedding), `ai_integration_eca_execute_moderation` (Moderation), `ai_integration_eca_execute_stt` (Speech to Text), and `ai_integration_eca_execute_tts` (Text to Speech). All extend `AiActionBase` (adds a **Model** select — provider+model from `ai.provider`, plus **Token input** and **Token result** ECA token references); the config-driven ones (`AiConfigActionBase`) add a YAML **config** textarea (model params like `temperature`, `voice`, `response_format`, validated against the provider's `getAvailableConfiguration()` by the `ai_integration_eca.provider_validator` service). Chat additionally has a **Prompt** (token-replaced) and optional structured-output **Schema**; system behaviour is set via `system_name`/`system_prompt` keys in the config YAML. At execution each action loads the chosen `ProviderProxy`, reads the input ECA token, calls the AI operation, and writes the result back into the result token for later ECA steps (TTS stores the generated audio as a `public://audio.mp3` file and returns its URL; STT reads the input token as a filepath). Because they're ordinary ECA actions, they're configured only inside ECA models by users with ECA admin access. Two submodules extend it: **ai_integration_eca_agents** (an AI agent + an *Ask AI* form to build/answer questions about ECA models) and **ai_integration_eca_automators** (wire AI Automators into ECA and vice-versa). Depends on `ai`, `eca`, core `file` (and `ai_agents`, `token` via composer).

---

- Add an AI chat/LLM call as a step in an ECA workflow (e.g. on node presave).
- Auto-generate a summary or teaser from body text when content is saved.
- Translate or rewrite field text via an LLM inside an ECA model.
- Produce structured JSON output from a chat model using the Schema field.
- Set a system prompt/persona per action via `system_name` + `system_prompt` config.
- Generate a vector embedding from text and store it in an ECA token for downstream use.
- Run user-submitted text through a moderation model and branch on the `flagged` result.
- Block or flag content automatically when moderation returns a policy violation.
- Convert an uploaded audio file to text (speech-to-text) within a workflow.
- Generate spoken audio (text-to-speech) from text and get back a file URL.
- Pass AI output between ECA steps using ECA token input/result references.
- Tune model parameters (temperature, response_format, voice) via the YAML config field.
- Validate model config against the provider's real capabilities before the model runs.
- Choose any configured AI provider+model per action from a single select.
- Chain multiple AI actions in one ECA model (e.g. moderate → chat → save).
- Build AI-driven business rules without writing PHP.
- Use the *Ask AI* form (agents submodule) to have an LLM build or explain an ECA model.
- Trigger an AI Automator rule from an ECA action (automators submodule).
- Expose an ECA process as an AI Automator worker type (automators submodule).
- Replace the deprecated `ai_eca` module/submodule with the maintained integration.
- Add AI enrichment to content moderation or editorial workflows.
- Prototype AI features declaratively in ECA before committing to custom code.
