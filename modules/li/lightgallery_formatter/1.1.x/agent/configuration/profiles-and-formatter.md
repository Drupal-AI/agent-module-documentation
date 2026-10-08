<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure LightGallery galleries

LightGallery Formatter renders an entity-reference **media** field as a lightGallery lightbox. There are two
pieces: a reusable **profile** (what the gallery looks like / which features are on) and the **field
formatter** (which field on which display uses a profile, plus per-bundle source and thumbnail settings).

## 1. Create a profile

Profiles are `lightgallery_profile` config entities managed at **Configuration → Media → LightGallery**
(`/admin/config/media/lightgallery`, route `entity.lightgallery_profile.collection`). The list/add/edit/
clone/delete routes are all gated by the `administer lightgallery_formatter` permission.

- Add, edit, **clone**, or delete profiles from the collection page.
- A `default` profile is installed with the module (`config/install/lightgallery_formatter.profile.default.yml`).
- Each profile stores `plugin_settings` keyed by plugin ID and is exportable as standard config
  (`config_export: id, label, status, plugin_settings`).

### Feature plugins (11 built-in)

A profile edit form exposes one section per plugin, discovered by the `plugin.manager.lightgallery` manager
from `Plugin/Lightgallery/` (attribute `LightgalleryPlugin`, alter hook `lightgallery_plugin_info`). Plugins
are ordered by `weight` and each contributes JavaScript options via `buildJsSettings()` only when enabled:

| Plugin ID | Label | Purpose |
|---|---|---|
| `general` | General Settings | Core options: licenseKey, loop, preload, speed, transition `mode`, closable, esc/keyboard, close/maximize icons, hideBarsDelay, counter, download, drag/swipe, mousewheel, allowMediaOverlap. Always applied (not a toggleable React plugin). |
| `thumbnail` | Thumbnail Navigation | Lightbox thumbnail strip; `image_style`, size, margin, alignment, pager position. |
| `video` | Video | Enables YouTube/Vimeo/Wistia/HTML5 video slides — required for remote-video media to play. |
| `zoom` | Zoom | Image zoom; scale, infinite/actual-size, zoom icons. |
| `fullscreen` | Fullscreen | Fullscreen mode. |
| `pager` | Pager | Pager / progress indicator. |
| `relative_caption` | Relative Caption | Captions positioned relative to the image. |
| `rotate` | Rotate | Rotate / flip controls. |
| `autoplay` | Autoplay | Slideshow playback, interval, progress bar, controls. |
| `share` | Share | Facebook / Twitter / Pinterest sharing. |
| `medium_zoom` | Medium Zoom | Medium.com-style zoom (may conflict with maximize/resize). |
| `hash` | Hash | URL hash deep-linking to slides. |

The `general` plugin's `licenseKey` defaults to `0000-0000-000-0000` (lightGallery's non-commercial key); a
commercial key can be entered but is optional.

## 2. Apply the formatter to a field

On a media entity-reference field's **Manage display**, choose the **LightGallery** formatter
(`lightgallery_formatter`, field type `entity_reference`). `isApplicable()` only offers it when the field's
`target_type` is `media` and at least one target bundle has an `image` source (or a `document`/`file`
bundle). Formatter settings (schema `field.formatter.settings.lightgallery_formatter`):

- **profile** (required) — which enabled profile to use. A select of all enabled profiles with a "Manage
  profiles" link.
- **gallery_item_source_fields** — per media-type, which field supplies the gallery item. Image bundles get
  a field dropdown (image fields or media-reference-to-image fields); remote-video bundles are read-only and
  use `_thumbnail_uri` (provider metadata). Default for `image` bundle is `field_media_image`.
- **thumbnail_style** — image style for the **inline** gallery-grid thumbnails on the page (default
  `thumbnail`). The lightbox thumbnail-strip style is set separately in the profile's thumbnail plugin.
- **pdf_thumbnail_media** — a Media Library-selected published image used as the shared thumbnail for PDF
  Document items. Validated to be a published, view-accessible `image`-source media entity.

## 3. Rendering model

`viewElements()` builds an item per referenced media entity (via `getEntitiesToView()`, so entity access and
language are respected), resolves image/video/PDF URLs, applies image styles, and emits a
`lightgallery_formatter` themed element. Item data is attached twice: as `drupalSettings`
(`lightgallery_formatter.galleries.<id>`) consumed by the React build (`lightgallery_formatter/gallery`
library, an ES-module bundle), and as a static `<a><img></a>` fallback in
`templates/lightgallery-formatter.html.twig` that React replaces once initialised. Media items that cannot be
resolved (missing file, unsupported MIME, missing PDF thumbnail) are skipped with a redacted logger warning.

## Notes / gotchas

- **Bundled libraries, no Composer step.** lightGallery and React are built into `js/dist/lightgallery-react.js`
  by Vite; the status report shows the bundled version. `composer suggest` lists `npm-asset/lightgallery` only
  for optional local installation.
- **`media_library` is now a hard dependency** (used by the PDF-thumbnail selector); core `media` is also
  required.
- **PDF support** requires a standard `document`/`file` media bundle plus a configured `pdf_thumbnail_media`;
  without a thumbnail, PDF items are skipped.
- **`update_10001`** backfills default Video-plugin settings into pre-existing profiles.
