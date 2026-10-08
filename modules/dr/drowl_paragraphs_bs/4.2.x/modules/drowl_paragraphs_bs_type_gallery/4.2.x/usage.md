<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds a 'Gallery' Paragraph bundle that renders a responsive image grid with optional PhotoSwipe zoom.

---

This sub-module installs the `gallery` Paragraph type: a multi-value media image reference (`field_gallery`) rendered as a Bootstrap grid (2–6 columns or masonry, selected via a UI Styles option) with optional PhotoSwipe lightbox zoom. Its template loops the referenced media images and renders each with the shared `flexible_image` include; a preprocess splits gallery/gap/image-wrapper classes onto the correct wrappers. Images use a selectable responsive image style.

---

- Build an image gallery from referenced media images.
- Choose 2, 3, 4, 5 or 6 columns, or a masonry layout (UI Styles option).
- Enable PhotoSwipe lightbox zoom for the gallery images.
- Render each image responsively via a selected responsive image style.
- Reuse media-library images across galleries.
- Apply gap/wrapper styling via UI Styles classes.
- Combine with field_settings for animation/classes/id.
- Enable only where editors need gallery paragraphs.
