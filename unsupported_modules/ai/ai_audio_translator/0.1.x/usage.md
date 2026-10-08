<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI Audio Translator turns an audio media entity into translated audio by chaining the AI module's speech-to-text, chat translation and text-to-speech operations through a queue.
---
Editors trigger translation from a "Translate" operation link added to `audio_file` media entities (`MediaOperations::entityOperation`, gated by `translate audio media`). A modal `TranslateForm` offers target languages drawn from a configurable taxonomy vocabulary and enqueues an `ai_audio_translation` queue item; an `AudioTranslation` content entity tracks status (queued/processing/completed) and the resulting translated media id, preventing duplicate work.

The queue worker performs STT → translate → TTS using providers resolved from the AI module. The settings form (`/admin/config/ai/audio-translator`, `administer ai audio translator`) lets you pick the language vocabulary, the translation prompt (with a `{language}` placeholder), and optional STT/chat/TTS provider+model overrides — leaving them empty uses the AI module defaults. A `Run Now` link and the `run_queue` route process the queue on demand. All AI credentials are managed by the drupal/ai provider layer (typically via the Key module), not by this module.
---
- Add a "Translate" action to audio media in the media library.
- Transcribe an audio file to text with an AI speech-to-text provider.
- Translate the transcript into a chosen target language.
- Generate a translated audio file with an AI text-to-speech provider.
- Offer target languages from a taxonomy vocabulary you select.
- Customise the translation prompt with a `{language}` placeholder.
- Override the speech-to-text provider and model.
- Override the translation (chat) provider and model.
- Override the text-to-speech provider and model.
- Queue translations for background processing via cron.
- Run the translation queue immediately from the settings page.
- Track per-language translation status on `AudioTranslation` entities.
- Prevent duplicate queue items for an already-queued language.
- Skip re-translation when a completed translation already exists.
- Grant editors the `translate audio media` permission only.
- Restrict provider/vocabulary configuration to administrators.
- Inspect queue depth from the settings form.
- Delete an existing translation to force a re-run.
- Localise long-form audio content for multilingual sites.
- Reuse AI module provider credentials managed by the Key module.