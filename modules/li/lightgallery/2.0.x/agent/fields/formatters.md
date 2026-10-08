# Field formatters

Two field formatters, both rendering a thumbnail grid that opens a lightGallery lightbox. Configure them
on a display via **Manage display** (`admin/structure/.../display`) or the display config entity. Both
draw their shared UI from `LightgalleryThumbnailFormatterTrait` + `EntityReferenceLightgalleryFormatterTrait`.

| Formatter id | Class | Field type | Applies to |
|---|---|---|---|
| `image_lightgallery_thumbnail` | `ImageLightgalleryThumbnailFormatter` (extends `ImageFormatterBase`) | `image` | Any image field. |
| `media_lightgallery_thumbnail` | `MediaLightgalleryThumbnailFormatter` (extends `EntityReferenceFormatterBase`) | `entity_reference` | `isApplicable()` only when the field's `target_type` is `media`. |

## Settings

Shared (label = form widget):

| Setting key | Widget | Default | Meaning |
|---|---|---|---|
| `inline` | checkbox "Inline gallery" | `FALSE` | Render the gallery inline; thumbnails are only shown when JS is off. Adds `lightgallery--inline` class and sets lightGallery `closable=FALSE`, `showCloseIcon=FALSE`, `showMaximizeIcon=TRUE`. |
| `gallery_image_style` | select "Gallery image style" | `NULL` | Image style for the full/lightbox image (`data-src`); empty = original image. |
| `thumbnail_image_style` | select "Thumbnail image style" | `NULL` | Image style for the visible thumbnail; empty = original. |
| `thumbnail_loading` | radios "Thumbnail loading attribute" | `lazy` | Sets the thumbnail `<img loading>` attribute; one of `lazy` / `eager` (required). |
| `custom_settings` | textarea "Custom settings" | `[]` | A JSON object of raw [lightGallery settings](https://www.lightgalleryjs.com/docs/settings); merged first so it overrides the module's defaults. Plugins go in as string names, e.g. `{ "plugins": ["lgThumbnail"] }`. Validated by `settingsFormCustomSettingsElementValidate()` (`json_decode` depth 3; invalid JSON → form error). |

Image formatter only:

| Setting key | Widget | Default | Meaning |
|---|---|---|---|
| `title_as_caption` | checkbox "Title as caption" | `FALSE` | Use the image field's title as the lightbox caption, emitted as `data-sub-html` (HTML-escaped). |

Media formatter only:

| Setting key | Widget | Default | Meaning |
|---|---|---|---|
| `caption_view_mode` | select "Caption view mode" | `NULL` | Render the media entity in this view mode as the lightbox caption (`data-sub-html`). Output is stripped to an allow-list of tags and attributes are removed. |

`calculateDependencies()` adds `image.style.<id>` config deps for the chosen styles, and the media
formatter adds `core.entity_view_mode.media.<mode>` for the caption view mode.

## Runtime behavior

- `viewElements()` (in `EntityReferenceLightgalleryFormatterTrait`) builds a single render element with
  `#theme = 'lightgallery__<image|media>_thumbnail__<entity_type>__<field_name>'`, a stable `galleryId`
  derived from an md5 of entity-type/id/field, and default lightGallery options
  `download=FALSE, counter=FALSE, getCaptionFromTitleOrAlt=FALSE, hash=FALSE`.
- Multi-value fields (cardinality ≠ 1) auto-enable the `lgThumbnail` plugin; the media formatter always
  adds the `lgVideo` plugin and `loadYouTubeThumbnail=FALSE`.
- Each item carries wrapper attributes: `data-src` (image/oembed/file URL), optionally `data-poster`
  (video thumbnail) and `data-sub-html` (caption). Thumbnails render via `#theme =
  'image_formatter__lightgallery'`.
- **Media sources supported** (`getSupportedSourcePluginIds()`): image = `image`; video =
  `oembed:video`, `video_embed_field`, `video_file`. `getEntitiesToView()` filters out media without a
  populated `thumbnail` or an unsupported source. Video-file `data-src` is an absolute URL; oembed/VEF
  use the source value. `lightgallery_preprocess_image()` appends `#video` to video-thumbnail `src`.

The `custom_settings` JSON and formatter settings are configured by users with field-display admin
rights; captions are escaped/tag-stripped before output.
