# Youtube Gallery — manual setup guide

**Youtube Gallery** (`youtube_gallery`) pulls the videos of a YouTube channel via the YouTube
Data API v3 and displays them on your site as a gallery **block**, with a dedicated play page
for each video. It is a lightweight way to present a channel's content as an on-site video wall —
branded to your site rather than sending visitors off to YouTube — without a full media/DAM
stack. There is also an optional, more advanced flow for **uploading** a video from Drupal to
YouTube using Google OAuth.

To show a gallery you configure a Google API key, a YouTube **channel ID** (the `UC…` value from
a channel URL), a maximum number of videos, and a sort order. The module converts the channel ID
to its uploads playlist, fetches the videos from the Data API, and renders their thumbnails,
titles, and durations in the "Youtube Gallery" block; clicking a video opens its play page at
`/youtube-gallery/{videoId}`. An admin status page shows the current settings and the detected
channel.

The optional upload feature is separate and heavier: it needs the `google/apiclient` PHP library
(installable via Composer or a bundled Drush command) plus a Google OAuth client ID and secret,
and it lets an editor upload an MP4/MKV to YouTube with title, description, tags, and category.
All of the module's admin screens are gated by a single restricted permission, *administer
youtube_gallery*; the public play page uses core's *access content*. The module works on Drupal
10 and 11, ships no config schema, and has no submodules.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token‑cheap references for an AI coding agent — the config object keys, routes, service, and
templates — read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, set the permission,
   and (for uploads only) install the Google API client library.
2. [Configuration](configuration/index.md) — the API key and channel settings, placing the
   gallery block, and the OAuth upload prerequisites.

## Where it lives in the admin menu

- **Settings:** **Configuration → Youtube Gallery**
  (`/admin/config/youtube_gallery/config`).
- **Status / manage:** `/admin/config/youtube_gallery/manage` — shows the current settings and
  detected channel, and re-renders the settings form.
- **Upload (optional):** `/admin/config/youtube_gallery/upload-video`.
- The **Youtube Gallery** block is placed via **Structure → Block layout**, and each video plays
  at `/youtube-gallery/{videoId}`.

## How to use it

Get a YouTube Data API v3 key from a Google Cloud project, find your channel's `UC…` ID, enter
both on the settings form along with a video count and sort order, then place the **Youtube
Gallery** block in a region via Block layout. See [Configuration](configuration/index.md) for the
details and for the API-key handling recommendation.
