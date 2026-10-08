<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
DROWL Media Types installs DROWL's full ready-made media configuration: media types (slide, slideshow, vector_image) plus reconfigured core types, their fields, view modes, image/responsive styles, Slick optionsets, crop types and Bootstrap display templates, and a settings form for slide/slideshow defaults.

---

DROWL Media Types is the configuration-heavy submodule of the DROWL Media project. On install it ships (via `config/install`, `config/optional` and `config/override`) three new media types — `slide`, `slideshow`, `vector_image` — and re-configures the core `image`, `document`, `video`, `remote_video` and `audio` types with a consistent field set (caption, copyright, media folder, media tags, mime type, size, internal note, and rich slide overlay fields). It adds `media_folder` and `media_tags` taxonomy vocabularies, many image styles and six responsive image styles (page-width and viewport-width families), Slick optionsets for slideshows, focal-point / media crop types, extra media view modes, and a large set of Bootstrap-based Twig display templates (document card/tile/button/media-object, slide with configurable overlay, slideshow, remote-video, and an SVG vector-image template, plus media-library variants). A settings form at `/admin/config/media/drowl-media-types-settings` (permission `administer drowl media types settings`) stores editable default values for slide and slideshow fields, applied through the `DrowlMediaTypesFieldValuesProvider` allowed-values / default-value callbacks. It depends on a broad contrib stack (blazy, crop, focal_point, slick, svg_image, photoswipe, fences, field_group, micon, smart_trim and more). It adds no access control of its own — media access remains core's.

---

- Provide a "Slide" media type (image or video) with a fully configurable text/button overlay.
- Provide a "Slideshow" media type that references multiple slides and renders them via Slick.
- Provide a "Vector image" media type for uploading and displaying SVG files.
- Reconfigure core image/document/video/remote_video/audio types with DROWL's shared fields.
- Add caption, copyright, media-folder, media-tags, mime-type, size and internal-note fields to media.
- Add `media_folder` and `media_tags` taxonomy vocabularies to organize the media library.
- Ship page-width and viewport-width responsive image styles across five breakpoints.
- Provide many image styles (page-width, viewport-width, crop, scale, thumbnails, zoom, 16:9).
- Configure focal-point cropping and a `media_crop` crop type for images.
- Provide extra media view modes (card, tile, button, embedded, lightbox, background, media_object, raw, viewport_width, media_library).
- Configure Slick optionsets (media_slideshow plus 2/4/6/8-column sets) for slideshows.
- Render documents as cards, tiles, buttons or media objects with mime-type file icons.
- Set editable site-wide defaults for slide overlay display/position/sizing/button and animation.
- Set editable site-wide defaults for slideshow autoplay/arrows/dots/infinite/height.
- Let per-media slide/slideshow field values override the Slick optionset at render time.
- Restore Claro/Gin media-library item templates alongside DROWL's frontend templates.
- Make the media `field_copyright` accept licence text without a link (via the base module).
- Provide Bootstrap 5 markup that can be adapted to Foundation by overriding templates.
- Serve as the config backbone for higher-level DROWL feature modules.
