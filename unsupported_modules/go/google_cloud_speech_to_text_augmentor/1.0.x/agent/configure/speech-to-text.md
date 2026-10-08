<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Google Cloud Speech-to-Text Augmentor — configuration

## Install
- Requires the `augmentor` module and the `google/cloud-speech` PHP library (`composer require drupal/augmentor_google_cloud_speech_to_text` pulls it in).
- Enable the module: `drush en augmentor_google_cloud_speech_to_text` (note: the machine name differs from the drupal.org project name `google_cloud_speech_to_text_augmentor`).

## Credentials
Create a Google Cloud service-account and download its JSON key. Store it via a Key entity whose `key_provider_settings['file_location']` points at that JSON file. `GoogleCloudSpeechToTextBase::setEnvironmentalCredentials()` sets `GOOGLE_APPLICATION_CREDENTIALS` from that path so the SDK can authenticate. No secret is written into module code or config.

## Add the augmentor
At `/admin/config/services/augmentor` add a "Google Cloud Speech-to-Text" augmentor. Configuration fields (`SpeechToText::buildConfigurationForm`):
- **Encoding** — one of the supported `AudioEncoding` values (default FLAC).
- **Sample Rate Hertz** — default 44100.
- **Max Alternatives** — default 1.
- **Language Code** — BCP-47 (default `en-US`).
- **Profanity Filter** — checkbox.
- **Speech Context** — comma-separated hint phrases.

## Execution
`execute(string $input)` reads the audio with `file_get_contents(urldecode($input))`, builds `RecognitionConfig`+`RecognitionAudio`, calls `SpeechClient::recognize()`, and returns `['default' => [ucfirst(transcript) . '.']]`.

## Security notes
- `Administer augmentors` grants full create/edit of augmentors — trusted roles only.
- Because the input path/URL is read server-side, ensure the augmentor consumes trusted, editor-controlled audio references (a media/file field), not arbitrary user-supplied request values.
