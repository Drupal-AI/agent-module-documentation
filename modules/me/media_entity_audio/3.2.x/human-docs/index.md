# Media Entity Audio Streams — manual setup guide

**Media Entity Audio Streams** (`media_entity_audio`) lets you manage audio that
lives *elsewhere* — on a CDN, a podcast host, an object store, or a media server — as
proper Drupal media entities, referenced by URL rather than uploaded as files. It
adds an **Audio Stream** media source (backed by a link field) so you can create a
media type whose items are audio URLs, and an **HTML5 audio formatter** that renders
those URLs in the browser's native `<audio>` player.

This is the right tool when you don't want large audio files sitting in your Drupal
file system. Editors paste a stream or download URL into a simple link field, and the
media item is auto-named from the URL's filename. On display, each URL becomes a
`<source>` inside an `<audio>` element, with the correct MIME type guessed
automatically (MP3, OGG, and WAV are handled), and the player's transport controls
shown or hidden depending on the formatter setting.

Because it plugs into core Media, audio streams appear in the Media Library, can be
reused across nodes through a media reference field, and can be organised, searched,
and permissioned like any other media. There is no settings form, no permissions, and
no Drush — you use it simply by creating a media type that selects "Audio Stream" as
its source.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

There is no dedicated settings page. You work with it through core's media
administration at **Structure → Media types** (`/admin/structure/media`), where the
**Audio Stream** source becomes available when adding a media type.

## How to use it

### Create an Audio Stream media type

1. Go to **Structure → Media types → Add media type**
   (`/admin/structure/media/add`).
2. Give it a name (for example "Podcast" or "Audio").
3. For **Media source**, choose **Audio Stream**.
4. Save. Core creates the link source field automatically, and the module wires the
   source field's display to the HTML5 audio player with a visually-hidden label.

Editors then add media items by pasting an audio URL into the link field. The item's
name defaults to the URL's filename.

### The HTML5 audio player formatter

The `audio_stream_html5` formatter renders link values in an `<audio>` element. It
has a single setting:

- **Controls** (on by default) — whether the player shows transport controls
  (play/pause, volume, seek). Turn it off for a player without visible controls.

Each URL on a media item becomes one `<source>`, so a single item can offer several
formats. MIME types are guessed automatically: WAV is normalised correctly, MP3 and
OGG pass through, and anything unrecognised is served without an explicit type.

### Customising the markup

To change the player markup, override the `media-audio.html.twig` template in your
theme. The `3.x` line also ships an update that migrates any legacy `audio` media
sources: link-backed ones become `audio_stream`, and file-backed ones become core's
audio-file source.
