OpenAI Provider is the OpenAI plugin for the AI (AI Core) module: it implements the `openai` AiProvider so Drupal can call OpenAI (and OpenAI-compatible / Azure) endpoints for chat, embeddings, moderation, image generation, text-to-speech and speech-to-text.

---

The module registers a single `#[AiProvider(id: 'openai')]` plugin (`OpenAiProvider`, extending AI Core's `OpenAiBasedProviderClientBase` on the `openai-php/client` SDK) that adapts OpenAI's REST API to AI Core's operation-type interfaces. It declares support for six operation types — `chat`, `embeddings`, `moderation`, `text_to_image`, `text_to_speech`, `speech_to_text` — each mapping to a typed input/output object AI Core defines. You authenticate by selecting a Key entity (via the `key` module) on the settings form at **Admin → Configuration → AI → AI Providers → OpenAI Authentication** (`/admin/config/ai/providers/openai`); the API key is never stored in plain config, only the Key id is. An optional `host` config value repoints every request at an OpenAI-compatible or Azure endpoint. Model lists are fetched live from the OpenAI models endpoint and cached, then filtered per operation type and per capability (vision, JSON output, tools, structured response). Text calls are moderation-gated by default: a `moderation` config flag (on by default) runs each prompt through `omni-moderation-latest` first and throws `AiUnsafePromptException` if flagged (bypass per-call with the `skip_moderation` tag or by disabling moderation). Rich chat features are supported — system prompts, image/PDF file inputs, streaming (and Fiber-based async streaming), tool/function calling, and structured JSON-schema responses — plus per-model settings tuning (max tokens, temperature, penalties, reasoning effort for o-series/gpt-5, quality/size for gpt-image). On setup it seeds AI Core's default provider/model map (e.g. chat → gpt-5.2, embeddings → text-embedding-3-small, moderation → omni-moderation-latest) and warns if the key is only on the OpenAI free tier. You never call this provider directly — you go through AI Core's `ai.provider` service so vendor choice stays config-driven.

---

- Add OpenAI as an AI vendor to a Drupal site running the AI (AI Core) module.
- Store the OpenAI API key securely as a Key entity instead of in plain configuration.
- Set OpenAI as the site default provider for chat at `/admin/config/ai/settings`.
- Run chat completions (GPT-4o, gpt-4.1, gpt-5.x, o1/o3/o4) through AI Core's `chat()` operation.
- Generate text embeddings (`text-embedding-3-small` / `-large`, `ada-002`) for AI Search / RAG.
- Moderate user text against `omni-moderation-latest` before it reaches a model.
- Auto-run moderation on every chat/image/TTS/embeddings prompt and block unsafe input.
- Bypass moderation for a single trusted call using the `skip_moderation` tag.
- Generate images from a prompt with `gpt-image-1` (text_to_image).
- Convert text to spoken audio with `tts-1-hd` and pick a voice (alloy, nova, fable…).
- Transcribe an uploaded audio file to text with `whisper-1` (speech_to_text).
- Point the provider at an OpenAI-compatible endpoint (LocalAI, LM Studio, etc.) via the `host` setting.
- Point the provider at an Azure OpenAI deployment by overriding the host.
- Send images or PDFs to a vision-capable model as part of a chat message.
- Stream chat responses token-by-token for a chatbot UI.
- Use OpenAI tool/function calling so the model can invoke Drupal FunctionCall plugins.
- Request a structured JSON-schema response from a chat model.
- Tune per-model chat settings (max_tokens, temperature, top_p, frequency/presence penalty).
- Set reasoning effort (minimal/low/medium/high) for reasoning models (o-series, gpt-5).
- Get the embedding vector size for a model to size a vector database column.
- Seed AI Core's default provider/model map automatically when the key is saved.
- Detect free-tier / out-of-quota keys and warn the site admin during setup.
- Surface rate-limit and quota errors as typed AI exceptions for graceful handling.
- List only the models valid for a given operation type and capability in admin selects.
- Power AI Core submodules (AI Chatbot, AI Search, AI CKEditor, automators) with OpenAI as the backend.
- Migrate legacy `provider_openai` submodule config into this standalone module on install.
