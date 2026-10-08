# LiteLLM AI Provider — agent index

Provides the `litellm` AI provider plugin for the [AI module](https://www.drupal.org/project/ai):
a self-hosted LiteLLM proxy exposed through Drupal's unified AI operation types
(chat + variants, embeddings, moderation, text-to-image, TTS, translate-text). LiteLLM is
OpenAI-compatible, so the plugin extends the AI module's `OpenAiBasedProviderClientBase`. Depends on `ai`.

- **Settings (`api_key`/`host`/`moderation`), the config route & permission, Key entity wiring, the LiteLLM REST endpoints used, and the operation types/capability filtering** →
  [configure/settings.md](configure/settings.md)

Key facts:
- Provider plugin id `litellm` (`src/Plugin/AiProvider/LiteLlmAiProvider.php`), no plugin *types* defined.
- Config object `ai_provider_litellm.settings`: `api_key` (a Key entity id), `host` (base URL, no trailing slash), `moderation` (bool).
- Configure at `/admin/config/ai/providers/ai_provider_litellm` — route `ai_provider_litellm.settings_form`, permission `administer ai providers`.
- Models auto-discovered via `GET {host}/model/info`; on failure falls back to `GET {host}/v1/models`. Key details via `GET {host}/key/info`. Auth header `Authorization: Bearer <key>`, 5s timeout.
- 1.3.x vs 1.2.x: adds Drupal 12 (`^10.2 | ^11 || ^12`); drops `drupal/ai_provider_openai` from `composer.json` (only `drupal/ai:^1.2.0` left); adds `translate_text` operation (implements `TranslateTextInterface`) and chat sub-variants (tools/vision/structured/complex-json) with new DTO capability flags; adds `/v1/models` fallback and a request-scoped model cache.
