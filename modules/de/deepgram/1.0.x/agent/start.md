<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Deepgram (deepgram) — agent index

A **provider plugin for the AI module** (`drupal/ai`) that adds **Deepgram** as a
**speech-to-text** (transcription) and **text-to-speech** (Aura voices) backend. No entities,
no permissions of its own, no Drush, no custom controllers — the only public surface is one
admin settings form. Package `AI Providers`. Core `^10.2 || ^11`. License GPL-2.0-or-later.
Version 1.0.x (1.0.0-beta2 on disk).

- **Dependencies:** `ai:ai` (the AI module — provides the `AiProvider` plugin type and the
  operation-type interfaces) and `key:key` (stores the Deepgram API key as a Key entity).

## What it provides

- **AI provider plugin** `DeepgramProvider` (`src/Plugin/AiProvider/DeepgramProvider.php`,
  id `deepgram`), implementing the AI module's `SpeechToTextInterface` and
  `TextToSpeechInterface`. Supported operation types: `speech_to_text`, `text_to_speech`.
- **HTTP client service** `deepgram.api` → `Drupal\deepgram\Deepgram` (`src/Deepgram.php`),
  the low-level wrapper around the Deepgram REST API (`https://api.deepgram.com/v1/`).
- **Settings form** `DeepgramConfigForm` at route `deepgram.settings`
  (`/admin/config/deepgram/settings`, permission `administer site configuration`); menu link
  under the AI providers admin group.
- **Config object** `provider_deepgram.settings` (single key `api_key` = a Key entity ID) with
  schema in `config/schema/provider_deepgram.schema.yml`.
- **API definition** `definitions/api_defaults.yml` (declares inputs/config for the two
  operation types, consumed by `getApiDefinition()`).

## Solution docs

- **Provider plugin, operation types, models, the raw client and its request flow** →
  [api/provider.md](api/provider.md)
- **Install, the Key-based API key, config object & settings route** →
  [config/settings.md](config/settings.md)
