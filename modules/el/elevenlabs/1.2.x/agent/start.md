<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ElevenLabs (elevenlabs) — agent index

An **AI-module provider plugin** that exposes the ElevenLabs voice API to Drupal through the AI
suite's operation-type abstraction. Package `AI Provider`. Version **1.2.x**.
Core `^10.2 || ^11 || ^12`. Depends on `ai:ai` and `key:key`. **No permissions, no Drush, no
hooks, no submodules.** Configure at `/admin/config/system/eleven-labs-settings`.

- **API key setup, the settings form, config object & schema** → [config/settings.md](config/settings.md)
- **The AI provider plugin: operations, models, voices, chunking** → [plugins/ai-provider.md](plugins/ai-provider.md)
- **The HTTP service: endpoints, auth header, caching** → [api/service.md](api/service.md)

## What it actually is

- One plugin: `ElevenlabsProvider` (id **`elevenlabs`**, label *"ElevenLabs"*) in
  `src/Plugin/AiProvider/ElevenlabsProvider.php`, extending `Drupal\ai\Base\AiProviderClientBase`
  and declared with the `#[AiProvider(...)]` attribute. It implements the AI operation
  interfaces `TextToSpeechInterface`, `SpeechToSpeechInterface` and `AudioToAudioInterface`.
- `getSupportedOperationTypes()` returns **`text_to_speech`, `speech_to_speech`,
  `audio_to_audio`**. Callers reach it through the AI module (`ai.provider` service), not directly.
- One service: **`elevenlabs.api`** → `ElevenLabsApiService`
  (`src/ElevenLabsApiService.php`), the thin Guzzle wrapper around `https://api.elevenlabs.io/v1/`.
- One form: `Form/ElevenLabsSettingsForm` (route `elevenlabs.settings`, permission
  **`administer site configuration`**, menu under *AI → Providers* via
  `elevenlabs.links.menu.yml`). It stores only a **Key entity id**.
- Operation defaults (settings shown in the AI UI) come from a static YAML file
  `definitions/api_defaults.yml`, loaded by `getApiDefinition()`.

## Config & credentials

- Config object **`elevenlabs.settings`** with a single key `api_key` (schema
  `config/schema/elevenlabs.schema.yml`, install default empty in
  `config/install/elevenlabs.settings.yml`). `api_key` holds a **Key entity id**, resolved to the
  real secret at runtime via `key.repository`. Details → [config/settings.md](config/settings.md).

## Operations (from source)

- **Text-to-speech** — `ElevenlabsProvider::textToSpeech()` → `ElevenLabsApiService::textToSpeech()`
  → `POST /v1/text-to-speech/{voice_id}`. Long text is word-wrapped into ~5000-char chunks,
  generated per chunk with previous/next-text context, then the MP3 binaries are concatenated.
- **Speech-to-speech** — `speechToSpeech()` → `POST /v1/speech-to-speech/{voice_id}` (multipart
  audio upload), default model `eleven_english_sts_v2`.
- **Audio-to-audio (isolation)** — `audioToAudio()` → `ElevenLabsApiService::isolate()` →
  `POST /v1/audio-isolation` (multipart), noise removal.
- Discovery helpers on the service: `getModels()` (`GET /v1/models`), `getVoices()`
  (`GET /v1/voices`), `getUserInfo()` (`GET /v1/user`), `getHistoryListing()` (`GET /v1/history`).
  See [api/service.md](api/service.md) and [plugins/ai-provider.md](plugins/ai-provider.md).
