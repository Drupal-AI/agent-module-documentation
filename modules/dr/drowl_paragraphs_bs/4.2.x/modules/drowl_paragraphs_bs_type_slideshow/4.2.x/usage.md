<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds a 'Slideshow' Paragraph bundle that displays a DROWL Media slideshow.

---

This sub-module installs the `slideshow` Paragraph type with a media entity-reference field (`field_slideshow_ref`) targeting the DROWL Media `slideshow` media bundle. The slideshow itself (its slides and behavior) is a DROWL Media entity; this bundle simply references and renders it via the core entity-reference entity view. It depends on `drowl_media:drowl_media_types` for the slideshow media type.

---

- Place a pre-built DROWL Media slideshow into page content.
- Reuse the same slideshow media entity across multiple pages.
- Manage slides in the media entity, not in the paragraph.
- Render via the slideshow media type's own display.
- Combine with field_settings for animation/classes/id.
- Enable only where editors need slideshow paragraphs.
