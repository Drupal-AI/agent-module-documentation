<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `elevenlabs` AI provider plugin

`src/Plugin/AiProvider/ElevenlabsProvider.php` — registered with the AI module via the
`#[AiProvider(id: 'elevenlabs', label: 'ElevenLabs')]` attribute and extending
`Drupal\ai\Base\AiProviderClientBase`. It is discovered as an AI provider; callers use it through
the AI module's `ai.provider` plugin manager, choosing the operation type rather than the vendor.

## Interfaces / operation types

Implements `ContainerFactoryPluginInterface`, `AudioToAudioInterface`, `SpeechToSpeechInterface`,
`TextToSpeechInterface`. `getSupportedOperationTypes()` returns:

```
text_to_speech
speech_to_speech
audio_to_audio
```

`create()` injects the `elevenlabs.api` service (`$this->client`) and `entity_type.manager`.
`getConfig()` returns the immutable `elevenlabs.settings` config. `isUsable()` returns FALSE if no
`api_key` is set, otherwise TRUE (or membership in the supported list when an operation type is
passed). `setAuthentication($key)` forwards to `ElevenLabsApiService::setApiKey()` so the AI module
can override the credential at runtime.

## Settings surfaced to the AI UI

`getApiDefinition()` loads and returns `definitions/api_defaults.yml` (parsed with `Symfony\Yaml`).
That file defines, per operation type, the input/authentication/configuration schema shown in the
AI module's forms:

- **text_to_speech** config keys: `model` (default `eleven_multilingual_v2`), `speed` (0.7–1.2),
  `stability` (0–1), `similarity_boost` (0–1), `style` (0–1), `seed` (0–4294967295),
  `use_speaker_boost` (bool), `apply_text_normalization` (`auto`/`on`/`off`).
- **speech_to_speech** config keys: `model` (default `eleven_english_sts_v2`), `stability`,
  `similarity_boost`, `style`, `use_speaker_boost`.

`getConfiguredModels($operation_type)` calls `$this->client->getModels()` and filters the live
model list: models with `can_do_text_to_speech` for TTS, `can_do_voice_conversion` for
speech-to-speech, and a synthetic `default => 'Default'` entry for audio_to_audio.

`getModelSettings($model_id, $generalConfig)` calls `$this->client->getVoices()` and builds a
**voice** select for the chosen model: each option value is `"{name} :: {voice_id}"`, with an HTML
description listing the voice id, its ElevenLabs `labels`, and a preview-URL link. If no voice
matches the model's `high_quality_base_model_ids`, the `voice` element is removed.

## Operation methods

### `textToSpeech(string|TextToSpeechInput $input, string $model_id, array $tags = [])`
- Normalises the text, hashes it (`md5`) for filenames.
- Word-wraps into ~5000-char chunks (`$chunk_length = 5000`) and rebuilds chunks to be near the
  limit. `model` and `voice` are pulled from `$this->configuration`; the voice id is
  `explode(' :: ', $this->configuration['voice'])[1]`.
- For long text it loops the chunks, setting `previous_text` / `next_text` context on each call,
  then concatenates all returned MP3 binaries into one `AudioFile`. Short text is a single call.
- Each call → `ElevenLabsApiService::textToSpeech($chunk, $voice_id, $model_id, $configuration)`.
  Empty responses throw `AiBadRequestException('No audio found')`. Returns `TextToSpeechOutput`
  wrapping one `AudioFile` (`audio/mpeg`, `elevenlabs-tts-{hash}.mp3`).

### `speechToSpeech(string|array|SpeechToSpeechInput $input, string $model_id, array $tags = [])`
- Gets the audio binary, pulls `model`/`voice` from configuration, calls
  `ElevenLabsApiService::speechToSpeech($audio, $voice_id, $model, $configuration)`. Returns a
  `SpeechToSpeechOutput` (`elevenlabs-speech-to-speech.mp3`).

### `audioToAudio(string|array|AudioToAudioInput $input, string $model_id, array $tags = [])`
- Gets the audio binary, calls `ElevenLabsApiService::isolate($audio)` (noise/voice isolation),
  returns an `AudioToAudioOutput` (`elevenlabs.mp3`).

`getClient()` returns the raw `ElevenLabsApiService`. The plugin also keeps a `$temporaryFiles`
array and deletes those file entities in `__destruct()`.

See [../api/service.md](../api/service.md) for the actual endpoints and request construction.
