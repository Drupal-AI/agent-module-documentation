<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Providers API (ai_providers_api) — agent index

A lightweight **AI provider plugin system**: a common interface + plugin manager + an
`AiService` entry point + a settings UI + a JS response-streaming API. Package **Simple
AI**. Version **1.0.0-alpha4**. Core `^11`. License GPL-2.0-or-later. No Drupal-module
dependencies (core only).

Ships three provider plugins: **Claude**, **Gemini**, **Ollama**. Intended as a simpler
alternative to `drupal/ai` (used by e.g. *LMS AI*).

## What it provides

- **Plugin type `AiProvider`** (dir `Plugin/AiProvider`, attribute
  `Attribute\AiProvider`, interface `Plugin\AiProviderInterface`, base
  `Plugin\AiProviderBase`, manager service `plugin.manager.ai_providers_api_provider` =
  `AiProviderManager`) → [plugins/providers.md](plugins/providers.md)
- **Service `AiService`** (`AiServiceInterface`) — `prompt()` / `streamPrompt()` resolve a
  provider by id, merge config, and dispatch → [api/streaming.md](api/streaming.md)
- **Routes** (`ai_providers_api.routing.yml`):
  - `ai_providers_api.settings` — `/admin/ai-providers/settings`, `Form\AiSettingsForm`,
    permission **`administer ai providers`** (`restrict access: true`) →
    [config/settings.md](config/settings.md)
  - `ai_providers_api.stream` — **POST** `/ai/stream`, `Controller\AiResponseController`,
    `_custom_access: …::access` → [api/streaming.md](api/streaming.md)
- **Permission** `administer ai providers` (`ai_providers_api.permissions.yml`,
  `restrict access: true`).
- **Config** object `ai_providers_api.settings` (`providers` map;
  `config/schema/ai_providers_api.schema.yml`).
- **JS library** `ai_streaming_api` (`js/ai_streaming_api.js`) — client for `/ai/stream`.
- **Access hook** `hook_ai_stream_access($body, $account)` and prompt-alter hook
  `hook_ai_providers_api_prompt_alter`.

## Access model (important for integrators)

`/ai/stream` is **denied by default**. `AiResponseController::access()` invokes
`hook_ai_stream_access($body, $account)` on all modules: any `forbidden()` denies; at
least one `allowed()` with no `forbidden()` grants; if every result is neutral (or no
module implements the hook) the access result is `forbidden()`. So this module ships no
open endpoint — an implementing module (e.g. LMS AI) owns the access decision.

## Files

- `src/AiService.php`, `src/AiServiceInterface.php`, `src/AiProviderManager.php`,
  `src/AiException.php`.
- `src/Plugin/AiProviderBase.php`, `src/Plugin/AiProviderInterface.php`,
  `src/Plugin/AiProvider/{Claude,Gemini,Ollama}.php`, `src/Attribute/AiProvider.php`.
- `src/Controller/AiResponseController.php`, `src/Response/AiStreamedResponse.php`,
  `src/Form/AiSettingsForm.php`.
