# OpenAI Text to Speech (openai_tts) — agent index

Adds an admin form that converts text to spoken audio via OpenAI's TTS endpoint and saves the result
as a downloadable file. Uses the parent `openai.api` service.

Dependency: `openai:openai`. `configure` = `openai_tts.tts_form`. Defines one permission; no config,
schema, or Drush of its own.

- **The text-to-speech form (model, voice, format) and how the file is saved** → [configure/tts_form.md](configure/tts_form.md)
- **Who can use it** → [permissions/permissions.md](permissions/permissions.md)

Parent (shared OpenAI client/service + API-key config): [../../../../1.0.x/agent/start.md](../../../../1.0.x/agent/start.md).

Key facts:
- Route `openai_tts.tts_form` → `/admin/config/openai/tts`, form
  `\Drupal\openai_tts\Form\TextToSpeechForm` (id `openai_tts_form`),
  `_permission: 'access openai tts'`.
- Permission `access openai tts` (`openai_tts.permissions.yml`).
- `submitForm()` calls `openai.api` → `OpenAIApi::textToSpeech($model, $text, $voice, $response_format)`,
  writes the audio to `public://tts_result-<timestamp>.<format>` as a permanent File entity owned by
  the current user, and links to it.
- Model options from `filterModels(['tts'])`, default `tts-1`. Voices: alloy/echo/fable/onyx/nova/
  shimmer. Formats: mp3/opus/aac/flac. Input capped at 4096 characters.
