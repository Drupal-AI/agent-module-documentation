# Islandora HLS — manual setup guide

**Islandora HLS** (`islandora_hls`) creates **HLS (HTTP Live Streaming)**
derivatives of audio and video in an [Islandora](https://www.islandora.ca/)
repository. Instead of forcing a visitor to download a large media file in full
before it plays, HLS lets the browser stream it adaptively — pulling the media in
small chunks and adjusting quality to the connection. That makes big audio and
video repository objects far more usable on the web.

It builds directly on Islandora's media and derivative machinery: you configure it
to generate an HLS version of your audio/video media, which the player can then
stream. It depends on the **Islandora** module and works on Drupal 10 and 11.

Note that this is an early release (**1.0.0-alpha1**), so treat it as
work-in-progress and test it against your stack before relying on it in production.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, meet the Islandora
   and media-processing requirements, and enable the module.

There is **no standalone settings form** for this module. HLS derivatives are
produced through Islandora's normal derivative workflow (actions, contexts, and the
supporting media-processing microservice), described in "How to use it" below.

## Where it lives in the admin menu

The module adds no dedicated admin page. It plugs into Islandora's existing
derivative pipeline — the actions and contexts you already use to generate other
derivatives — so its "home" is the Islandora configuration you manage under
**Administration → Islandora** and **Structure → Context**.

## How to use it

1. Make sure your Islandora stack has the media-processing tooling that generates
   HLS derivatives available (see [Installation](installation/index.md)).
2. Configure an Islandora **derivative action/context** to generate the HLS version
   for your audio/video media, the same way you wire up other derivatives.
3. When new audio/video media is ingested (or you re-run the derivative), the HLS
   version is created and can be streamed by the player.
