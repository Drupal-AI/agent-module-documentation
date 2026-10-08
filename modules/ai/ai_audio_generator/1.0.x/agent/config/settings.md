<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration — settings, provider, Key, view mode

## Install & enable

```bash
composer require drupal/ai_audio_generator
drush en ai_audio_generator -y
```

Pulls in core `node`/`media`/`file` and contrib `ai` + `key`. For the direct Google path or WAV→MP3
compression, also install the optional libs (not required by composer.json):

```bash
composer require google/cloud-text-to-speech   # direct Google Cloud TTS
composer require cloudconvert/cloudconvert-php  # optional WAV→MP3 step
```

Install ships one view mode, `core.entity_view_mode.node.tts` (label *Text to Speech*), plus two
config objects with defaults (`config/install/`).

## Routes & permissions

`ai_audio_generator.routing.yml` defines two admin config-form routes:

| Route | Path | Form | Permission |
|---|---|---|---|
| `ai_audio_generator.settings` | `/admin/config/ai/audio-generator` | `Form\SettingsForm` | `administer ai audio generator voice settings` (**restrict access: true**) |
| `ai_audio_generator.dictionary` | `/admin/config/ai/audio-generator/dictionary` | `Form\PronunciationDictionaryForm` | `administer ai audio generator pronunciation dictionary` |

Both permissions are independent — the functional test `AiAudioGeneratorPermissionsTest` confirms
each grants access only to its own form (the other returns 403). Menu links
(`ai_audio_generator.links.menu.yml`) place both under *Configuration → AI*
(`ai.admin_config_content`).

## Config object `ai_audio_generator.settings`

Edited by `SettingsForm` (`getEditableConfigNames()`); schema in
`config/schema/ai_audio_generator.schema.yml`. Keys and install defaults:

| Key | Default | Meaning |
|---|---|---|
| `provider_type` | `ai_provider` | `ai_provider` (AI Core TTS) or `google_tts` (direct Google SDK). |
| `tts_provider` | `''` | `provider_id__model_id` string for the AI Core path; empty = AI Core global default for `text_to_speech`. |
| `tts_configuration` | `{}` | Provider-specific voice options (schema `type: ignore`). Built dynamically from `provider->getAvailableConfiguration('text_to_speech', $model)`; empty strings stripped on save. |
| `voice_instructions` | `''` | Optional style prompt (tone/pacing/accent) forwarded to providers that support an `instructions` param (e.g. OpenAI `gpt-4o-mini-tts`). |
| `google_tts_key_id` | `''` | Key module key ID holding the Google service-account JSON. |
| `google_tts_language_code` | `en` | BCP-47 language for direct Google TTS. |
| `google_tts_voice_name` | `''` | Optional Google voice name (e.g. `en-US-Wavenet-D`). |
| `cloudconvert_key_id` | `''` | Key module key ID for the CloudConvert API key; when set, WAV output is compressed to MP3. |
| `content_types` | `{}` | Map of `node_type => {view_mode, media_type, media_field, filename_template}` — only enabled types are stored. |

`SettingsForm::buildForm()` renders the provider radios, an AJAX-rebuilt voice sub-form
(`ajaxVoiceConfig` / `buildVoiceConfigFields`, wrapper `tts-voice-config-wrapper`), the Google
section (`key_select`, language `select`, voice textfield), a CloudConvert `details`, and a
per-content-type `Content Type Settings` details. `HIDDEN_CONFIG_KEYS = ['response_format']` is
omitted from the UI because the batch forces `response_format => mp3`.

`validateForm()`: for each enabled content type, requires `media_type` and `media_field`; warns
(non-blocking) if `google_tts` is selected but the Google SDK class is absent, or if a CloudConvert
key is set but the CloudConvert SDK class is absent. `submitForm()` writes only enabled types,
`array_filter`s empty voice values, and trims scalar fields.

### Per-content-type settings

Inside `content_types[<type>]`:

- `enabled` (checkbox — presence of a saved entry means enabled),
- `view_mode` (defaults to `tts`; options are all node view modes),
- `media_type` (target media bundle; must support audio/MP3),
- `media_field` (a node `entity_reference` field whose `target_type` is `media`),
- `filename_template` (optional; node tokens like `[node:nid]`, `[node:title]`; default
  `final_audio_[node:nid]`).

## Config object `ai_audio_generator.dictionary`

`entries` = sequence of `{original, replacement}` mappings (default `[]`). Managed by
`PronunciationDictionaryForm`; see [../api/generation.md](../api/generation.md) for validation and
how entries are applied.

## Provider & Key setup

- **AI Core path** (`provider_type = ai_provider`): configure an AI provider that offers
  `text_to_speech` in the `ai` module, then pick it under *TTS Provider & Model* (or leave blank
  to use AI Core's global default). Voice options come from the provider's own
  `getAvailableConfiguration()`.
- **Direct Google path** (`provider_type = google_tts`): create a Google Cloud service-account JSON
  key, store it as a Key entity (File or Configuration provider), and select it under *Service
  Account JSON key*. The batch reads it via `key.repository` and `Json::decode()`.
- **CloudConvert** (optional): store the CloudConvert API key as a Key entity and select it; the
  batch adds a WAV→MP3 step (no-op when the provider already returns MP3).

## Text to Speech view mode

The shipped `node.tts` view mode is how you curate what gets read aloud: at
`/admin/structure/types/manage/<type>/display/tts`, enable only the fields to voice, set labels to
*Hidden*, and use plain-text formatters. `TextExtractor::extractPlainText()` reads **only** fields
explicitly placed in that view mode's config (base fields auto-injected by the display are skipped).
The `templates/node--tts.html.twig` template renders the same transcript in the browser for preview.
