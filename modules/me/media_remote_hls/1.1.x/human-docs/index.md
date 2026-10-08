# Media Remote HLS — manual setup guide

**Media Remote HLS** (`media_remote_hls`) extends the **Media Remote** module to
embed **remote HLS (HTTP Live Streaming)** video — so any HLS stream whose URL ends
in `.m3u8` can be added as a media entity and played on your site. Most remote‑video
modules only support specific platforms (YouTube, Vimeo, and so on); this one plays
generic HLS from any server, such as AWS MediaLive (optionally through CloudFront)
or your own HLS server.

It's a display‑oriented integration built on top of Media Remote's "Remote Media
URL" source: you add a media type using that source, then choose the **Media Remote
- HLS** formatter to play the stream. The stream itself is served from its
**remote source** — a third‑party (or your own) URL played in the visitor's
browser — so nothing is stored on your site and the usual egress/privacy
considerations for remote media apply. Media access follows core media/file access;
the module adds no access‑control role of its own.

One current limitation to know: as of the 1.0.0 release the player is **Video.js
with the default skin only**. Future versions aim to support more players and
skins (patches are welcomed by the maintainer). It depends on the **Media Remote**
(`media_remote`) module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (with its Media Remote dependency).

There is **no dedicated settings page**. You use it by adding a media type and
selecting its formatter — described under "How to use it" below.

## Where it lives in the admin menu

The module adds no standalone settings form. You set it up on your media types at
**Structure → Media types** (`/admin/structure/media/types`).

## How to use it

1. After enabling the module, go to **Structure → Media types**
   (`/admin/structure/media/types`) and add a media type, choosing **Remote Media
   URL** as the media source.
2. Open that media type's **Manage display**.
3. Select **Media Remote - HLS** as the formatter for the remote URL.
4. Create media of that type using an HLS stream URL ending in `.m3u8`; it will
   play in the Video.js player on the site.
