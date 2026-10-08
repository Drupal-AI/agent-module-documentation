<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# xAI Provider (ai_provider_xai) — agent index

An early-stage AI-provider plugin that registers **xAI (Grok)** with the Drupal AI module, backed by
the `grok-php/client` library. Packaged version is `1.0.0-alpha1`; project description is
"Under development".

- **Version dir:** 1.0.x · **Core:** `^10.3 || ^11` · **Package:** AI Providers
- **Depends on:** `ai:ai`, `key:key` (plus Composer library `grok-php/client:^1.1`).
- **Provides:** one AI provider plugin `id: xai` (`src/Plugin/AiProvider/XAIProvider.php`).
- **Operation types:** `chat` only (embeddings / image / speech are commented out).
- **Model:** `grok-2` ("Grok 2"), defined in `definitions/api_defaults.yml`.
- **Config object:** `ai_provider_xai.settings` (single key `api_key`, a Key-module key id).
- **Route / form:** `ai_provider_xai.settings_form` at `/admin/config/ai/providers/xai`
  (`XAIConfigForm`), permission `administer ai providers`.
- **Menu link:** `ai_provider_xai.settings_menu` under `ai.admin_providers`.

## Caveats (from source)

- **`chat()` is a scaffold:** `XAIProvider::chat()` currently ignores the passed input and sends a
  hard-coded message (`"How do black holes form?"`) with a fixed `ChatOptions(model: GROK_2,
  temperature: 1.2)`. Do not rely on it for real prompts without patching.
- **Routing bug:** `ai_provider_xai.routing.yml` names the form class as
  `\Drupal\ai_provider_openai\Form\XAIConfigForm` (wrong namespace) while the class actually lives at
  `Drupal\ai_provider_xai\Form\XAIConfigForm`.

No permissions, Drush commands, entities, services or submodules of its own.

## Solution docs

- Configuration & key setup: [`config/settings.md`](config/settings.md)
- The `xai` provider plugin: [`plugins/xai_provider.md`](plugins/xai_provider.md)
