# Text-to-speech form

Route `openai_tts.tts_form` → `/admin/config/openai/tts` →
`\Drupal\openai_tts\Form\TextToSpeechForm` (form id `openai_tts_form`), gated by
`_permission: 'access openai tts'`. No stored config.

## Fields

| Field | Key | Options / default | Notes |
|-------|-----|-------------------|-------|
| Text to convert | `text` | required | ≤ 4096 chars (validated). |
| Model | `model` | `filterModels(['tts'])`, default `tts-1` | TTS model. |
| Voice | `voice` | alloy (default), echo, fable, onyx, nova, shimmer | OpenAI voice. |
| Response Format | `response_format` | mp3 (default), opus, aac, flac | Output audio format. |

## Runtime

`submitForm()`:
1. `$response = $this->api->textToSpeech($model, $text, $voice, $format)` (parent
   `OpenAIApi::textToSpeech()` — returns the raw audio bytes).
2. `file_system->saveData($response, 'public://tts_result-<currentTime>.<format>', EXISTS_REPLACE)`.
3. Creates a permanent `File` entity owned by the current user; stores `filepath`/`fid`/`filename`
   in form storage and rebuilds.

The `#ajax` callback `::getResponse` renders a download link (wrapper `#openai-tts-response`) using
`file_url_generator`. API exceptions are swallowed (empty `catch`).

Call from code:

    $bytes = \Drupal::service('openai.api')
      ->textToSpeech('tts-1', 'Hello from Drupal.', 'alloy', 'mp3');

Parent service reference: [../../../../../1.0.x/agent/api/service.md](../../../../../1.0.x/agent/api/service.md).
