# Youtube duration — manual setup guide

**Youtube duration** (`youtube_duration`) automatically fills in a video's length on
a YouTube media entity. When you save a media item whose source is a YouTube video,
the module looks up the video on the YouTube Data API and writes its runtime into a
**Duration** field — so you never have to enter the length by hand, and it stays in
sync with the canonical value from YouTube.

It works on media types whose source is **oEmbed (Video)** and that already have a
Duration field (provided by the [Duration Field](https://www.drupal.org/project/duration_field)
module). You turn the feature on per media type, choose which Duration field to
populate, and supply a YouTube Data API key. On save, the module recognises standard
`youtube.com/watch?v=`, shortened `youtu.be/`, and `youtube.com/shorts/` URLs,
fetches the video's ISO 8601 duration (e.g. `PT5M33S`), and stores both that string
and its value in seconds. It only re-queries the API when the video URL changes or the
duration field is empty, so it does not waste API calls.

There is no separate settings page — everything is configured on the media type's own
edit form — and the module adds no permissions or Drush commands. It requires core
**Media** and the **Duration Field** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

There is no dedicated settings page. You configure it on a media type at
**Structure → Media types → *(your video type)* → Edit**
(`/admin/structure/media`).

## How to use it

Before you start you need a **Media type whose source is oEmbed (Video)** that
already has a **Duration** field added to it, and a **YouTube Data API v3 key** (get
one from the Google Cloud console with the "YouTube Data API v3" enabled).

Then set it up on the media type:

1. Go to **Structure → Media types**, and **Edit** your oEmbed video media type.
2. A **Youtube duration settings** section appears (it only shows for oEmbed video
   types that have a Duration field). Fill in:
   - **Enable** — turn the feature on for this media type.
   - **Duration field** — choose which Duration field on the type to populate.
   - **API key** — paste your YouTube Data API v3 key.
3. Save the media type.

From then on, whenever you create or edit a media item of that type:

- If its YouTube URL changed (or the duration field is empty), the module extracts
  the video ID, calls the YouTube Data API, and writes the returned ISO 8601 duration
  and its seconds into your chosen field.
- If nothing relevant changed, it skips the API call.

You can then show the runtime on media/teaser displays, or expose the duration in
Views to sort or filter a video library by length. Any errors from the API (for
example an invalid key or quota problem) are shown to the editor as a Drupal message.

> **Keeping the API key out of exported config.** The key is stored per media type as
> ordinary Drupal config, so it will appear in a configuration export. If you would
> rather keep it out of version control, override it per environment from
> `settings.php` (e.g.
> `$config['media.type.remote_video']['third_party_settings']['youtube_duration']['duration_apikey'] = getenv('YOUTUBE_API_KEY');`)
> and store the value in your environment (with DDEV, `ddev dotenv set`).
