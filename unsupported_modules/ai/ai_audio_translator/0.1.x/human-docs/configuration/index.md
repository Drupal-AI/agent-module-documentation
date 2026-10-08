# Configuration

AI Audio Translator is configured at **Configuration → AI → AI Audio Translator**
(`/admin/config/ai/audio-translator`). You need the **Administer AI audio
translator** permission to open it.

## Before you start

Make sure the **AI** module has providers set up for the three operations this
module chains — speech‑to‑text, chat (translation) and text‑to‑speech — with their
keys stored via the Key module. Without those, translations cannot run.

## The settings form

- **Language vocabulary** — the taxonomy vocabulary whose terms become the
  selectable target languages in the Translate dialog. **This is required**: until
  you choose a vocabulary and add language terms to it, the translate dialog shows
  an error and nothing can be translated. Create a vocabulary (for example
  "Translation languages"), add a term per language you want to offer, and select
  it here.
- **Translation prompt** — the instruction appended to the system prompt for the
  chat/translation step. Use the placeholder **`{language}`** where the target
  language should appear. The default is:
  *"Translate the following text into {language}. Return only the translated text
  without explanation."* Adjust it if you want a particular tone or handling.
- **Speech‑to‑text provider**, **Translation (chat) provider**, **Text‑to‑speech
  provider** — each is a `provider_id:model_id` choice drawn from the providers you
  configured in the AI module for that operation type. Leave any of them **empty**
  to fall back to the AI module's default provider for that operation.

Save the form to apply your settings.

## Running translations

1. Add language terms to your chosen vocabulary.
2. An editor with the **Translate audio media** permission opens an `audio_file`
   media entity and chooses the **Translate** operation.
3. In the dialog they pick a target language and submit. This enqueues a job on the
   `ai_audio_translation` queue and creates a status entity that tracks progress
   (queued → processing → completed) and records the resulting media id.
4. The queue is processed by **cron**, or immediately when you click **Run Now** on
   the settings form. You can also see the current queue depth from the settings
   page.

Each translation is keyed by the media item plus the target language, so a
completed translation is **not re‑run** unless you delete it — delete the existing
translation to force a fresh pass.
