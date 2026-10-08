<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# X AI Provider (ai_provider_x) — agent index

An AI-provider plugin that registers **X (xAI / Grok)** with the Drupal AI module and routes requests to
the OpenAI-compatible endpoint `https://api.x.ai/v1`.

- **Version dir:** 1.0.x · **Core:** `^10.2 || ^11` · **Package:** AI Providers
- **Depends on:** `ai:ai`, `key:key` (plus the `openai-php/client` Composer library).
- **Provides:** one AI provider plugin `id: x` (`src/Plugin/AiProvider/XProvider.php`).
- **Operation types:** `chat`, `chat_with_image_vision`, and `embeddings`.
- **Models (hard-coded):** `grok-2-latest`, `grok-2-1212`, `grok-2-vision-1212`.
- **Config object:** `ai_provider_x.settings` (single key `api_key`, a Key-module key id).
- **Route / form:** `ai_provider_x.settings_form` at `/admin/config/ai/providers/x`
  (`XConfigForm`), permission `administer ai providers`.
- **Service:** `ai_provider_x.api` → `Drupal\ai_provider_x\XClient` (a thin Guzzle wrapper for the
  raw `moderations` endpoint; the main chat/embeddings path uses the `openai-php/client` factory).
- **Menu link:** `ai_provider_x.settings_menu` under `ai.admin_providers`.

## What it does not provide

No permissions of its own, no Drush commands, no entities, no submodules. It contributes a plugin
*instance* to the AI module's `AiProvider` plugin type — it does not define a new plugin type.

## Solution docs

- Configuration & key setup: [`config/settings.md`](config/settings.md)
- The `x` provider plugin (models, chat, vision, embeddings, streaming): [`plugins/x_provider.md`](plugins/x_provider.md)
