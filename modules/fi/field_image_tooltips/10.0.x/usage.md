<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Field Image Tooltips lets site builders present images that carry interactive tooltips/hotspots which, when triggered, load a referenced node's rendered content into a modal dialog. It relies on Paragraphs and its bundled `field_tooltips_data` submodule, which provides the underlying field type, widget, and formatter for the tooltip data.

---

- Requires core `field`, `file`, `image`, `node` and the contrib `paragraphs` module, plus the bundled `field_tooltips_data` submodule; Drupal 8/9/10.
- Enable with `drush en field_image_tooltips` (pulls in `field_tooltips_data`).
- Add the tooltips-data field to a Paragraph/entity and configure its widget to reference nodes and tooltip positions.
- Use the default formatter to render the image with tooltip markers.
- Tooltip content is fetched from `/tooltip/{node}/{js}` (permission: "access content") and shown via an AJAX modal.

---

- Overlay clickable tooltip markers/hotspots on an image.
- Open a referenced node's full content in a modal from a tooltip.
- Build interactive infographics or product images.
- Reference existing nodes as tooltip content (no duplication).
- Integrate with Paragraphs for flexible placement.
- Provide a dedicated field type via `field_tooltips_data`.
- Configure tooltip positions with the bundled widget.
- Render image + tooltips with the default formatter.
- Support both AJAX (modal) and no-JS fallbacks.
- Reuse node display/view modes inside tooltips.
- Create image maps for education or e-commerce.
- Localize tooltip node content through standard node translation.
- Keep tooltip content editable as normal nodes.
- Attach modal library automatically for tooltip triggers.
- Combine multiple tooltips on a single image.
- Use across content types that embed the Paragraph.
