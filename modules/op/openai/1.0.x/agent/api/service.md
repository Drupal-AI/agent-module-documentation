# The `openai.api` service

Service id `openai.api`, class `\Drupal\openai\OpenAIApi`. Constructed with the
`openai.client` (`OpenAI\Client`), `cache.default`, and `logger.factory`. This is the single
wrapper all submodules call; call it from your own code the same way.

```php
$api = \Drupal::service('openai.api'); // or inject it
```

## Methods
| Method | Signature (args) | Returns / notes |
|---|---|---|
| `getModels()` | — | array of available models (cached). |
| `filterModels(array $model_type)` | model-type filter | subset of models. |
| `completions($model, $prompt, $temperature, $max_tokens = 512, $stream_response = FALSE)` | legacy completions endpoint | text; streamed response when `$stream_response`. |
| `chat($model, array $messages, $temperature, $max_tokens = 512, $stream_response = FALSE, $seed = NULL)` | chat completion; `$messages` = `[['role'=>…, 'content'=>…], …]` | assistant text; streamable. |
| `images($model, $prompt, $size, $response_format, $quality = 'standard', $style = 'natural')` | DALL·E image generation | image URL/data per `$response_format`. |
| `textToSpeech($model, $input, $voice, $response_format)` | TTS | audio bytes. |
| `speechToText($model, $file, $task = 'transcribe', $temperature = 0.4, $response_format = 'verbose_json')` | Whisper | transcription/translation. |
| `moderation($input)` | moderation endpoint | **bool** — TRUE if content is flagged. |
| `embedding($input)` | embeddings endpoint | array embedding vector. |

## Notes
- `completions()` vs `chat()`: submodules pick `chat()` when the model id contains `gpt`,
  else `completions()`.
- Streaming: `chat()`/`completions()` return a streamed response object when
  `$stream_response = TRUE` (used by the CKEditor endpoint to stream into the editor).
- Prepare user/content text with `\Drupal\openai\Utility\StringHelper::prepareText()` first —
  it strips `pre/code/script/iframe/drupal-media` and truncates to `$max_length` (default
  10000 chars) to cut tokens.
- Model listing is cached via `cache.default`; errors are logged through `logger.factory`.

## Low-level client
`openai.client` is the raw `OpenAI\Client` from `openai-php/client` if you need an endpoint
the wrapper doesn't cover.
