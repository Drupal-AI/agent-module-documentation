<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Audio Generator (ai_audio_generator) — agent index

Converts a node's rendered text into one spoken-audio file (MP3, or WAV→MP3) using an **AI Core
text-to-speech provider** or a **direct Google Cloud TTS** integration. Chunks long text, generates
each chunk through the **Batch API**, concatenates in pure PHP, and attaches the result as a
Media entity on the node. Package `AI`. Core `^10.0 || ^11`. License GPL-2.0-or-later. Version 1.0.0-alpha3.

## Dependencies

Core `node`, `media`, `file`; contrib `ai` (AI Core — provider abstraction) and `key` (stores the
Google service-account JSON and CloudConvert API key). Optional Composer packages:
`google/cloud-text-to-speech` (direct Google path) and `cloudconvert/cloudconvert-php` (WAV→MP3).
No hard `require` in composer.json; both optional libs are `require-dev`/`suggest`.

## What it provides

- **Two admin routes** (`ai_audio_generator.routing.yml`), both `ConfigFormBase` forms:
  - `ai_audio_generator.settings` → `/admin/config/ai/audio-generator`, `SettingsForm`,
    permission `administer ai audio generator voice settings`.
  - `ai_audio_generator.dictionary` → `/admin/config/ai/audio-generator/dictionary`,
    `PronunciationDictionaryForm`, permission `administer ai audio generator pronunciation dictionary`.
  Menu links under *Configuration → AI* (`ai.admin_config_content`).
- **Two permissions** (`ai_audio_generator.permissions.yml`): the voice-settings one is
  `restrict access: true`.
- **Two config objects** with schema: `ai_audio_generator.settings` and
  `ai_audio_generator.dictionary` (`config/schema/ai_audio_generator.schema.yml`). Ships a
  `node.tts` view mode (`core.entity_view_mode.node.tts`).
- **Two services** (`ai_audio_generator.services.yml`, both autowired with class aliases):
  `TextExtractor` (renders node fields of a view mode to plain text; applies the dictionary) and
  `TextChunker` (splits text into <800-char chunks at paragraph→sentence→byte boundaries).
- **Hooks** (attribute-based): `NodeFormHooks::formNodeFormAlter` adds the *Save and generate Audio*
  submit button to node forms of enabled content types and builds the batch;
  `FormHooks::ginIgnoreStickyFormActions` excludes the dictionary form from Gin's sticky bar.
- **Batch callbacks** (`Batch\AudioGeneratorBatch`, all static): `processChunk`, `mergeChunks`,
  `convertWithCloudConvert`, `finished`.
- **Template** `templates/node--tts.html.twig` — browser preview of the TTS transcript.

## Solution docs

- **Install, settings form, config objects/schema, view mode, provider setup, Key module** →
  [config/settings.md](config/settings.md)
- **Generation pipeline: node-form button, extraction, chunking, batch, merge, CloudConvert,
  media attach, pronunciation dictionary** → [api/generation.md](api/generation.md)
