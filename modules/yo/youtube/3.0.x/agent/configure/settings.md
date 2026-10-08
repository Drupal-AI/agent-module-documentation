# Configure the YouTube field, formatters & global settings

## 1. Add the field

At **Structure → Content types → (bundle) → Manage fields → Add field**, choose field type
**"YouTube video"** (id `youtube`). The field stores two columns: `input` (the raw URL, up to
1024 chars) and `video_id` (extracted, ≤20 chars). Default widget = `youtube`, default
formatter = `youtube_video`.

## 2. The widget (`youtube`)

A single text field where the editor pastes a YouTube URL. On validation `youtube_get_video_id()`
extracts the ID; accepted formats include `watch?v=`, `youtu.be/`, `youtube.com/v/`,
`youtube.com/embed/`, `/shorts/` (with or without `http(s)://` / `www.`). A non-YouTube URL
raises "Please provide a valid YouTube URL." Once saved, the widget shows the detected
`YouTube video ID`.

Widget setting (Manage form display → gear):

| Setting | Meaning |
|---|---|
| `placeholder_url` | Sample/hint URL shown in the empty field |

## 3. Formatters (Manage display → gear)

Pick one per display. Three are available:

### `youtube_video` — embedded iframe player
| Setting | Default | Meaning |
|---|---|---|
| `youtube_size` | `450x315` | One of `450x315`, `480x360`, `640x480`, `960x720`, `responsive`, `custom` |
| `youtube_width` / `youtube_height` | `''` | Only used when size = `custom` |
| `youtube_autoplay` | `''` (off) | `autoplay=1` |
| `youtube_mute` | `''` | `mute=1` |
| `youtube_loop` | `''` | `loop=1` (+ playlist=video_id) |
| `youtube_controls` | `''` | `controls=0` (always hide controls) |
| `youtube_autohide` | `''` | `autohide=1` (hide controls after play) |
| `youtube_iv_load_policy` | `''` | `iv_load_policy=3` (hide annotations) |

`responsive` attaches the `youtube/drupal.youtube.responsive` CSS library and a
`youtube-container--responsive` wrapper class.

### `youtube_thumbnail` — thumbnail image
| Setting | Default | Meaning |
|---|---|---|
| `image_style` | `thumbnail` | Any image style, or "None (original image)". Applied only to locally-downloaded copies |
| `image_link` | `''` | Link the image to `content` (entity page), `youtube` (the video), or nothing |

The thumbnail is downloaded from `img.youtube.com` on first render (`youtube_get_remote_image()`,
Guzzle), saved as a **managed file** under the configured thumbnail directory, then rendered —
so an image style can be applied. If the local save fails it falls back to the remote URL (no
image style possible on remote images).

### `youtube_url` — plain URL
| Setting | Default | Meaning |
|---|---|---|
| `link` | — | Output the URL as a link vs. plain text |

## 4. Global settings — `youtube.settings`

Edit at `/admin/config/media/youtube` (route `youtube.settings`, permission `administer youtube`)
or with `drush cset youtube.settings <key> <value>`. These are site-wide defaults for the player
and thumbnails. Config object defaults:

| Key | Default | Meaning |
|---|---|---|
| `youtube_suggest` | `true` | Show suggested videos when playback ends (`rel`) |
| `youtube_modestbranding` | `false` | Hide YouTube logo (`modestbranding`) |
| `youtube_theme` | `false` | Light control bar (`theme=light`) |
| `youtube_color` | `false` | White progress bar (`color=white`) |
| `youtube_enablejsapi` | `false` | Enable IFrame JS API (`enablejsapi`, `origin`) |
| `youtube_wmode` | `true` | IE8 overlay fix (`wmode=opaque`) |
| `youtube_override` | `false` | Let editors append extra URL params (e.g. `&start=30`) |
| `youtube_privacy` | `false` | **Privacy-enhanced mode** — embed via `youtube-nocookie.com` (no cookies until play) |
| `youtube_player_class` | `youtube-field-player` | CSS class + id base for every iframe |
| `youtube_thumb_dir` | `youtube` | Files subdirectory (under the default scheme) for downloaded thumbnails |
| `youtube_thumb_hires` | `true` | Save hi-res `maxresdefault` thumbnails, falling back to standard on 404 |
| `youtube_thumb_token_image_style` | `null` | Image style used for the `youtube_image_url` token output |

The settings form also has a **"Refresh existing thumbnail image files"** button
(`youtube_thumb_delete_all`) that deletes all cached thumbnails so they are re-fetched.

The embed URL is built as `https://www.<domain>/embed/<video_id>?<params>`, where `<domain>`
is `youtube.com` normally or `youtube-nocookie.com` when `youtube_privacy` is on.

## Not core Media oEmbed

This module stores a video as a **scalar field value** (URL + id) on the host entity. Core
Media's "Remote video" source instead creates a **Media entity** via oEmbed. Use YouTube Field
when you want a lightweight per-entity video field with direct player/thumbnail formatters and
no media library overhead.

## Tokens

For every YouTube field the module registers per-field tokens: `<field>__youtube_video_url`
(the canonical `watch?v=` URL) and `<field>__youtube_image_url` (the local thumbnail URL,
optionally through `youtube_thumb_token_image_style`).
