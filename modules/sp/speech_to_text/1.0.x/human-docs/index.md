# Speech to Text — manual setup guide

**Speech to Text** (`speech_to_text`) adds **dictation** to text fields. Using
the browser's built-in Web Speech API (`SpeechRecognition`), it lets editors speak
into text-input and textarea fields instead of typing — a convenience for faster
content entry and an accessibility aid for people who find typing difficult.

You tell the module which fields should get the dictation control by configuring
CSS selectors on its settings page; the module then attaches a voice-input control
to the matching fields. It has no other module dependencies and provides its own
permission.

**A privacy note worth passing on to your users.** The feature runs
**client-side in the visitor's browser**, and speech recognition is a browser
capability — in some browsers (notably Chrome) the captured **audio is sent to the
browser vendor's servers** (for example Google) to be transcribed. That is
browser behaviour, not something Drupal sends, but it is worth disclosing to
anyone who will use dictation so they understand where their voice data goes. The
module itself plays no content or access-control role beyond its permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — telling the module which fields
   should get the dictation control.

## Where it lives in the admin menu

Once enabled, configure the target fields at
`/admin/config/systems/speech-to-text`.
