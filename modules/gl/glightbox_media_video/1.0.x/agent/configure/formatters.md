<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring the two formatters

## Install

```bash
composer require drupal/glightbox_media_video     # pulls drupal/glightbox
drush en glightbox_media_video -y                 # enables media + glightbox
```

GLightbox itself needs its JS library — follow the `glightbox` module's own requirements
(status report will complain if it is missing). This module ships no library of its own beyond a
thin CSS/JS wrapper.

## Where to set them

Formatters live on the **media type's** display, not the host entity's:

- Remote Video: *Structure → Media types → Remote video → Manage display* → field
  **Video URL** (`field_media_oembed_video`) → format **GLightbox Media Remote Video**.
- Local Video: *Structure → Media types → Video → Manage display* → field
  **Video file** (`field_media_video_file`) → format **GLightbox Video Popup**.

Then render the media reference on your node using a view mode that uses those displays.

```bash
drush cset core.entity_view_display.media.remote_video.default \
  content.field_media_oembed_video.type glightbox_media_remote_video -y
drush cset core.entity_view_display.media.video.default \
  content.field_media_video_file.type glightbox_file_video -y
drush cr
```

## Settings

### Shared

| Setting | Default | Options / notes |
|---|---|---|
| `display` | `thumbnail` | `thumbnail`, `text`, `media_title` — what the visitor clicks |
| `link_text` | `View Video` | Only used when `display` is `text` |
| `image_style` | `thumbnail` | Applied to the thumbnail; empty = original image |
| `glightbox_gallery` | `post` | `post`, `page`, `parent`, `paragraph`, `field_post`, `field_page`, `custom` |
| `glightbox_gallery_custom` | `''` | Gallery id when `glightbox_gallery = custom`; lowercase letters, numbers, underscores. Token-aware when the Token module is enabled |
| `glightbox_caption` | `auto` | Caption source; `custom` enables the field below |
| `glightbox_caption_custom` | `''` | Custom caption string (tokens supported) |
| `glightbox_caption_description` | `''` | Longer description shown under the caption |
| `glightbox_caption_description_custom` | `''` | Custom description string (tokens supported) |

Gallery grouping means "which videos share one lightbox carousel":

- `post` — all videos on the same host entity
- `page` — everything on the rendered page
- `parent` / `paragraph` — grouped by the parent entity or paragraph holding the field
- `field_post` / `field_page` — one gallery per field, scoped to the post or page
- `custom` — you supply the id (use tokens for a per-entity id)

### `glightbox_media_remote_video` only

`defaultSettings()` is `OEmbedFormatter::defaultSettings() + [glightbox settings]`, so core's
oEmbed settings (`max_width`, `max_height`, `loading`) also apply and appear in the same form —
`settingsForm()` calls `parent::settingsForm()` and then merges the video formatter's own form.

### `glightbox_file_video` only

| Setting | Default | Notes |
|---|---|---|
| `muted` | `FALSE` | Mute the popup player |
| `width` | `640` | Popup player width in pixels (required) |
| `height` | `480` | Popup player height in pixels (required) |
| `thumbnail_source_field` | `''` | A field on the media entity to take the poster image from — the practical fix for local videos having no thumbnail |
| `thumbnail_source_image_style` | `''` | Image style applied to that custom thumbnail |

## Example display config

```yaml
# core.entity_view_display.media.remote_video.default
content:
  field_media_oembed_video:
    type: glightbox_media_remote_video
    label: hidden
    settings:
      max_width: 0
      max_height: 0
      display: thumbnail
      link_text: 'View Video'
      image_style: medium
      glightbox_gallery: post
      glightbox_gallery_custom: ''
      glightbox_caption: auto
      glightbox_caption_custom: ''
```

No config schema is shipped for these settings, so schema-validation tooling will flag the display
config; the settings themselves save and work.

## Troubleshooting

| Symptom | Likely cause |
|---|---|
| Link renders but nothing opens | GLightbox JS library missing — check the `glightbox` module's status report entry |
| Local video shows no thumbnail | Local videos have no auto-thumbnail; set `thumbnail_source_field` |
| Videos do not group into one carousel | Different `data-gallery` values — check the gallery setting on **each** field/display involved |
| YouTube opens on youtube-nocookie.com | Intentional: the preprocessor rewrites YouTube URLs to the nocookie embed domain |
| Vimeo/other provider opens the oEmbed page rather than a player | Only YouTube gets URL rewriting; use the URL alter hook for other providers (see [../theming/markup-and-hooks.md](../theming/markup-and-hooks.md)) |
