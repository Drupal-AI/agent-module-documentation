<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `elevenlabs.api` — ElevenLabsApiService

`src/ElevenLabsApiService.php`. The thin Guzzle wrapper the provider plugin uses. Registered in
`elevenlabs.services.yml`:

```yaml
services:
  elevenlabs.api:
    class: Drupal\elevenlabs\ElevenLabsApiService
    arguments: [ '@config.factory', '@http_client', '@key.repository', '@cache.default', '@logger.factory' ]
```

- Base URL: `protected string $basePath = 'https://api.elevenlabs.io/v1/'`.
- Default TTS model: `public static string $defaultModel = 'eleven_multilingual_v2'`.
- The constructor resolves the API key from config `elevenlabs.settings:api_key` (a Key entity id)
  via `key.repository` → `getKey($id)->getKeyValue()`; `setApiKey()` can override it.

## Public methods

| Method | HTTP | Endpoint | Notes |
|---|---|---|---|
| `isSetup()` | GET | `user` | Returns TRUE if `getUserInfo()` succeeds. |
| `getUserInfo()` | GET | `user` | Account info (JSON-decoded). |
| `getVoices()` | GET | `voices` | Cached 1h under `elevenlabs_voices_list`. |
| `getModels()` | GET | `models` | Cached 1h under `elevenlabs_models_list`. |
| `getHistoryListing($pageSize=10)` | GET | `history?page_size=N` | Generation history. |
| `textToSpeech($text,$voice_id,$model_id,$options)` | POST | `text-to-speech/{voice_id}` | JSON body, returns MP3 binary. |
| `speechToSpeech($audio,$voiceId,$modelId,$options)` | POST | `speech-to-speech/{voiceId}` | multipart audio upload. |
| `isolate($audio)` | POST | `audio-isolation` | multipart audio upload, noise removal. |

`getVoices()` / `getModels()` read `cache.default`; on a miss they call the API and
`$this->cache->set(..., time() + 3600)` (1-hour TTL). `textToSpeech()` builds a `voice_settings`
sub-object (`stability`, `similarity_boost`, `style`, optional `speed`, `use_speaker_boost`) plus
a `text`/`model_id` payload, and copies a fixed allowlist of root-level params from `$options`
(`apply_text_normalization`, `seed`, `previous_text`, `next_text`, `language_code`, etc.).

## Request construction — `private call()`

```php
private function call(string $endpoint, string $method = "GET", array $payload = [],
                      array $queryString = [], array $options = []): string {
  if (empty($this->apiKey)) {
    $this->loggerChannel->error('API request failed: No API Key set.');
    throw new \Exception("No API Key set.");
  }
  $guzzleOptions = [
    'connect_timeout' => 5,
    'timeout' => 120,
    'headers' => [ 'xi-api-key' => $this->apiKey ],
  ];
  if (!isset($options['multipart'])) {
    $guzzleOptions['headers']['Content-Type'] = 'application/json';
  }
  $guzzleOptions = array_merge_recursive($options, $guzzleOptions);
  if (!empty($payload)) { $guzzleOptions['json'] = $payload; }
  $url = $this->basePath . $endpoint;
  if (count($queryString)) { $url .= '?' . http_build_query($queryString); }
  ...
  $res = $this->client->request($method, $url, $guzzleOptions);
  return $res->getBody();
}
```

- Auth is the **`xi-api-key` header** — the key is never placed in the URL or query string.
- The client is Drupal's shared `@http_client`; no per-request options disable TLS verification
  (Drupal verifies certificates by default), so calls to `api.elevenlabs.io` are TLS-verified.
- Timeouts: 5s connect, 120s total. JSON requests get `Content-Type: application/json`; multipart
  uploads (speech-to-speech, isolation) omit it so Guzzle sets the boundary.
- Errors are logged to the `elevenlabs` channel and re-thrown as `\Exception`. The endpoint path
  (not the key) is logged at notice level; the target URL may be printed via `drush_print` when
  running under Drush.

`getBody()` returns the raw response, so binary methods (`textToSpeech`, `speechToSpeech`,
`isolate`) yield the MP3 bytes directly, while the JSON helpers `json_decode()` the body.
