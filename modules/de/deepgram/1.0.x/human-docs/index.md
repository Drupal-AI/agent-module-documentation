# Deepgram — manual setup guide

**Deepgram** (`deepgram`) is an **AI provider** for Drupal's **AI** module,
bringing Deepgram's **Speech‑to‑Text** (transcription) and **Text‑to‑Speech**
(voice synthesis) services into Drupal. Deepgram is a well‑regarded transcription
service that turns audio into text — with advanced options like exact timestamps,
speaker diarization, and smart formatting — and can also generate very realistic
speech from text (English). Because it plugs into the AI module's provider
abstraction, any feature or third‑party module that uses the AI module for
speech‑to‑text or text‑to‑speech can now use Deepgram as the engine behind it. It
also replaces the older Deepgram transcribe rules and makes them generically
available through the **AI Automator** (previously the AI Interpolator).

The module depends on the **AI** module (`ai`) and the **Key** module (`key`), and
lives in the **AI Providers** package. It requires a **Deepgram account** and API
key — Deepgram offers free trials.

On credentials, the module does the right thing: it uses the **Key** module, so
your Deepgram API key is stored as a Key entity (which can read from an environment
variable or another secret provider) rather than being pasted into plain
configuration. One data‑handling point to weigh: the audio and text you process are
**sent to Deepgram's servers** over HTTPS — normal for a cloud transcription
service, but confirm that this outbound transfer (egress) is acceptable for your
content, since voice recordings can be sensitive. The module has no access‑control
role of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (with the AI and
   Key modules) and enable it.
2. [Configuration](configuration/index.md) — store your Deepgram API key as a Key
   and connect it to the AI provider, plus the egress consideration.

## Where it lives in the admin menu

Deepgram does not add a standalone settings page. You configure it through the
pieces it depends on:

- **Keys:** **Configuration → System → Keys** (`/admin/config/system/keys`) — where
  your Deepgram API key lives.
- **AI providers:** the **AI** module's provider settings, under
  **Configuration → AI** (`/admin/config/ai`) — where you point the AI module at
  Deepgram using that Key.

See [Configuration](configuration/index.md) for the full walkthrough.
