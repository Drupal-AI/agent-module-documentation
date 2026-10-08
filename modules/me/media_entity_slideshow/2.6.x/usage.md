<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Media entity slideshow provides a "Slideshow" media source plugin so you can create a Media type whose items are an ordered set of referenced media entities (the slides).

---

The module adds a single core Media **source plugin** with id `slideshow` (label "Slideshow"). A media type using this source stores its slides in an `entity_reference` source field (typically referencing other media entities), configured as the type's `source_field`. The source exposes a `length` metadata attribute (the number of slides), builds a default media name like "N slides, created on <date>", and derives the type's thumbnail from the first referenced slide's own thumbnail (falling back to the module's `slideshow.png` icon). It enforces a validation constraint, `ItemsCount`, so a slideshow media entity must contain at least one slide ("At least one slideshow item must exist."). There is no admin settings form or configure route — you set it up entirely through the standard Media type UI (or config) by choosing the Slideshow source and pointing it at an entity_reference field. It requires Drupal core's Media module and works with Media Library, view modes, and formatters like any other media type. Rendering the actual slideshow (carousel markup/JS) is left to your theme or a display/formatter of your choosing; this module supplies the media model and metadata.

---

- Model an image/video slideshow as a first-class Media entity referencing ordered slides.
- Build a homepage hero carousel whose slides are reusable media items.
- Create a "Gallery" media type that editors populate from the Media Library.
- Reference an existing slideshow media entity from many nodes without duplicating slides.
- Store a slideshow's slides as an ordered, multi-value entity_reference source field.
- Expose the slide count via the `length` metadata attribute for display or logic.
- Auto-generate a media name like "5 slides, created on 2026-07-26" from the source.
- Use the first slide's thumbnail as the slideshow's thumbnail in admin listings.
- Enforce that every slideshow has at least one slide via the ItemsCount constraint.
- Combine image and video media items as slides within one slideshow entity.
- Curate a product image carousel as a single referenceable media item.
- Manage slideshows in the Media Library alongside images and documents.
- Feed a themed carousel (Slick/Splide/Glide) from a slideshow media type's slides.
- Reorder slides by dragging the multi-value entity_reference source field.
- Reuse the same slideshow across multiple pages and view modes.
- Add a "Testimonials" or "Partners" slideshow media type for editors.
- Map additional metadata fields on the media type for captions or credits.
- Provide a consistent editorial workflow for building carousels without custom entities.
- Translate or moderate slideshow media entities using core Media workflows.
- Restrict a slideshow field to reference only specific media bundles as slides.
- Drive a decoupled front end from slideshow media returned by JSON:API.
