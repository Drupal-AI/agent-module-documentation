<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Extra Block Types (EBT): Image adds an `ebt_image` custom block type that displays a single Media-referenced image with an optional caption, wrapping link, on-the-fly image style, greyscale/hover effects, and a GLightbox popup.

---

Part of the Extra Block Types (EBT) family, this module ships a `block_content` bundle called "EBT Image" so editors can place reusable image blocks — via Block layout or Layout Builder — without touching field UI. Each block references an Image media entity (`field_ebt_image`), and can carry a rich-text caption (`field_ebt_image_caption`), a link that wraps the image (`field_ebt_image_link`), and the shared EBT design settings field (`field_ebt_settings`). Its custom `ebt_settings_image` widget extends the EBT Core settings widget to add per-block Image Style, Lightbox toggle + Lightbox Image Style, Greyscale, and "Colorful on hover" options. At render time `hook_preprocess_block` (via `EbtImageHooks`) swaps the media_thumbnail image style on the fly and, when the lightbox is enabled, builds an absolute GLightbox URL from the underlying source file (optionally through an image style). Dedicated block and field Twig templates control the markup, and CSS/JS libraries are attached only as needed. The module has no routes, permissions, services (beyond the autowired hook class), or configuration form of its own; design defaults come from EBT Core.

---

- Add a standalone "EBT Image" block type to a site without building a bundle and fields by hand.
- Let editors place a single responsive image as a reusable custom block in Block layout.
- Add image blocks directly inside Layout Builder sections in a few clicks.
- Reference an existing Image media entity through the Media Library widget instead of a raw image upload.
- Display a caption beneath the image using a rich-text (text_long) field.
- Wrap the image in a link to an internal or external URL via the Image Link field.
- Apply link target/rel/class attributes (e.g. with the Link Attributes module) that flow through to the rendered anchor.
- Show images as thumbnails that open a full-size GLightbox popup on click.
- Use the caption text as the GLightbox slide title automatically.
- Pick a different image style per block for the inline thumbnail without editing the view display.
- Serve a separate, higher-resolution image style inside the lightbox popup.
- Render the original (unstyled) image when "Original image" is selected.
- Present images in greyscale for a uniform gallery look.
- Reveal full color on hover while keeping a greyscale default.
- Combine EBT Image blocks with other EBT block types for consistent design controls across a page.
- Reuse EBT Core design options (margins, padding, borders, background, edge-to-edge, container width) on each image block.
- Build editorial landing pages where marketers add and restyle image blocks themselves.
- Translate caption, link, and settings per language (fields are translatable).
- Lazy-load block images (the default view display sets image loading to lazy).
- Provide clickable promotional images that link to campaigns or product pages.
- Create image galleries when paired with other EBT modules while keeping per-image lightbox behavior.
