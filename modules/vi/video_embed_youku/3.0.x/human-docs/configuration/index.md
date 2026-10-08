# Configuration

The Youku player embeds with **no configuration at all** — everything on this
page is only needed if you want the module to fetch the video's title,
description, and thumbnail from the Youku API.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Media → Video Embed Youku**, or navigate directly to
   `/admin/config/media/video-embed-youku`.

## The settings, field by field

- **API Client ID** (`api_client_id`) — your Youku open-platform API Client ID,
  obtained from the [Youku Developer Portal](https://open.youku.com/). This is
  required *only* for metadata lookups (title / description / thumbnail). If you
  leave it blank, the module skips those API calls, shows a warning to the
  editor, and still renders the player perfectly well.
- **API cache duration** (`api_cache_duration`) — how many seconds each video's
  API response is cached, to avoid hitting the Youku API on every page view. The
  default is **3600** (one hour); the form accepts values from **60** to
  **86400** (one minute to one day). A higher value means fewer API calls but
  staler metadata.

Click **Save configuration** to store your changes.

## Setting the values from the command line

If you prefer Drush:

```bash
drush cset video_embed_youku.settings api_client_id 'YOUR_CLIENT_ID'
drush cset video_embed_youku.settings api_cache_duration 3600
```

## Refreshing cached metadata

API responses are cached under the `video_embed_youku` cache tag. If a video's
title or thumbnail changes on Youku and you want Drupal to pick it up before the
cache expires, clear that tag (or clear all caches with `drush cr`).

## Using it in content

Once the module is enabled (and optionally configured), the workflow is pure
Video Embed Field:

1. Add a **Video Embed** field to a content type, media type, or paragraph type.
2. When editing content, paste a Youku URL — for example
   `https://v.youku.com/v_show/id_XNDQ2NjQwMjQw.html`. Both `http://` and
   `https://` forms are accepted.
3. The module extracts the video id and renders the Youku player. Autoplay and
   player size follow the Video Embed Field formatter settings on your display.

If you paste a malformed or non-Youku URL, the field validation rejects it, so
editors get immediate feedback.
