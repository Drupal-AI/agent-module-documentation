# Configuration

Youtube Gallery is configured on one settings form, after which you place its block. The upload
feature has extra prerequisites covered at the end.

## Get the API key and channel ID

- **API key:** create a project in the Google Cloud console, enable the **YouTube Data API
  (v3)**, and create an API key. This key is what authorizes the module's read requests.
- **Channel ID:** the `UC…` segment of a YouTube channel URL (a 24-character string starting
  with `UC`).

## Settings form

Go to **Configuration → Youtube Gallery** (`/admin/config/youtube_gallery/config`), which
requires the *administer youtube_gallery* permission. It saves to the
`youtube_gallery.formsettings` config object:

| Field | Required | Notes |
|---|---|---|
| **Enter API Key** | Yes | Your Google / YouTube Data API v3 key. |
| **Enter Youtube Channel Id** | Yes | Must start with `UC` (validated). |
| **Number Of Videos** | Yes | Maximum videos to pull/display; must be numeric. |
| **Sort videos by published date** | — | `desc` (newest first, default), `asc`, or `none`. |
| **Client OAuth Id** | No | Only for the upload feature (see below). |
| **Client OAuth Secret** | No | Only for the upload feature. |

You can also set these with Drush if you are scripting:

```bash
drush cset youtube_gallery.formsettings api_key 'AIza...' -y
drush cset youtube_gallery.formsettings channel_id 'UCxxxxxxxxxxxxxxxxxxxxxx' -y
drush cset youtube_gallery.formsettings max_videos 12 -y
drush cset youtube_gallery.formsettings sort_order desc -y
```

> **Keep the API key out of committed config.** The key is stored in the
> `youtube_gallery.formsettings` config object, so it would land in any exported configuration
> you commit to version control. Following this project's secret-handling guidance, store the
> key in an environment variable and override the config value at runtime in `settings.php`, for
> example:
>
> ```php
> $config['youtube_gallery.formsettings']['api_key'] = getenv('YOUTUBE_API_KEY');
> ```
>
> That keeps the secret out of the database export and out of git. (With DDEV, set the variable
> with `ddev dotenv set .ddev/.env --youtube-api-key=<value>` and `ddev restart`.)

## The status / manage page

`/admin/config/youtube_gallery/manage` shows the current API key, channel ID, total video count,
configured maximum, and the detected channel name, and then re-renders the settings form — a
quick way to confirm the API key and channel are working.

## Show the gallery: place the block

The module provides a **Youtube Gallery** block. Add it to a region at **Structure → Block
layout** (`/admin/structure/block`). It renders the first *Number Of Videos* items from the
channel as thumbnail / title / duration rows, each linking to that video's play page at
`/youtube-gallery/{videoId}`. If the API returns nothing (bad key, wrong channel, blocked
outbound request), the block shows a "Videos rendering faild...!!!" message.

## Theming

Two templates control the output — `youtube-gallery-block.html.twig` (the block) and
`youtube-gallery.html.twig` (the play page). Copy either into your theme to restyle. The module
also attaches its own CSS library. See [`agent/theming/templates.md`](../agent/theming/templates.md)
for the variables each template receives.

## Optional: the upload feature

Uploading a local video from Drupal to YouTube lives at
`/admin/config/youtube_gallery/upload-video` (same permission). To use it:

1. Install the **`google/apiclient`** PHP library — via Composer (recommended) or the
   `drush ytg:libraries` command (see [Installation](../installation/index.md)).
2. Set the **Client OAuth Id** and **Client OAuth Secret** on the settings form. Create these in
   a Google OAuth client.
3. In that Google OAuth client, add the authorized redirect URI
   `https://<your-host>/admin/config/youtube_gallery/upload-video`.

The upload form accepts a single MP4 or MKV managed file plus a title, description,
comma-separated tags, and a YouTube category. **Uploaded videos are published as `public`** on
YouTube, so treat this feature accordingly.

## Permission recap

`administer youtube_gallery` (*restrict access*) gates the settings form, the status page, and
the upload form. The public play page `/youtube-gallery/{videoId}` uses core *access content*.
