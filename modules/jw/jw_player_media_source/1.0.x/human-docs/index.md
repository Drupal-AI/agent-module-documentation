# JW Platform Media Source — manual setup guide

**JW Platform Media Source** (`jw_player_media_source`) connects your Drupal media
to [JW Player](https://www.jwplayer.com/)'s JW Platform **v2 APIs**, so editors can
browse a JW Player site's video library from inside Drupal and embed a chosen video
without hand‑writing any embed code.

Once you've entered your JW Player API key and site ID, the module gives editors
several ways to place a video: a **field** you add to a content type, a **block**
you drop into a region, and a **CKEditor 5 plugin** that embeds a video straight
into rich‑text content. A dedicated listing at **Content → JW media** lets editors
search and page through the remote JW library and pick the video they want; the
final output is JW Player's own player script embed.

The module talks to `api.jwplayer.com` and `cdn.jwplayer.com` using your API key as
a Bearer token. Every one of its screens is permission‑gated — there are no
anonymous or public endpoints — so browsing the library and configuring
credentials are both admin/editor‑only actions. It requires Drupal core's Media,
Media Library, Field, Block, and CKEditor 5 modules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module with its core dependencies.
2. [Configuration](configuration/index.md) — enter your JW Player credentials and
   set up the field, block, or CKEditor 5 embedding paths.

## Where it lives in the admin menu

- **Settings:** **Configuration → Media → JW Platform Media Source**
  (`/admin/config/media/jw-player-media-source`), where you enter the API key and
  site ID. This needs the *administer jw player media source* permission.
- **Video library:** **Content → JW media** (`/admin/content/jw-media`), where
  editors browse and pick videos from the remote JW library.
