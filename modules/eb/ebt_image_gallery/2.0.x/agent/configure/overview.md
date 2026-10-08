<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring an EBT Image Gallery block

## Create / place a gallery
1. Ensure an **Image media type** exists (`/admin/structure/media`) before enabling — otherwise
   installation is blocked by `hook_requirements`.
2. Add a gallery as any custom block:
   - Block library: `/admin/content/block` → *Add content block* → **EBT Image Gallery**, then
     place it via Block layout (`/admin/structure/block`); or
   - Add it as an **inline block** inside a Layout Builder section.
3. On the block form there are two tabs (field_group):
   - **Content** — *Info* (admin label), *Body*, and **Image Gallery** (`field_ebt_image_gallery`):
     select one or more Image media via the Media Library widget (required, unlimited).
   - **Settings** — the `field_ebt_settings` widget (below).

## The Settings tab (ebt_settings_image_gallery widget)
- **Styles** (radios) — the only gallery-specific control. Options and their effect (from
  `css/ebt_image_gallery.css`):
  - `one_column` … `five_columns` — CSS grid with 1–5 equal columns.
  - `fixed_size_image` — flex row of fixed-size thumbnails.
  - `fluid_grid` — grid that reflows to the container.
  - `featured_images_grid` — mixed large/small featured layout.
  - Default: `four_columns`.
- **Design options** (inherited from ebt_core) — CSS box (margins / paddings / borders),
  border color/style/radius, background color, background media (image incl. cover/parallax),
  container width, edge-to-edge. These are serialised into an inline `<style>` block at render.

## Site-wide settings (ebt_core)
Primary/Secondary colors and Mobile/Tablet/Desktop breakpoints are set once on the EBT Core
settings form (`Administration » Configuration » Content authoring » Extra Block Types (EBT)
settings`) and apply to every EBT block, including this one.

## Thumbnails and the lightbox
- Thumbnails use the **`ebt_gallery_image`** image style (scale-and-crop **365×265**). Edit that
  image style to change thumbnail dimensions globally.
- Full-size images open in **GLightbox**; all images in one block share a single gallery
  (prev/next navigation), configured on the shipped `media.image.ebt_image_gallery` view display.

## Permissions
The module defines **no permissions**. Who may add/edit galleries is controlled by core block
content permissions (e.g. *Administer block content* / create-and-edit custom blocks) and, for
inline blocks, Layout Builder permissions.

## Troubleshooting
- If the Field Layout module forces Layout Builder onto the block type's display, disable it at
  `/admin/structure/block/block-content/manage/ebt_image_gallery/display/default`.
- The **body** field is hidden on the default form display by design (update 9101 re-imports the
  form display config).
