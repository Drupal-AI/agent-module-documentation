<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field formatters & Plyr JSON settings

All four formatters live in `src/Plugin/Field/FieldFormatter/`. Select them on any entity's **Manage display** page for a matching field. The module ships no global config — settings are stored per formatter instance in the display config.

## The four formatters

| Class | Formatter id | Field type(s) | Notes |
|---|---|---|---|
| `DdeckPlyrFileAudioFormatter` | `ddeck_advanced_media_file_audio` | `file` | `getMediaType()` → `audio` |
| `DdeckPlyrFileVideoFormatter` | `ddeck_advanced_media_file_video` | `file` | `getMediaType()` → `video` |
| `DdeckPlyrRemoteVideoFormatter` | `ddeck_advanced_media_remote_video` | `link`, `string`, `string_long` | YouTube/Vimeo only |
| `PhotoswipeMediaGalleryFormatter` | `photoswipe_media_gallery` | `image` | image-style options, not Plyr |

The audio/video classes are thin subclasses of `DdeckPlyrFormatterBase` (which extends core `FileMediaFormatterBase`). `viewElements()` calls the parent, then attaches library `ddeck_advanced_media/plyr-player`, adds CSS classes `plyr plyr-player` to each item, and sets `#plyr_settings` from `buildPlyrDrupalSettings()`. Output goes through the `ddeck_advanced_media_file_audio` / `_file_video` theme hooks (templates embed the `ddeck_advanced_media:plyr` SDC), emitting `<audio>`/`<video>` with a `data-plyr-config` attribute the JS reads.

## Remote video formatter

`DdeckPlyrRemoteVideoFormatter` extends `FormatterBase` directly and injects `media.oembed.url_resolver`. Per item:
- `extractProvider()` asks the oEmbed resolver for the provider and accepts only `vimeo` or `youtube` (else `FALSE`).
- `extractEmbedId()` runs `VIMEO_ID_REGEX` / `YOUTUBE_ID_REGEX` against the URL to pull the embed id.
- On success it builds a `ddeck_advanced_media_file_remote_video` render array with `#video_provider`, `#video_embed_id`, `#thumbnail` (the media entity's thumbnail file URL), and `#plyr_settings`; each item is added as a cacheable dependency.
- `isApplicable()` restricts the formatter to `media` entity fields whose media type source is an `OEmbedInterface`.

## Plyr JSON settings (audio/video/remote)

Shared logic is in `DdeckPlyrSharedFormatterTrait`. `defaultSettings()` stores a single `settings` key containing a pretty-printed JSON string produced by `defaultSettingsStructure()`:

```json
{
  "autoplay": false,
  "loop": false,
  "resetOnEnd": true,
  "hideControls": true,
  "controls": {
    "play-large": false, "restart": false, "rewind": false, "play": true,
    "fast-forward": false, "progress": true, "current-time": true,
    "duration": true, "mute": true, "volume": true, "captions": false,
    "settings": true, "pip": false, "airplay": false, "fullscreen": true
  },
  "youtube": { "noCookie": true }
}
```

- `settingsForm()` renders one `textarea` (`settings`) — paste raw JSON. There is no per-key UI.
- `getDecodedSettings()` `json_decode`s the string; returns `NULL` on invalid JSON, `[]` when empty. Backward-compat: if `settings` is empty but a legacy flat `autoplay` key exists in stored settings, the old array is used.
- `buildPlyrDrupalSettings()` transforms the decoded array into the Plyr config: `controls` becomes a list of enabled control names; `youtube` becomes a stdClass of enabled booleans (e.g. `noCookie`); any other truthy scalar key becomes `true`. This array is `json_encode`d into `data-plyr-config` by the Twig templates.
- `settingsSummary()` prints a General line (Autoplaying/Looping/Reset on end/Hide controls) and a Control line, or `Invalid or empty JSON` / `No settings`.

## PhotoSwipe gallery formatter

`PhotoswipeMediaGalleryFormatter` (extends `FormatterBase`) renders an image field as ONE gallery container (`$elements[0]`), not one element per delta. `defaultSettings()` = `thumb_image_style` and `pswp_image_style` (both empty = Original). `settingsForm()` offers two image-style `select`s built from all `image_style` entities.

`viewElements()` attaches libraries `ddeck_advanced_media/photoswipe` and `ddeck_advanced_media/advanced-media-gallery`, then per image builds a normalized array `{url, thumb_url, width, height, alt}`:
- `url` = `pswp_image_style->buildUrl($uri)` if set, else `file->createFileUrl()`.
- `thumb_url` = `thumb_image_style->buildUrl($uri)` if set, else `url`.
- width/height come from the image item; if a PhotoSwipe style is set, `transformDimensions()` adjusts them (PhotoSwipe needs correct `data-pswp-width/height`).
- `alt` from the item's `alt` property.

Rendered via the `photoswipe_media_gallery` theme hook → `templates/photoswipe-media-gallery.html.twig`, which embeds `ddeck_advanced_media:media_gallery` and outputs `<a href=url data-pswp-width/height><img src=thumb_url alt></a>` per image. `getMediaType()` here is an unused stub.

## Operating notes
- Install Plyr and PhotoSwipe under `/libraries/` (paths in `ddeck_advanced_media.libraries.yml`); the Plyr behavior throws a Drupal error if the `Plyr` global is missing.
- After selecting formatters or renaming from an older module machine name, run `drush cr`.
- For galleries, configure image styles to keep grid thumbnails small and opened images appropriately sized.
