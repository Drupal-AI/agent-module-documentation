<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Gemini Provider plugs Google's Gemini models into the Drupal AI (`ai`) module, so any AI-module feature (chat, embeddings, and more) can run against Gemini through the AI abstraction layer.

---

The module registers a single AI provider plugin, `gemini` (`#[AiProvider(id: 'gemini')]`, class `GeminiProvider`), that talks to the Gemini API via the `google-gemini-php/client` library. It advertises five operation types — `chat`, `embeddings`, `text_to_image`, `text_to_speech`, `speech_to_text` — and exposes their tunable parameters (temperature, topP/topK, maxOutputTokens, stop sequences, response MIME/schema, image aspect ratio, TTS voice/language, STT language, etc.) through `definitions/api_defaults.yml`. Authentication is a **Key** entity chosen with a `key_select` widget on the settings form (route `gemini_provider.settings_form` at `/admin/config/ai/providers/gemini`, permission `administer ai providers`); the chosen key id is saved to `gemini_provider.settings.api_key` and resolved at request time by the AI base provider (`loadApiKey()` via the Key repository). The settings form also stores per-`HarmCategory` **safety_settings** (mapping each category to a `HarmBlockThreshold` such as `BLOCK_ONLY_HIGH`), which are applied to each generative request by `applySafetySettings()`. `getConfiguredModels()` calls the live Gemini API to list available models and filters them **per operation type** — embeddings models need `embedContent`, text_to_image needs a `generateContent` model whose name contains `image`, text_to_speech needs a `-tts` model, speech_to_text and chat need a general `generateContent` model with specialized models (imagen, veo, `-tts`, `-transcribe`, native-audio, robotics, computer-use, deep-research, aqa) filtered out. `getSetupData()` supplies defaults for every operation — chat/STT `models/gemini-3.8-flash`, embeddings `models/gemini-embedding-2`, text_to_image `models/gemini-3.1-flash-image`, text_to_speech `models/gemini-3.8-flash-tts`. `embeddingsVectorSize()` returns 3072 for the `gemini-embedding-001`/`gemini-embedding-2`/`gemini-embedding-2-preview` models (otherwise the AI base default); `maxEmbeddingsInput()` returns 8192 for `gemini-embedding-2`/`-preview`, else 2048. Embeddings can be multimodal — `gemini-embedding-2` accepts an image alongside text, other embedding models reject image input. Chat supports image input, streaming (wrapped by `GeminiChatMessageIterator`), tool/function calling and structured JSON output (OpenAI-style schema converted to Gemini's native `Schema`). TTS wraps raw-PCM preview output in a WAV container (`pcmToWav`). The module itself defines no permissions and no Drush commands — it is consumed through the AI module's APIs, Explorers, and any module (AI Assistants, AI CKEditor, AI Search, etc.) that targets a provider.

---

- Use Google Gemini as the LLM backend for the Drupal AI module.
- Power AI-module chat features (assistants, chatbots) with Gemini models.
- Generate text embeddings with `gemini-embedding-2` for AI Search / RAG.
- Generate multimodal (text + image) embeddings with `gemini-embedding-2`.
- Set Gemini as the default provider for a given AI operation type.
- Store the Gemini API key securely as a Key entity (env, file, or config provider).
- Switch the Gemini API key by pointing the provider at a different Key.
- Tune chat generation via temperature, topP, topK, and maxOutputTokens.
- Constrain output with stop sequences or a JSON response MIME type/schema.
- Return structured JSON output from chat using a response schema.
- Configure per-category safety thresholds (harassment, hate speech, etc.).
- Relax or tighten Gemini content filtering with `HarmBlockThreshold` values.
- Use Gemini vision (image + text to text) through the chat operation.
- Call your custom functions from chat via Gemini tool / function calling.
- Provide multiple AI providers on one site and route features to Gemini selectively.
- Experiment with Gemini models in the AI module's provider/Explorer UIs.
- Drive AI CKEditor or AI Automators with Gemini.
- Generate images from text via the text_to_image operation with a chosen aspect ratio.
- Synthesize speech from text (text_to_speech) with a chosen Gemini voice and language.
- Transcribe audio to text (speech_to_text) via Gemini's multimodal generateContent.
- Stream chat responses token-by-token using the Gemini streamed iterator.
- Track per-operation token usage (prompt, output, reasoning, cached) for chat.
- Compare Gemini output against other providers by swapping the configured provider.
- Centralise Gemini credentials for all AI features behind one Key + settings form.
- Restrict who can configure the provider via the AI module's `administer ai providers` permission.
- Select appropriate default models (gemini-3.8-flash, gemini-embedding-2) out of the box.
- Add Gemini support to a site already using the AI module without code changes.
