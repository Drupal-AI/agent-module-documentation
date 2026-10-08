# AI Audio Generator — manual setup guide

**AI Audio Generator** (`ai_audio_generator`) turns the text of your nodes into
spoken‑audio **MP3 files** using AI text‑to‑speech (TTS). It is handy for
accessibility — letting visitors listen to an article instead of reading it — and
for offering audio versions of long‑form content.

To handle articles of any length, it **chunks** long text and runs the generation
through Drupal's **Batch API**, so large pieces don't time out mid‑conversion. The
finished audio is stored as a managed file / media item that can be attached to the
node.

The audio is produced by an AI provider using your site's key (held via the **Key**
module), which means **every generation costs money** at the provider. Restrict who
is allowed to trigger it. The module also adds admin permissions for **voice
settings** and a **pronunciation dictionary**, so you can tune how names and
special terms are spoken.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its
   dependencies with Composer, and enable it.

## Where it lives in the admin menu

The module adds admin permissions for its **voice settings** and **pronunciation
dictionary**, and a permission that controls who may trigger audio generation.
Generation itself runs from node content (via the Batch API), producing an MP3 you
can attach to the node.

## How to use it

1. Configure an AI provider that offers text‑to‑speech in the AI module, with its
   key stored via the Key module.
2. Set up your **voices** (per language, if you serve multiple) and, if needed,
   add entries to the **pronunciation dictionary** so tricky words are spoken
   correctly.
3. Grant the generation permission only to trusted editors — remember each run
   costs provider credits.
4. Generate audio for a node; the module chunks long text, batches the work, and
   stores the resulting MP3 as a managed file/media item.
