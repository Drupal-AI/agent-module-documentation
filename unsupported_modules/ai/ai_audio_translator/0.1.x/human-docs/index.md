# AI Audio Translator — manual setup guide

**AI Audio Translator** (`ai_audio_translator`) takes an audio media item in one
language and produces a new audio file in another. It does this by chaining three
AI operations together: **speech‑to‑text** to transcribe the original audio,
**chat** to translate the transcript into your chosen language, and
**text‑to‑speech** to re‑voice it as new audio. The whole job runs in the
background through a queue, so long recordings don't hold up the page.

Editors start a translation from a **Translate** action added to `audio_file`
media entities. A small dialog offers the target languages you've made available
(drawn from a taxonomy vocabulary you choose) and, on submit, queues the work. A
status entity tracks each translation (queued / processing / completed) and
remembers the resulting media item, so the same language is never translated
twice by accident.

All three AI steps run through providers configured in the Drupal **AI** module,
and their API keys are handled by the AI provider layer (typically via the Key
module) — this module never handles credentials itself.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings form (language
   vocabulary, translation prompt, provider overrides) and the day‑to‑day
   translate workflow.

## Where it lives in the admin menu

The settings form is at **Configuration → AI → AI Audio Translator**
(`/admin/config/ai/audio-translator`), behind the **Administer AI audio
translator** permission. Editors trigger translations from the **Translate**
operation on audio media, controlled by the separate **Translate audio media**
permission.

## How to use it

1. Configure a taxonomy vocabulary of target languages and set up the AI providers
   (see Configuration).
2. Give editors the **Translate audio media** permission.
3. An editor opens an `audio_file` media item, chooses **Translate**, picks a
   language and submits — this queues the job.
4. Cron drains the queue, or an administrator clicks **Run Now** on the settings
   form to process it immediately. When it finishes, the translated audio is
   available as a new media item.
