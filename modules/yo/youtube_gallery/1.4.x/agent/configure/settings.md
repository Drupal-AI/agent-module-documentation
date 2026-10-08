# Youtube Gallery — configuration

## Settings form

Route `youtube_gallery.config` → `/admin/config/youtube_gallery/config` (form
`\Drupal\youtube_gallery\Form\Configuration`, permission `administer youtube_gallery`). Also embedded
on the status page `/admin/config/youtube_gallery/manage` (`youtube_gallery.manage`).

Saves to config object **`youtube_gallery.formsettings`**:

| Key | Form field | Notes |
|---|---|---|
| `api_key` | Enter API Key (required) | Google/YouTube Data API v3 key. |
| `channel_id` | Enter Youtube Channel Id (required) | Must start with `UC` (validated). |
| `max_videos` | Number Of Videos (required) | Must be numeric (validated). |
| `sort_order` | Sort videos by published date | `desc` (default) / `asc` / `none`. |
| `client_id` | Client OAuth Id (optional) | Only for the upload feature. |
| `client_secret` | Client OAuth Secret (optional) | Only for the upload feature. |

There is no config schema file, so these values are untyped (`schema incomplete` on strict schema
checks). Set them with Drush if scripting:

```bash
drush cset youtube_gallery.formsettings api_key 'AIza...' -y
drush cset youtube_gallery.formsettings channel_id 'UCxxxxxxxxxxxxxxxxxxxxxx' -y
drush cset youtube_gallery.formsettings max_videos 12 -y
drush cset youtube_gallery.formsettings sort_order desc -y
```

Getting the values (from the module's help page): the API key comes from a Google Cloud project with
the *YouTube Data API (v3)* enabled; the channel ID is the `UC…` segment of a channel URL.

## How the channel is queried

`YoutubeConfig` (`youtube_gallery.content`) rewrites the channel ID `UC…` → uploads playlist `UU…`
and calls `https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&maxResults=<max>&playlistId=<UU…>&key=<api_key>`
via `file_get_contents`. Duration/details use the `videos` endpoint. Requires `allow_url_fopen`.

## Status / manage page

`/admin/config/youtube_gallery/manage` (`youtube_gallery.manage`) shows the current API key, channel
ID, total video count, configured max, and detected channel name, then re-renders the settings form.
Permission `administer youtube_gallery`.

## Upload feature prerequisites (optional)

Upload lives at `/admin/config/youtube_gallery/upload-video` (`youtube_gallery.upload_video`). To use
it you must:

1. Install the Google API PHP client — via Composer (`google/apiclient` is in the module's
   `composer.json`) or `drush ytg:libraries` (see [../drush/commands.md](../drush/commands.md)).
2. Set OAuth `client_id` / `client_secret` in the settings form.
3. In the Google OAuth client, add the authorized redirect URI
   `https://<host>/admin/config/youtube_gallery/upload-video`.

Uploaded videos are created with `privacyStatus = public`. The form accepts a single `mp4`/`mkv`
managed file plus title, description, comma-separated tags, and a YouTube category.

## Permission

`administer youtube_gallery` (`restrict access: TRUE`) gates the config form, the status page, and the
upload form. The public play page `/youtube-gallery/{vid}` uses core `access content`.
