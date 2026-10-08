# LiteLLM AI Provider — agent index

Provides the `litellm` AI provider plugin for the [AI module](https://www.drupal.org/project/ai):
a self-hosted LiteLLM proxy exposed through Drupal's unified AI operation types
(chat, embeddings, moderation, text-to-image, TTS, audio). LiteLLM is OpenAI-compatible, so
the plugin extends the AI module's `OpenAiBasedProviderClientBase`. Depends on `ai`.

- **Settings (`api_key`/`host`/`moderation`), the config route & permission, Key entity wiring, and the LiteLLM REST endpoints used** →
  [configure/settings.md](configure/settings.md)

Key facts:
- Provider plugin id `litellm` (`src/Plugin/AiProvider/LiteLlmAiProvider.php`), no plugin *types* defined.
- Config object `ai_provider_litellm.settings`: `api_key` (a Key entity id), `host` (base URL, no trailing slash), `moderation` (bool).
- Configure at `/admin/config/ai/providers/ai_provider_litellm` — route `ai_provider_litellm.settings_form`, permission `administer ai providers`.
- Models auto-discovered via `GET {host}/model/info`; key details via `GET {host}/key/info`. Auth header `Authorization: Bearer <key>`.
- 1.2.x: OpenAI provider module no longer a hard runtime dependency (composer still lists it; `update_10001` says it can be uninstalled).
