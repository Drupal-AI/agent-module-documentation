<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
EBT Video and Image Gallery adds an Extra Block Types (EBT) block type that renders a responsive grid mixing images and videos, each opening full-size in a GLightbox lightbox.

---

EBT Video and Image Gallery is part of the Extra Block Types (EBT) family of configurable, styled block
types. It installs a `ebt_video_and_image_gallery` content-block type whose `field_ebt_videos_and_images`
field holds a repeatable Paragraph ("EBT Video and Image gallery item"). Each item references one Media
entity — a core `image` or `remote_video` (oEmbed) media — plus an optional rich-text caption. On display
the items render as a grid (1–5 columns, fixed-size, fluid, or featured layouts selectable per block),
with images shown through the GLightbox image formatter and videos through the GLightbox Media Video
formatter so both open in the same lightbox gallery. Grid layout comes from the module's own CSS and a
`styles` class; spacing, background, borders, and container width come from the shared EBT Core design
options via the `field_ebt_settings` field. The module ships a custom field widget
(`ebt_settings_video_and_image_gallery`) that adds the gallery-style selector on top of EBT Core's default
widget. It depends on EBT Core, core Media, GLightbox, GLightbox Media Video, and Paragraphs; it provides
no permissions, routes, services, or Drush commands. It is a presentation block — the underlying media
entities and their access are unchanged.

---

- Build a mixed video-and-image gallery as a reusable content block.
- Add a Video and Image Gallery block in Layout Builder in a few clicks.
- Present a portfolio of photos and video clips together.
- Build a product gallery combining product images and demo videos.
- Show event photos alongside event video highlights.
- Open each gallery thumbnail full-size in a GLightbox lightbox.
- Play remote (oEmbed) videos such as YouTube/Vimeo inside the lightbox.
- Choose a grid layout per block: 1, 2, 3, 4, or 5 columns.
- Use a fixed-size images grid, a fluid grid, or a featured-images grid.
- Add as many gallery items as needed (unlimited Paragraph cardinality).
- Attach an optional rich-text description/caption to each gallery item.
- Reuse existing Media library images and remote videos as gallery items.
- Apply the shared EBT Core design options (margins, padding, borders).
- Set a block background color, image, or container width via EBT Core.
- Render gallery thumbnails through a dedicated 480x360 image style.
- Place the block via Layout Builder, Block layout, or as a reusable block.
- Combine images and videos in a single lightbox gallery grouping.
- Style galleries consistently across a site using EBT block types.
- Add media galleries to landing pages without custom theming.
- Keep media access and permissions untouched (display-only block).
