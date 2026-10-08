# AI Audio Field — manual setup guide

**AI Audio Field** (`ai_audio_field`) adds an audio field to Drupal that is
enriched by AI. On top of storing an audio file, the field taps the AI module to
add AI‑driven audio features — for example generating audio or producing a
transcription — so an audio field becomes more than a plain file upload.

It builds directly on Drupal's **AI** module and core's **File** module: the File
module handles the audio file itself, while the AI module supplies the provider
that does the AI work. It is a field‑level building block you add to a content
type, rather than a standalone screen.

Because the AI features **send audio or text to your configured AI provider**, data
leaves your site for that provider — confirm that is acceptable for the content you
process. The provider's API key is held by the AI module via the Key module as a
secret, and everything travels over HTTPS. This module adds no permissions of its
own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is no central settings page. You use AI Audio Field by adding it as a
**field** to a content type (or other fieldable entity) under **Structure →
(entity) → Manage fields**, then configuring the field like any other. The AI
behaviour depends on having a provider set up in the AI module.

## How to use it

1. Configure an AI provider in the AI module first, with its key stored via the
   Key module.
2. On the content type where you want AI‑enriched audio, add an **AI Audio Field**
   under *Manage fields*.
3. Adjust the field's settings, then create or edit content — the field stores the
   audio and applies the AI enrichment (such as transcription or generated audio)
   through your provider.
