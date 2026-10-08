<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Chunker is a field formatter that wraps a long HTML body into sectioned div (or other) elements based on its inline h2/h3 headings.

---

Chunker is a basic Drupal 9/10/11 successor to the Drupal 7 Chunker module by dman. Instead of a text
filter, it ships a single field formatter (id `chunker`) for `text_long` and `text_with_summary`
fields. When a field is displayed with this formatter, Chunker parses the stored HTML with
DOMDocument and injects a wrapper element around each section that begins with a heading at the chosen
start level (h2 by default, optionally h3). The re-sectioned markup is rendered through Drupal's
`processed_text` element using the field's own text format, so escaping and filter behaviour match the
core default text formatter. Wrapping runs hierarchically from the start level upward toward h1, so a
higher-level heading contains its subsections rather than just preceding them. Each chunked heading is
given a stable id (an author-supplied id is respected; otherwise `section-N`), and an optional
permalink anchor can be appended to each heading. The extra structure lets themes or other modules add
CSS boxing/indentation, accordions, tabs, or previous/next navigation. All configuration is per field
display via Manage display; there are no routes, services, permissions, or module dependencies.

---

- Wrap a long body field into `<div class="chunker-section">` blocks by its h2 headings.
- Turn flat heading-and-paragraph markup into hierarchical, semantically nested sections.
- Section by h3 instead of h2 by setting the formatter's start level to 3.
- Add stable heading ids automatically so sections are linkable/anchor-navigable.
- Respect an author's existing heading `id` attribute instead of overwriting it.
- Append an optional permalink anchor (e.g. `#`) to each chunked heading.
- Give section wrappers a custom CSS class for styling or JS targeting.
- Provide the DOM structure other modules need for accordion or tab widgets.
- Enable previous/next in-page navigation over long documentation pages.
- Structure long-form articles without authors manually adding wrapper markup.
- Visually box or indent subsections via CSS on the generated wrappers.
- Apply sectioning retroactively to existing content by changing display settings only.
- Use on entity view displays (nodes, custom entities) through Manage display.
- Keep filtering/XSS behaviour identical to the core default text formatter.
- Pair with Display Suite view-mode switching for tabbed vs. long-page views.
- Complement modules like Sector ToC / Sector Multipage for section navigation.
- Break up walls of text into discrete, styleable reading chunks.
- Present documentation split into per-heading sections.
- Avoid editors having to hand-wrap sections in div elements.
- Preview the effect in the Manage display settings summary (level, tag, class, permalink).
