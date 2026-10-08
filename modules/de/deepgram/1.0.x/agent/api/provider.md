<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Deepgram — AI provider plugin & raw client

## The provider plugin

`src/Plugin/AiProvider/DeepgramProvider.php`, attribute `#[AiProvider(id: 'deepgram',
label: 'Deepgram')]`, extends the AI module's `AiProviderClientBase` and implements
`SpeechToTextInterface` and `TextToSpeechInterface`. It is selected/consumed through the AI
module's provider abstraction — there is no Deepgram-specific route for running operations.

Key methods:

- `getSupportedOperationTypes()` → `['speech_to_text', 'text_to_speech']`.
- `isUsable($op)` → `FALSE` unless `provider_deepgram.settings:api_key` is set; otherwise checks
  the operation is one of the two supported types.
- `getConfig()` → the `provider_deepgram.settings` immutable config.
- `getApiDefinition()` → parses `definitions/api_defaults.yml` (declares the `input` and
  `authentication`/`configuration` schema for each operation type; TTS defaults include
  `bit_rate: 48000` and `encoding` one of mp3/opus/linear16/alaw/flac/aac).
- `getConfiguredModels($op)` → model lists:
  - `speech_to_text`: `nova-2` (Nova 2), `nova` (Nova), `base` (Base).
  - `text_to_speech`: the Aura English voices `aura-asteria-en`, `aura-luna-en`,
    `aura-stella-en`, `aura-athena-en`, `aura-hera-en`, `aura-orion-en`, `aura-arcas-en`,
    `aura-perseus-en`, `aura-angus-en`, `aura-orpheus-en`, `aura-helios-en`, `aura-zeus-en`.
- `setAuthentication($key)` → overrides the client's API key at runtime.
- `getClient()` → returns the raw `Drupal\deepgram\Deepgram` service.

### speech_to_text

`speechToText($input, $model_id, $tags)`: normalises `$input` (a `SpeechToTextInput` or raw
binary) into a temporary `file` entity via `generateTemporaryFile()` (`FileSystem::saveData`
into the temp dir, status 0), calls `Deepgram::transcribe($file, $config)`, then reads
`results.channels[0].alternatives[0].transcript` from the JSON. Missing transcript →
`AiBadRequestException('No transcription found')`. Returns a `SpeechToTextOutput(transcript,
$rawResponse, $rawResponse['metadata'])`. Temp files are deleted in the plugin's `__destruct()`.

### text_to_speech

`textToSpeech($input, $model_id, $tags)`: extracts text from a `TextToSpeechInput` (or raw
string), calls `Deepgram::textToSpeech($text, $config)`. Empty result →
`AiBadRequestException('No audio found')`. Wraps the binary in an
`AudioFile($binary, 'audio/mpeg', 'deepgram.mp3')` inside a `TextToSpeechOutput`.

## The raw client — `Drupal\deepgram\Deepgram` (service `deepgram.api`)

Constructed with `@http_client`, `@config.factory`, `@key.repository`. Base path
`https://api.deepgram.com/v1/`.

- `transcribe(File $file, $config = [])`: returns `[]` if no API key. Builds the query from
  `$config` — `model` (default `general`), optional `language`, and the boolean flags
  `detect_language`, `punctuate` (default TRUE), `diarize`, `smart_format`, `filter_words`
  (each rendered `true`/`false` by `boolToString()`). POSTs the file bytes
  (`file_get_contents($file->getFileUri())`) to `listen`; returns the decoded JSON array.
- `textToSpeech($text, $config = [])`: returns `[]` if no API key. Query `model`
  (default `aura-asteria-en`), `bit_rate` (default 128000), `format` (default `mp3`).
  POSTs `$text` to `speak`; returns the raw audio body string.
- `makeRequest($path, $query, $method, $body, $options)`: sets 30s connect/read timeouts and the
  `Authorization: Token <apiKey>` header, appends `http_build_query($query)`, and issues the
  Guzzle request against `basePath . $path`. Returns the response body stream.

### Operational notes

- Calls go over HTTPS with Guzzle's default TLS verification (no verification is disabled).
- The audio source for transcription is always a local `File` entity supplied by the AI module
  caller — the client never fetches a caller-supplied remote URL.
- `text_to_speech` output is English-only Aura voices.
