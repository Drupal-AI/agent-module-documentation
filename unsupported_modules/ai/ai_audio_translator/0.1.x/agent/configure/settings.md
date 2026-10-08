<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure AI Audio Translator

Route: `/admin/config/ai/audio-translator` — permission `administer ai audio translator`.

Config object `ai_audio_translator.settings`:
- `language_vocabulary` — taxonomy vocabulary whose terms become selectable target languages (required before translation works; the modal shows an error otherwise).
- `translation_prompt` — appended to the system prompt; use `{language}` as the target-language placeholder. Default: "Translate the following text into {language}. Return only the translated text without explanation."
- `stt_provider`, `translation_provider`, `tts_provider` — `provider_id:model_id` strings selected from AI-module providers for each operation type (`speech_to_text`, `chat`, `text_to_speech`); leave empty to use AI module defaults.

Operation:
1. Configure a language vocabulary and add language terms.
2. Ensure AI providers for STT/chat/TTS are set up in the drupal/ai module (keys via Key module).
3. Editors use the **Translate** operation on an `audio_file` media entity, pick a language, and submit — this enqueues `ai_audio_translation`.
4. Cron drains the queue, or click **Run Now** on the settings form (`run_queue` route) to process immediately.

Each request is tracked by an `audio_translation` entity keyed by media id + term id; completed translations are not re-run unless deleted.
