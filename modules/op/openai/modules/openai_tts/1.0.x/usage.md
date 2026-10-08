OpenAI Text to Speech adds an admin form that turns text into spoken audio using OpenAI's TTS models,
letting you pick a voice and output format and saving the generated audio as a downloadable file in
the site's public files.

---

The module provides one form at `/admin/config/openai/tts` (`TextToSpeechForm`), gated by the
`access openai tts` permission. It exposes the text input (max 4096 characters), a model select
(`filterModels(['tts'])`, default `tts-1`), a voice select (alloy/echo/fable/onyx/nova/shimmer) and a
format select (mp3/opus/aac/flac). On submit it calls the parent `openai.api` service's
`OpenAIApi::textToSpeech()`, writes the returned audio bytes to `public://tts_result-<timestamp>.<format>`
as a permanent `File` entity owned by the current user, and renders a download link via AJAX. It has
no configuration object or Drush command and depends on the parent OpenAI module for the API
key/service.

---

- Generate an audio version of a short article or notice.
- Create voiceovers for demos or presentations.
- Produce spoken audio in different OpenAI voices.
- Compare voices (alloy, nova, shimmer, etc.) for a brand.
- Export audio as MP3, Opus, AAC or FLAC.
- Add narrated audio files to content or media.
- Prototype an accessibility read-aloud feature.
- Create audio snippets for social or marketing use.
- Generate pronunciation samples for names or terms.
- Produce placeholder audio during site building.
- Save generated speech as a reusable File entity.
- Test TTS quality before automating it in a workflow.
- Create audio for e-learning or training content.
- Generate spoken alerts or announcements.
- Provide editors an in-admin text-to-speech tool.
- Localize spoken output by supplying translated text.
- Build a library of narrated content files.
- Convert short scripts into audio quickly.
- Evaluate model/voice combinations for a project.
- Generate audio for QA of media players.
