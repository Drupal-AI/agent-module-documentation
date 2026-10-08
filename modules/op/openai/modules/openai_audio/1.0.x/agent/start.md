# OpenAI Speech to Text (openai_audio) — agent index

Adds an admin form that transcribes or translates an audio file with OpenAI's Whisper endpoint and
shows the resulting text. Uses the parent `openai.api` service.

Dependency: `openai:openai`. `configure` = `openai_audio.audio_form`. Defines one permission; no
config, schema, or Drush of its own.

- **The audio form (file path, transcribe vs translate) and how text is returned** → [configure/audio_form.md](configure/audio_form.md)
- **Who can use it** → [permissions/permissions.md](permissions/permissions.md)

Parent (shared OpenAI client/service + API-key config): [../../../../1.0.x/agent/start.md](../../../../1.0.x/agent/start.md).

Key facts:
- Route `openai_audio.audio_form` → `/admin/config/openai/audio`, form
  `\Drupal\openai_audio\Form\AudioForm` (id `openai_audio_form`),
  `_permission: 'access openai audio'`.
- Permission `access openai audio` (`openai_audio.permissions.yml`).
- `submitForm()` calls `openai.api` → `OpenAIApi::speechToText('whisper-1', $path, $task)` where
  `$task` is `transcribe` or `translate` (translate = to English); the model is hard-coded `whisper-1`.
- Input is an **absolute server file path** typed into the form; the returned text is shown in a
  read-only textarea via the AJAX callback `::getResponse`.
- OpenAI limits: ≤ 25 MB, types mp3/mp4/mpeg/mpga/m4a/wav/webm (per the field description).
