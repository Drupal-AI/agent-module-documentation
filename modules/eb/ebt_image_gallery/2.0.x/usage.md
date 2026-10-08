<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
EBT Image Gallery adds a reusable "EBT Image Gallery" block content type: reference Image media, pick a grid layout, and the images render as a CSS grid that opens full size in a GLightbox lightbox.

---

Installing the module creates a `block_content` bundle called `ebt_image_gallery` with three fields: `field_ebt_image_gallery` (an unlimited-cardinality entity reference to Image `media`, edited with the Media Library widget and required), the standard `body`, and `field_ebt_settings` (the shared `ebt_core` settings field). The bundle's custom widget, `ebt_settings_image_gallery` (extending ebt_core's `EbtSettingsDefaultWidget`), adds a single extra control on top of the inherited Design options: a **Styles** radio set — `one_column` through `five_columns`, plus `fixed_size_image`, `fluid_grid` and `featured_images_grid`. The chosen style value is added verbatim as a CSS class on the block wrapper (`block--…--ebt-image-gallery.html.twig`), and the module's component CSS (`css/ebt_image_gallery.css`) turns that class into a `display:grid`/flex layout. Each referenced image is rendered by the GLightbox field formatter through a shipped media view display, using the module's `ebt_gallery_image` image style (scale-and-crop 365×265) for the thumbnail and grouping every image in the block into one lightbox gallery (`glightbox_gallery: parent`), so clicking a thumbnail opens the full-size image with prev/next navigation. GLightbox is vanilla JavaScript with no jQuery. Because it is a block, a gallery can be placed in a region via Block layout, dropped into a Layout Builder section, or referenced from a field — the right shape for something that should appear on many pages rather than inside one page's body. Requirements: `ebt_core`, the `glightbox` module and core `media`; an **Image media type must already exist** or `hook_requirements` blocks installation. The inherited Design options (spacing, borders, background color/media, container width, edge-to-edge) are configured through ebt_core and applied as per-block inline `<style>` at render time. The module ships no permissions of its own — creating and editing these blocks is governed by core block-content / Layout Builder permissions, and site-wide colors and breakpoints live on the EBT Core settings form.

---

- Add a ready-made image gallery block to a page.
- Place a gallery block in a sidebar region via Block layout.
- Drop a gallery into a Layout Builder section.
- Show the same gallery on several pages by reusing the block.
- Build a photo grid whose images open in a lightbox.
- Present exhibition or event photographs in a grid.
- Show product photography as a 3- or 4-column grid.
- Build a portfolio or project-images block.
- Display a team photo grid.
- Show press or media-kit images with full-size viewing.
- Lay images out as a featured-images grid (one large, several small).
- Use a fluid grid that reflows to fit the container width.
- Use a fixed-size image grid for uniform thumbnails.
- Give non-technical editors a gallery without custom theming.
- Reference existing Media Library images into a gallery.
- Add captions to gallery images (shown by GLightbox from media alt/name).
- Apply consistent spacing, borders or a background to a gallery via ebt_core Design options.
- Make a gallery span edge-to-edge across the viewport.
- Constrain a gallery to a preset container width.
- Reuse one branded gallery block across a whole site section.
- Swap thumbnail dimensions by editing the ebt_gallery_image image style.
- Change the number of columns without touching code.
