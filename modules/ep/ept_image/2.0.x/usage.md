<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
EPT Image adds one `ept_image` Paragraphs bundle — a reusable image page-section that references an image from the Media library and can carry a title, body text, caption, wrapper link, and an optional GLightbox popup. It belongs to the Extra Paragraph Types family and shares the family's design options (spacing, borders, background, container width) through `ept_core`.

---

The module is delivered almost entirely as installed configuration plus templates. Enabling it creates the `ept_image` paragraph type with six fields — `field_ept_image` (a required Media reference limited to the `image` bundle, edited with the Media Library widget), `field_ept_title`, `field_ept_text`, `field_ept_image_caption`, `field_ept_image_link` (a core link field), and `field_ept_settings` — and default form and view displays. The Settings tab uses this module's `ept_settings_image` widget, which extends ept_core's design-options widget and adds five image controls: an image style, an "enable lightbox" toggle with its own lightbox image style, and greyscale / colorful-on-hover switches. At render time a preprocess hook can swap the image style on the fly and, when the lightbox is enabled, resolves the media's file to a full-size (or styled) URL and wraps the image in a `glightbox` link. There is no admin settings page of its own; the shared EPT configuration form lives in ept_core. Composer requires `ept_core ^2.0`, `glightbox ^1.0` and `paragraphs ^1.0`; the module also depends on core `link` and `media`, and `core_version_requirement` is `^10.1 || ^11 || ^12`. Note an install-time requirement: `hook_requirements()` refuses to install until an `image` media type exists, so create one first on a minimal site.

---

- Add an image as a standalone page section.
- Build a landing page from stacked EPT components.
- Reference an existing image from the Media library.
- Restrict editors to the `image` media type for the section.
- Add a caption beneath a page-section image.
- Give an image an optional heading and lead text.
- Make an image clickable through a link field.
- Open an image in a GLightbox popup on click.
- Serve a thumbnail that pops a full-size image in a lightbox.
- Apply a specific image style to the section image.
- Use a different image style for the lightbox popup.
- Render the image in greyscale, colorful on hover.
- Apply shared EPT spacing, borders and background to an image.
- Set the section container width or make it edge-to-edge.
- Lazy-load image sections down the page.
- Reuse the component across multiple content types.
- Keep image sections consistent site-wide.
- Theme the image section with a dedicated Twig template.
- Combine with the EPT text and button components.
- Add an image section without writing a paragraph type by hand.
- Support a component-based editorial workflow.
- Prepare an image component for Drupal 12.
- Adopt this one EPT component on its own.
- Place the paragraph via Layout Builder or a paragraphs field.
