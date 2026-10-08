<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Varbase Bootstrap Paragraphs ships a suite of Bootstrap-grid Paragraph bundles — columns, accordion, tabs, carousel, modal, image, rich text, view, webform and block — for editors to compose responsive page layouts, plus shared per-paragraph styling controls (width, background color, gutter, custom classes, optional heading).

---

From the Varbase distribution (a fork of Bootstrap Paragraphs), the module is almost entirely installed config: it imports paragraph types, their fields, and form/view displays, then relies on core Paragraphs, Paragraphs Library, entity_reference_revisions and varbase_media to store nested layout content. Its only PHP is a single settings form that manages a `key|label` list of background style classes (kept in sync with the `bp_background` field), a `hook_preprocess_paragraph` that converts the styling fields into Bootstrap `col-*` classes and an optional background image, widget/form alters that inject the current color options, and a set of Twig templates + CSS libraries (`vbp-default`, `vbp-colors`, per-component styles). It defines one permission and no drush/plugin surface, and is best used inside a Varbase site but installs on any Drupal 11 site.

---

- Build a landing page by stacking Bootstrap paragraph sections.
- Lay out content in equal columns with `bp_columns`.
- Create a two- or three-column uneven layout with a width-ratio picker.
- Nest paragraphs inside columns via the column-content fields.
- Add an accordion of collapsible sections.
- Add a tabbed content section.
- Add an image/content carousel with a slide interval.
- Add a modal (dialog) triggered by a button.
- Place a responsive image with an optional link and background.
- Add a rich-text (WYSIWYG) block.
- Embed a View inside a page with the View paragraph.
- Embed a Webform inside a page.
- Place a Drupal block plugin as a paragraph.
- Set a paragraph's content width (tiny/narrow/medium/wide/full/edge-to-edge).
- Give a paragraph a background color from the site's brand palette.
- Add an edge-to-edge background image to a section.
- Add custom CSS classes to a single paragraph.
- Toggle a section heading on or off per paragraph.
- Wrap a section in a Bootstrap container (gutter) or run it full-bleed.
- Curate the available background-color options for editors.
- Rebrand the color palette by overriding the `vbp-colors` library.
- Reuse a paragraph across pages via Paragraphs Library.
- Restrict who can edit the module's style settings.
- Provide a ready component set for a Varbase build.
- Convert a paragraph to a reusable library item.
