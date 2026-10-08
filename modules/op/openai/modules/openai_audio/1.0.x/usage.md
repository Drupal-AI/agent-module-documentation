OpenAI Speech to Text adds an admin form that sends an audio file to OpenAI's Whisper endpoint and
returns the transcription — or a translation into English — as text. It is an explorer/utility form
for testing OpenAI's speech-to-text capability from inside Drupal.

---

The module provides one form at `/admin/config/openai/audio` (`AudioForm`), gated by the
`access openai audio` permission. You supply the absolute path to an audio file and choose a task
(transcribe = same language, translate = to English); on submit it calls the parent `openai.api`
service's `OpenAIApi::speechToText()` with the hard-coded `whisper-1` model, and the resulting text is
shown in a read-only textarea via AJAX. OpenAI's own limits apply (max 25 MB; mp3, mp4, mpeg, mpga,
m4a, wav, webm). It has no configuration object or Drush command and depends on the parent OpenAI
module for the API key and service.

---

- Transcribe a recorded meeting or interview to text.
- Translate foreign-language audio into English text.
- Generate a rough transcript for a podcast episode.
- Produce captions/subtitles source text from audio.
- Test Whisper transcription quality on sample files.
- Convert voice memos into editable text.
- Draft show notes from a recording.
- Extract quotes from an audio interview.
- Create searchable text from audio archives.
- Prototype a transcription workflow before automating it.
- Provide editors an in-admin speech-to-text tool.
- Transcribe user-submitted audio for review.
- Generate text for accessibility from audio content.
- Translate multilingual recordings for a global audience.
- Check transcription accuracy across audio formats.
- Turn lecture recordings into study notes.
- Produce transcripts for compliance or records.
- Convert webinar audio into a written summary source.
- Evaluate Whisper against other transcription tools.
- Generate transcripts for QA of media content.
