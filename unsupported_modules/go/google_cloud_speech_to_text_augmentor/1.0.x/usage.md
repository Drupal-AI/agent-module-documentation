<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Provides an Augmentor plugin that sends audio to the Google Cloud Speech-to-Text API and returns the transcribed text.
---
This is an Augmentor provider submodule (project `google_cloud_speech_to_text_augmentor`; the enabled module machine name is `augmentor_google_cloud_speech_to_text`, Composer package `drupal/augmentor_google_cloud_speech_to_text`). It registers a `@Augmentor` plugin, `google_cloud_speech_to_text`, whose config form exposes the recognition settings — encoding (FLAC/LINEAR16/…), sample rate, max alternatives, BCP-47 language code, profanity filter and speech context hints. When executed with an audio input it reads the file, builds a `RecognitionConfig`/`RecognitionAudio`, calls the official `google/cloud-speech` PHP SDK's `SpeechClient::recognize()`, and returns the most-likely transcript.

Credentials are handled through the Augmentor Key integration: `setEnvironmentalCredentials()` sets the `GOOGLE_APPLICATION_CREDENTIALS` env var from the associated Key's `key_provider_settings['file_location']` (a service-account JSON file path) — no secret is hard-coded, and the SDK negotiates TLS/gRPC to Google by default. Two things to note operationally: `execute()` calls `file_get_contents(urldecode($input))` on the augmentor's input value, so whatever path/URL is fed to the augmentor is read server-side (keep the augmentor wired to trusted, editor-controlled field/file sources rather than raw request input); and the `Administer augmentors` permission is security-sensitive (grant to trusted roles only). Configuration lives entirely inside the Augmentor UI at `/admin/config/services/augmentor`.

Setup: install `augmentor` and the `google/cloud-speech` library, enable this module, create a Key pointing at a Google service-account JSON, then add a Speech-to-Text augmentor and select the key.
---
- Transcribe uploaded audio files to text inside Drupal.
- Add a Google Cloud Speech-to-Text provider to the Augmentor framework.
- Configure the audio encoding (FLAC, LINEAR16, MULAW, OGG_OPUS, …).
- Set the sample rate in Hertz to match the source audio.
- Choose a BCP-47 language/locale for recognition.
- Request multiple alternative transcriptions.
- Toggle the profanity filter on transcripts.
- Provide speech-context hint phrases to improve accuracy.
- Store Google credentials in a Key entity (service-account JSON), not in code.
- Chain the augmentor into an entity/field workflow via Augmentor.
- Auto-generate captions/notes from a media audio field.
- Feed transcripts into other augmentors or fields.
- Build an accessibility workflow that captions audio content.
- Restrict augmentor administration to trusted roles.
- Point the augmentor at editor-controlled audio sources (avoid raw request input).
- Reuse the official `google/cloud-speech` SDK client from the plugin.
- Localise transcription per site language.
- Return the top transcript concatenated as the augmentor output.
