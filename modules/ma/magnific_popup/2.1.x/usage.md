<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Magnific Popup adds a field formatter that renders image (and, optionally, Video Embed Field) fields as clickable thumbnails which open the full image/video in a Magnific Popup lightbox.

---

The module ships two field formatter plugins: `magnific_popup` for core `image` fields, and `video_embed_field_magnific_popup` for `video_embed_field` fields (only usable when the Video Embed Field contrib module is installed). You choose the formatter on an entity's *Manage display* page; there is no admin settings page or configure route. The image formatter exposes four settings stored in the entity view display component: `thumbnail_image_style` and `popup_image_style` (which image style to use for the small thumbnail and the large popup image; empty means original), `gallery_type` (`all_items` grouped gallery, `first_item` shows only the first thumbnail but galleries all, or `separate_items` for independent popups), and `vertical_fit` (fit tall images vertically or horizontally). At render time it themes each item as an `image_formatter` linking to the popup-sized image URL, attaches the `magnific_popup/magnific_popup` library, and adds `mfp-field`, `mfp-<gallery_type>` and a `data-vertical-fit` attribute so the bundled JS can wire up the lightbox. The Magnific Popup JavaScript/CSS library must be present under `web/libraries/magnific-popup` (the module supports both the modern `dist/` path and a legacy flat path via `hook_library_info_alter()`).

---

- Turn an image field into a thumbnail that opens a full-size lightbox on click.
- Build an image gallery where clicking one thumbnail lets the visitor page through all images.
- Show only the first image as a thumbnail but still gallery through the rest (`first_item`).
- Render each image as its own independent popup with no gallery grouping (`separate_items`).
- Use a small image style for the thumbnail and a larger style for the popup image.
- Serve the original (unstyled) image in the popup by leaving the popup image style empty.
- Fit very tall images horizontally instead of vertically via the vertical-fit setting.
- Display a product photo field as a lightbox gallery on a commerce product page.
- Add a lightbox to a media/image field on an Article without writing JavaScript.
- Open embedded YouTube/Vimeo videos in a Magnific Popup (with Video Embed Field installed).
- Provide an accessible, dependency-light lightbox using the jQuery Magnific Popup library.
- Configure the lightbox per view mode (e.g. teaser vs full) via separate display settings.
- Apply the formatter to a multi-value image field to create a photo album.
- Keep image markup themed through core's `image_formatter` while adding popup behavior.
- Host the Magnific Popup library locally under `web/libraries/magnific-popup`.
- Migrate from a legacy library path automatically (the module aliases the old flat path).
- Export the formatter configuration as part of `core.entity_view_display.*` config.
- Reuse core image styles for both thumbnail and popup sizing without new config.
- Add a `data-vertical-fit` hook for custom theming of the popup.
- Give editors a zero-effort lightbox simply by picking a formatter on Manage display.
