<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Ships a ready-made "EPT Image Gallery" Paragraph type that lets editors reference multiple Media (image) items and render them as a responsive gallery with a GLightbox popup, choosing a column/grid layout per instance. Part of the Extra Paragraph Types (EPT) family built on `ept_core`.

---

Installing the module creates a `ept_image_gallery` Paragraphs type with four fields: `field_ept_image_gallery` (unlimited Media image reference, the gallery images), `field_ept_title`, `field_ept_text`, and `field_ept_settings` (the shared EPT settings blob from `ept_core`). The gallery images are rendered through a dedicated `ept_image_gallery` media view mode whose `field_media_image` uses the **GLightbox** field formatter (image style `ept_gallery_image`, 365×265 scale-and-crop, gallery grouped by parent), so thumbnails open in a lightbox. The module's own field widget `ept_settings_image_gallery` (extends `ept_core`'s `EptSettingsDefaultWidget`) adds an image-gallery **Styles** radio — 1–5 columns, fixed-size grid, fluid grid, or featured-images grid — plus disables the "pass options to JavaScript" flag; the chosen style becomes a CSS class on the paragraph wrapper, styled by `css/ept_image_gallery.css`. There is no global settings page (`configure` is null) and no permissions; global colors/breakpoints come from `ept_core.settings`. Templates (`paragraph--ept-image-gallery--default.html.twig` and a field template registered via `hook_theme`/`hook_theme_registry_alter`) control the markup. To use it you add an EPT Image Gallery paragraph to a paragraph-reference field on your content, upload/select images, and pick a layout style.

---

- Add an image gallery to a page or article via a Paragraphs reference field.
- Let editors pick images from the Media library and show them as a grid gallery.
- Open gallery thumbnails in a GLightbox popup/lightbox instead of navigating away.
- Group all images in one paragraph into a single lightbox gallery (swipe between them).
- Render the gallery as 1, 2, 3, 4, or 5 equal columns.
- Use a fixed-size image grid layout for uniform thumbnails.
- Use a fluid grid layout that adapts to image proportions.
- Highlight the first images with the "featured images grid" layout.
- Add an optional title and description text above a gallery.
- Reuse the pre-built `ept_gallery_image` (365×265) image style for consistent thumbnails.
- Build landing pages by stacking multiple EPT paragraph types (gallery, text, hero, etc.).
- Give non-technical editors a point-and-click gallery builder with no code.
- Apply site-wide EPT colors and responsive breakpoints from EPT Core to galleries.
- Override the gallery markup with the provided Twig templates in a custom theme.
- Restyle layouts by overriding the classes in `ept_image_gallery.css`.
- Swap the GLightbox formatter settings (caption, image style) on the gallery media view mode.
- Translate gallery paragraphs on multilingual sites (fields are translatable).
- Add galleries inside Layout Builder or other paragraph-capable structures.
- Present product photo sets, event photo albums, or portfolio grids.
- Keep gallery presentation consistent across the site via one paragraph type.
- Combine with other EPT modules to standardise all rich content on paragraphs.
