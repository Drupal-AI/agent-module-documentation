<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Provider: Universal (ai_provider_universal) — agent index

A **multi-instance AI provider** for the Drupal AI module. Each inference server and each model is a
**config entity**, so one site can run many local and cloud LLM endpoints under the single `universal`
provider plugin. Package **AI Providers**. Depends on **`ai`** (^1.3) and **`key`**. Core `^11.1 || ^12`,
PHP `^8.3`. License GPL-2.0-or-later. Version 1.0.0-beta3 (version dir 1.0.x).

## What it provides

- **Provider plugin** `universal` — `src/Plugin/AiProvider/UniversalProvider.php`, extends AI core's
  `OpenAiBasedProviderClientBase`; implements chat + embeddings (from base) and `ReRankInterface`,
  `ModerationInterface`, `TextToImageInterface`.
- **Config entities**:
  - `ai_universal_server` (config_prefix `server`) — an OpenAI-compatible/native server instance:
    `backend`, `host_name`, `port`, `api_key` (Key entity id), `timeout`, `operation_types`,
    `model_filter`, `daily_request_limit`, `daily_token_limit`, `alert_threshold`, `limit_grace`.
    Admin UI at `/admin/config/ai/providers/universal`. Admin permission `administer ai providers`.
  - `ai_universal_model` (config_prefix `model`) — a discovered/configured model: `server_id`,
    `raw_model_id`, detected + override `operation_types`, `cost_input`/`cost_output`, `quality_tier`,
    `context_length`, `reasoning`, `supported_features`, `sampling`, `extra_params`. Ids are
    `server.model` (dot-separated, for AI core / ai_search compatibility).
- **Plugin type** `AiServerBackend` — `src/Backend/AiServerBackendManager.php`, attribute
  `src/Attribute/AiServerBackend.php`, base `AiServerBackendPluginBase`. Twelve backends in
  `src/Plugin/AiServerBackend/`: OpenAiCompatible, Ollama, OllamaCloud, OpenRouter, Groq, Fireworks,
  HuggingFace, LiteLlm, DeepSeek, Amazee, Grok, Anthropic. Opt-in `AiInferenceBackendInterface` lets a
  backend own native-protocol chat (Anthropic uses it).
- **Services**: `UsageTracker` (per-model daily counters, table `ai_provider_universal_usage`),
  `ModelCatalog` (discovery + persistence), `AiServerBackendManager`.
- **Drush** (`src/Commands/UniversalCommands.php`): `aip:discover-models` (aliases `aipdm`,
  `aip-discover`) and `aip:chat`.
- **Hooks** (`src/Hook/AiProviderUniversalHooks.php`): entity insert/update/delete clear the AI
  provider cache and delete a server's models on server delete.
- **Events**: `ModelPreCallEvent`, `ModelPostCallEvent`, `ModelsDiscoveredEvent`.
- **Recipes** (`recipes/`): `ai_content_disclosure`, `ai_content_governance_starter`,
  `factcheck_trusted_sites`, `factcheck_trusted_sites_seeds`.
- Credentials are always resolved through the **Key** module (`api_key` holds a Key entity id).

## Solution docs

- **Servers, models, backends, config & CLI** → [config/servers-and-models.md](config/servers-and-models.md)
- **The AiServerBackend plugin type — building a custom backend** → [api/backend-plugins.md](api/backend-plugins.md)
- **Submodule: Smart Router** (`ai_provider_universal_router`) → [submodules/router.md](submodules/router.md)
- **Submodule: Fact Check** (`ai_provider_universal_factcheck`) → [submodules/factcheck.md](submodules/factcheck.md)
- **Submodule: Content Governance** (`ai_provider_universal_governance`) → [submodules/governance.md](submodules/governance.md)

The three submodules ship in this project under `modules/` and are documented as subpages above (no
separate top-level doc dir).
