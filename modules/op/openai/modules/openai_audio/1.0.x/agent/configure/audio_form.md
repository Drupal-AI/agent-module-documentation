# Speech-to-text (audio) form

Route `openai_audio.audio_form` → `/admin/config/openai/audio` →
`\Drupal\openai_audio\Form\AudioForm` (form id `openai_audio_form`), gated by
`_permission: 'access openai audio'`. No stored config.

## Fields

| Field | Key | Options / default | Notes |
|-------|-----|-------------------|-------|
| Audio file path | `audio` | required | The **absolute path** to the audio file on the server. |
| Task | `task` | `transcribe` (default) / `translate` | Transcribe = same language; Translate = to English. |
| Response | `response` | read-only | Output textarea, wrapper `#openai-audio-response`. |

Field description notes OpenAI's limits: max 25 MB; allowed types mp3, mp4, mpeg, mpga, m4a, wav,
webm. `validateForm()` is empty.

## Runtime

`submitForm()` calls
`$this->api->speechToText('whisper-1', $audio, $task)` (parent `OpenAIApi::speechToText()`; model
hard-coded to `whisper-1`). That service opens the path (`fopen($file, 'r')`), sends it to OpenAI's
`audio()->transcribe`/`translate`, and returns `result['text']`. The AJAX callback `::getResponse`
puts the text into `response`.

`OpenAIApi::speechToText()` throws `\InvalidArgumentException` if `$task` is not `transcribe` or
`translate`; on API errors it logs to the `openai` channel and returns `''`.

Call from code:

    $text = \Drupal::service('openai.api')
      ->speechToText('whisper-1', '/path/to/audio.mp3', 'transcribe');

Parent service reference: [../../../../../1.0.x/agent/api/service.md](../../../../../1.0.x/agent/api/service.md).
