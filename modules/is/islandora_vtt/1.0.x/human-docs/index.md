# Islandora VTT — manual setup guide

**Islandora VTT** (`islandora_vtt`) adds **WebVTT captions and transcripts** to
audio and video in an [Islandora](https://www.islandora.ca/) repository, and makes
them searchable. When a media object has a VTT transcript, this module renders it in
the browser alongside your HTML audio/video player and adds real usability on top:

- The transcript is **fully rendered in the browser** next to the player.
- A **search box** lets a visitor keyword-search within the transcript.
- **Timestamps are clickable**, so clicking a line jumps the player straight to that
  point in the recording.
- If the page is loaded with a `search_api_fulltext` URL parameter, the module will
  **automatically search the transcript on load** and start playing at the matching
  timestamp.

The result is a big accessibility and discoverability win for A/V objects — captions
for people who need them, and the ability to jump to the exact moment a phrase is
spoken.

It depends on **Islandora**, **Context**, and **Islandora Text Extraction**. VTT
files are attached to the audio/video media's node as an *extracted text* media type.
To have VTT files generated automatically, your stack needs the **scyllaridae OpenAI
Whisper microservice** available.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, meet the Islandora
   and transcription requirements, and enable the module.

There is **no standalone settings form** for this module. It works through
Islandora's media model and Context; the setup steps are in "How to use it" below.

## Where it lives in the admin menu

The module adds no dedicated admin page. It relies on Islandora's media handling and
the **Context** module — so its configuration home is your Islandora media types and
the contexts you manage under **Structure → Context**.

## How to use it

1. Ensure each audio/video media's node has its **VTT file attached as an extracted
   text media type**.
2. To generate VTT files automatically, make the **scyllaridae OpenAI Whisper**
   microservice available in your Islandora stack; otherwise attach VTT files you
   have produced another way.
3. View an audio/video object: the transcript renders beside the player, with a
   search box, clickable timestamps, and (when a `search_api_fulltext` URL parameter
   is present) an automatic transcript search that starts playback at the match.
