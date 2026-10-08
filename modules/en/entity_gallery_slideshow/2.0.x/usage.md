<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entities Gallery To Slideshow adds an entity-reference field formatter that shows the referenced entities as a clickable grid gallery, then opens a synced Swiper slideshow in a modal dialog.

---

Entities Gallery To Slideshow provides a single field formatter (`Gallery`, plugin id `entity_gallery_slideshow_view`) for `entity_reference` fields. On the display, each referenced entity is rendered with a chosen "gallery" view mode and wrapped in an AJAX dialog link; clicking any item opens a Drupal modal containing a Swiper (v11) slideshow that re-renders the same referenced entities with a separate "slideshow" view mode and jumps to the clicked item. The formatter is configured per view-display (Manage display) — you pick the gallery view mode, the slideshow view mode, the modal title, and whether to show a pager (fraction pagination) and a progress bar (scrollbar). It ships no permissions, no config forms, no config schema, and no submodules; its only real dependency is the Swiper library (loaded from the jsDelivr CDN) plus core's AJAX dialog and `once`. Because entities are shown through their own view modes, you can mix bundles (for example image and document media) in one gallery, and the visual styling is largely left to the site theme. A no-JS fallback route renders one slide at a time with Previous/Next links.

---

- Turn an image/media reference field into a clickable gallery grid.
- Open a full-screen (90vw) modal slideshow when a gallery item is clicked.
- Sync the opened slideshow to the exact item the visitor clicked.
- Build a product image gallery + zoom-style slideshow on commerce products.
- Show a portfolio of works as a gallery that expands into a slideshow.
- Present a photo album where thumbnails use one view mode and slides another.
- Mix entity bundles (images, documents, videos as media) in a single gallery.
- Use compact "teaser" thumbnails in the grid and "full" renders in the slideshow.
- Add fraction-style pagination (e.g. "3 / 12") to the slideshow via the pager option.
- Add a draggable scrollbar/progress indicator to the slideshow.
- Give the modal a custom title per field display.
- Render referenced nodes (not just media) as gallery cards with slideshow detail.
- Provide keyboard-accessible next/previous navigation inside the slideshow.
- Fall back to a paginated one-slide-per-page view when JavaScript is disabled.
- Reuse existing view modes so the gallery/slideshow markup matches your theme.
- Create a press/media kit gallery from a reference field.
- Display a gallery of team member entities with a detail slideshow.
- Show event photo sets referenced from an event node.
- Present real-estate listing photos as a browsable slideshow.
- Build a gallery of case studies referenced from a landing page.
- Let editors control gallery/slideshow appearance entirely through view modes.
- Add a lightbox-like image browsing experience without a dedicated lightbox module.
- Display a collection of referenced media assets from a DAM-style setup.
- Show a slideshow of testimonial or quote entities.
