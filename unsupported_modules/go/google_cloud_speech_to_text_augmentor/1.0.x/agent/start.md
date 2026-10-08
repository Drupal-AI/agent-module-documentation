<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Google Cloud Speech-to-Text Augmentor — agent index

**Augmentor plugin that transcribes audio to text via the Google Cloud Speech-to-Text API.**

- **Version:** 1.0.x
- **Core:** `^9.3 || ^10`
- **Project:** `google_cloud_speech_to_text_augmentor` — **module machine name to enable:** `augmentor_google_cloud_speech_to_text` (Composer `drupal/augmentor_google_cloud_speech_to_text`).
- **Dependency:** `augmentor`; **library:** `google/cloud-speech:^1.6`.
- **Plugin:** `@Augmentor` id `google_cloud_speech_to_text` (`Plugin\Augmentor\SpeechToText`).
- **Config:** via the Augmentor UI at `/admin/config/services/augmentor` (permission `Administer augmentors`).

**Security:** credentials come from a Key entity → `GOOGLE_APPLICATION_CREDENTIALS` env var (no hard-coded secret); the Google SDK uses TLS by default. `execute()` runs `file_get_contents(urldecode($input))` (SpeechToText.php:123) on the augmentor input — keep it wired to trusted editor/field sources, not raw request data. `Administer augmentors` is security-sensitive. See [configure/speech-to-text.md](configure/speech-to-text.md).
