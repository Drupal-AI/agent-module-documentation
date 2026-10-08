<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Gemini Provider plugs Google's Gemini models into the Drupal AI (`ai`) module, so any AI-module feature (chat, embeddings, and more) can run against Gemini through the AI abstraction layer.

---

The module registers a single AI provider plugin, `gemini` (`#[AiProvider(id: 'gemini')]`, class `GeminiProvider`), that talks to the Gemini API via the `google-gemini-php/client` library. It advertises five operation types — `chat`, `embeddings`, `text_to_image`, `text_to_speech`, `speech_to_text` (chat and embeddings are the most complete) — and exposes their tunable parameters (temperature, topP/topK, maxOutputTokens, stop sequences, response MIME/schema, image aspect ratio, TTS voice/language, etc.) through `definitions/api_defaults.yml`. Authentication is a **Key** entity chosen with a `key_select` widget on the settings form (route `gemini_provider.settings_form` at `/admin/config/ai/providers/gemini`, permission `administer ai providers`); the chosen key id is saved to `gemini_provider.settings.api_key` and resolved at request time by the AI base provider. The settings form also stores per-`HarmCategory` **safety_settings** (mapping each category to a `HarmBlockThreshold` such as `BLOCK_ONLY_HIGH`), which are applied to each generative request. `getConfiguredModels()` calls the live Gemini API to list available models (filtering out specialized/vision/robotics/embedding-only ones for chat), and `getSetupData()` supplies defaults — chat `models/gemini-2.5-flash`, embeddings `models/gemini-embedding-001`; `embeddingsVectorSize()` returns 3072 for `gemini-embedding-001` and 768 for `text-embedding-004`. Streaming chat is handled by `GeminiChatMessageIterator`. The module itself defines no permissions and no Drush commands — it is consumed through the AI module's APIs, Explorers, and any module (AI Assistants, AI CKEditor, AI Search, etc.) that targets a provider.

---

- Use Google Gemini as the LLM backend for the Drupal AI module.
- Power AI-module chat features (assistants, chatbots) with Gemini models.
- Generate text embeddings with `gemini-embedding-001` for AI Search / RAG.
- Set Gemini as the default provider for a given AI operation type.
- Store the Gemini API key securely as a Key entity (env, file, or config provider).
- Switch the Gemini API key by pointing the provider at a different Key.
- Tune chat generation via temperature, topP, topK, and maxOutputTokens.
- Constrain output with stop sequences or a JSON response MIME type/schema.
- Configure per-category safety thresholds (harassment, hate speech, etc.).
- Relax or tighten Gemini content filtering with `HarmBlockThreshold` values.
- Use Gemini vision (image + text to text) through the chat operation.
- Build embeddings vectors of the correct size (3072 for gemini-embedding-001).
- Provide multiple AI providers on one site and route features to Gemini selectively.
- Experiment with Gemini models in the AI module's provider/Explorer UIs.
- Drive AI CKEditor or AI Automators with Gemini.
- Generate images from text via the text_to_image operation (where supported).
- Synthesize speech from text (text_to_speech) with a chosen Gemini voice.
- Transcribe audio to text (speech_to_text) via Gemini.
- Stream chat responses token-by-token using the Gemini streamed iterator.
- Compare Gemini output against other providers by swapping the configured provider.
- Centralise Gemini credentials for all AI features behind one Key + settings form.
- Restrict who can configure the provider via the AI module's `administer ai providers` permission.
- Select an appropriate default chat model (gemini-2.5-flash) out of the box.
- Add Gemini support to a site already using the AI module without code changes.
