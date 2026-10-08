Responsive Gallery adds a single image-field formatter that renders multi-value image fields as a masonry grid of thumbnails with a Fancybox lightbox.

---

Responsive Gallery is a display-only contrib module for Drupal 9/10/11 whose entire surface is one field formatter, `ResponsiveGalleryFormatter` (plugin id `responsive_image`, label "Responsive Gallery"), that extends core's image `ImageFormatter`. Applied to a multi-value **image** field on *Manage display*, it renders each image (optionally through a chosen image style) inside a `<div data-fancybox="gallery" data-src="…">` wrapper and lays the thumbnails out with the bundled Masonry + imagesLoaded scripts into a responsive grid, while Fancybox turns the thumbnails into a grouped touch-enabled lightbox. Per-formatter settings pick the image style, a custom wrapper CSS class, and how many images appear per row at four breakpoints (extra-large / large / medium / small). Markup comes from the overridable `responsive-gallery.html.twig` template, and all CSS/JS (Fancybox, Masonry, imagesLoaded, plus the module's own grid CSS and Masonry init) ship vendored in the `responsive_gallery/responsive_gallery` library. The module has no config objects, no routes, no permissions, no services, and no Drush commands — it only changes how an existing image field is displayed. Its only dependency is core `field`.

---

- Turn a multi-value image field (e.g. `field_gallery` on an article) into a responsive photo grid.
- Give editors a lightbox gallery without installing a heavier media/gallery suite.
- Present product photo sets with a masonry layout that reflows to screen width.
- Show event or trip photo albums grouped into one Fancybox lightbox that swipes between images.
- Serve grid thumbnails through a small image style while linking the lightbox to the full-size original.
- Control density responsively: e.g. 5 per row on extra-large screens down to 1 on phones.
- Attach a custom wrapper CSS class so a theme can style specific galleries differently.
- Add a portfolio grid to a content type's default view mode with a couple of clicks.
- Build a staff/team headshot grid with click-to-enlarge.
- Render a gallery on a teaser or full view mode selected per display.
- Group all images of one entity into a single navigable lightbox set.
- Override `responsive-gallery.html.twig` in a theme to change the grid markup and layout.
- Restyle the grid entirely with custom CSS using the `rg-grid` / `rg-grid-item` classes.
- Use it inside Views: place an image field, set its formatter to Responsive Gallery, and images across the display are grouped by display id.
- Provide touch/pinch-to-zoom image viewing on mobile via the bundled Fancybox.
- Avoid external CDN calls — Fancybox and Masonry are vendored with the module.
- Configure per-view-mode density so a full page shows more columns than a teaser.
- Set the formatter via config or Drush (`core.entity_view_display.*`) for repeatable deployments.
- Combine with core image styles to keep grid pages lightweight while offering full-resolution overlays.
- Add a simple gallery to a landing page built from an entity's image field.
- Present real-estate listing photos as a swipeable lightbox gallery.
