<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds a 'Simple Map' Paragraph bundle that shows a location as a static image with overlay text and a link.

---

This sub-module installs the `simple_map` Paragraph type. Despite the name it is not a live/interactive maps integration: it presents a location as a static image (typically a screenshot from OpenStreetMap/uMap, as the field help suggests) plus overlay text and a link. There is no maps API key, no JavaScript maps SDK and no server-side network request — the module only ships CSS and a template. The image is a referenced media image rendered with a responsive image style (optionally zoomable via PhotoSwipe), the caption comes from the media's own image-caption field, and text/link are ordinary fields.

---

- Show a location as a static map image (e.g. an OpenStreetMap/uMap screenshot).
- Overlay a text block and a link on/near the map image.
- Render the image responsively via a selected responsive image style.
- Optionally allow PhotoSwipe zoom of the map image.
- Display the media image's caption (e.g. an attribution/copyright notice).
- Style the map link with link_attributes / micon_link.
- Avoid any external maps API, key or billing — it is pure image + overlay.
- Combine with field_settings for animation/classes/id.
