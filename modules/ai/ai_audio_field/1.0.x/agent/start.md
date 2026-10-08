<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Audio Field (ai_audio_field) — agent index

A **file field type** (`ai_audio_file`) whose MP3 is **generated from text by an AI text-to-speech
provider**, plus a widget to write text and Generate/Regenerate inline, plus two **AI Automators**
rules. Follow-up to ElevenLabs Field, now provider-agnostic. Version **1.0.0-rc1**, core
`^10.2 || ^11`, package `AI Tools`, license GPL-2.0-or-later. Depends on **`ai:ai` (`^1.0.5`)** and
core **`file`**. **No routes, no permissions, no config/schema, no Drush.**

- **The field type, its widget, the generation flow, settings, and the AI Automators rules** →
  [fields/audio-field.md](fields/audio-field.md)

## What it actually is (from source)

- **Field type** `ai_audio_file` — `src/Plugin/Field/FieldType/AiAudioField.php`, extends core
  `FileItem`. Extra stored properties beyond a file: `text`, `provider`, `model`, `configuration`.
  `default_widget = ai_audio_field_widget`, `default_formatter = file_default`.
  `isEmpty()` is true when `text` is empty. `preSave()` generates the audio (via `ai.provider`
  `textToSpeech`) when `text` is set but `target_id` is empty. Item list class
  `AiAudioFieldItem` (`src/.../AiAudioFieldItem.php`).
- **Widget** `ai_audio_field_widget` — `src/Plugin/Field/FieldWidget/AiAudioFieldWidget.php`, extends
  core `FileWidget`, applies to field types `ai_audio_file` **and** `file`. Text/provider/model +
  provider-config subform; a **Generate/Regenerate audio** AJAX submit calls the provider and stores
  the file; an inline `<audio>` preview player.
- **AI Automators** (require `ai_automators`) — `src/Plugin/AiAutomatorType/`:
  - `AiAudioFieldStory` (`id: ai_audio_file`, "Generate story") — LLM produces a multi-voice
    dialogue JSON, each line synthesised with a per-speaker voice/provider/model (`RuleBase`).
  - `AiAudioFieldMerge` (`id: ai_audio_file_merge`, "Merge Audio Files") — concatenates a field's
    files with **ffmpeg**; `ruleIsAllowed()` returns false when ffmpeg is absent (`ExternalBase`).
- Generation uses `Drupal\ai` `TextToSpeechInput` + the selected provider/model; provider selection
  and credentials are the **AI module's** responsibility (this module holds no keys/config).

## Files

- `src/Plugin/Field/FieldType/AiAudioField.php`, `AiAudioFieldItem.php`.
- `src/Plugin/Field/FieldWidget/AiAudioFieldWidget.php`.
- `src/Plugin/AiAutomatorType/AiAudioFieldStory.php`, `AiAudioFieldMerge.php`.
- `ai_audio_field.info.yml`, `composer.json` (no config, no routing, no permissions).

See [../usage.md](../usage.md) for prose and use cases.
