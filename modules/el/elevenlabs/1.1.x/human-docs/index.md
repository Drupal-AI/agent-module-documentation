# ElevenLabs — manual setup guide

**ElevenLabs** (`elevenlabs`) connects the ElevenLabs voice API to Drupal's
**AI** module as a provider. ElevenLabs is a text‑to‑speech service that turns
text into natural‑sounding speech (including with custom‑trained voices), and can
also do speech‑to‑speech, isolate/remove noise from audio, and more. Once this
module is enabled and configured, anything in Drupal that asks the AI module for
text‑to‑speech (or speech‑to‑speech / audio‑to‑audio) can be served by
ElevenLabs — including the **AI Automator**.

The strength of routing through the AI module is that your calling code asks for
an *operation* — "give me text‑to‑speech" — rather than naming a vendor. That
means adopting ElevenLabs now, or swapping it for another provider later, is a
configuration change rather than a code change. Typical uses follow from what the
service is good at: reading an article aloud for accessibility, narrating a video
script, producing audio versions of newsletters or alerts, or giving a chatbot a
spoken reply.

The module depends on the **AI** module (`ai`) and the **Key** module (`key`),
because credentials are handled properly here: the settings form stores a
reference to a **Key entity**, not the secret itself, so your API key can live in
an environment variable and never reach exported configuration. Two things worth
keeping in mind up front — ElevenLabs **bills per character**, so generating
speech on every page render rather than once on save can produce a surprising
invoice (cache the resulting audio), and synthesised‑voice use is governed by
ElevenLabs' own terms about whose voice may be imitated.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its AI/Key
   dependencies with Composer, and enable them.
2. [Configuration](configuration/index.md) — store your ElevenLabs API key
   securely and select it on the settings form.

## Where it lives in the admin menu

The settings form is at **Configuration → System → ElevenLabs settings**
(`/admin/config/system/eleven-labs-settings`). You need the **Administer site
configuration** permission to reach it.
