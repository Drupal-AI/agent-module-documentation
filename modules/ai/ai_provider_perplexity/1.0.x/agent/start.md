<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Perplexity Provider (ai_perplexity) — agent index

An **AI-module provider plugin** that routes `chat` operations to **Perplexity AI** (Llama 3.1
Sonar online models) and exposes Perplexity `citations`. Package `AI`. Depends on **`ai`** and
**`key`**. Core `^10.2 || ^11`. License GPL-2.0-or-later. Project `ai_provider_perplexity`,
**module machine name `ai_perplexity`**. Version dir `1.0.x` (release 1.0.0-beta2).

- **Settings form, config keys, schema, model params** → [config/settings.md](config/settings.md)
- **The `perplexity` provider plugin: chat, citations, retries, client** → [plugins/provider.md](plugins/provider.md)

## What it actually is

- One plugin: `PerplexityProvider` (id **`perplexity`**, label *Perplexity AI*) in
  `src/Plugin/AiProvider/PerplexityProvider.php`, extending
  `Drupal\ai\Base\AiProviderClientBase`, implementing `ChatInterface`, using `ChatTrait`.
- Supported operation types (`getSupportedOperationTypes()`): **`chat`** only. No vision.
- Talks to Perplexity through the OpenAI PHP SDK against the **fixed** base URI
  `https://api.perplexity.ai` (not admin-settable).
- One settings form: `PerplexitySettingsForm` (`src/Form/PerplexitySettingsForm.php`), config
  object `ai_perplexity.settings`.

## Provides

- **Plugin:** `ai_provider` instance `perplexity`.
- **Route:** `ai_perplexity.settings` → `/admin/config/ai/providers/perplexity`
  (`_permission: 'administer ai providers'`); menu link under *AI → Providers*.
- **Config object + schema:** `ai_perplexity.settings` and `ai.provider.perplexity`
  (`config/schema/ai_perplexity.schema.yml`). No permissions, services, Drush; empty
  `.module` / `.install` hook stubs only.
- **Definitions:** `definitions/api_defaults.yml` (chat temperature/top_p/max_tokens defaults),
  loaded by `getApiDefinition()`.

## Dependencies & operation

- Requires the `ai` framework and `key` module. The API key is a **Key entity** selected on the
  settings form; the module has no own `composer.json` (deps come from `.info.yml`).
- Three fixed models: `llama-3.1-sonar-small-128k-online` (8B),
  `llama-3.1-sonar-large-128k-online` (70B), `llama-3.1-sonar-huge-128k-online` (405B).
- Chat sends `temperature`/`top_p`/`max_tokens`, retries with exponential backoff
  (`max_retries`, `retry_delay`), maps "rate limit" to `AiRateLimitException`, and returns
  Perplexity `citations` in the output metadata. No streaming, tools, or embeddings.
- Note: `.info.yml` has no `configure:` key, so `data.json.configure` is null even though the
  settings route exists.
