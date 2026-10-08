<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Custom TOC adds a field type, CKEditor widget, and formatter that generate and render an editable Table of Contents from a formatted-text (CKEditor) source field.

---

Custom TOC ships a single Drupal field type, `toc_link_overrides` (label "TOC (CKEditor)"), together with its widget and formatter. On a node, the widget's "Regenerate TOC" button reads the headings (H1–H6) from a configured source field, runs them through the `toc_api` service to build starter Table-of-Contents markup, and stores that markup as formatted text that editors can refine by hand. As part of regeneration the module also rewrites the source field's headings so their anchor IDs match the generated TOC links. A `hook_form_node_form_alter` seeds an initial TOC into the edit form when the TOC field is empty, and `hook_node_view` places the stored TOC into the rendered node — or replaces a TOC that `toc_api` (or a sibling module) already injected into the source field — so the published page stays consistent with the saved field value. The module depends on `toc_api` and supports Drupal core 10 and 11. It provides no permissions, routes, services, config schema, or Drush commands of its own; all TOC generation options come from `toc_api`'s "default" TOC type.

---

- Add an editable Table of Contents to long rich-text pages built with CKEditor.
- Attach a "TOC (CKEditor)" field to a content type via Field UI.
- Generate TOC markup automatically from a node's Body (or any formatted-text) field.
- Let editors override individual TOC entry text after generation.
- Regenerate the TOC on demand with the widget's "Regenerate TOC" button (AJAX).
- Choose per bundle which formatted-text field the headings are read from.
- Restrict the TOC field to Full HTML output for CKEditor-authored markup.
- Keep the rendered TOC in sync with the stored field value across view modes.
- Rewrite source-field heading IDs so in-page TOC links actually jump.
- Replace a TOC that `toc_api_example` or another module injected into the body.
- Render the saved TOC HTML through Drupal's text-format pipeline (`processed_text`).
- Store per-entry override data alongside the TOC HTML (hidden `overrides` property).
- Seed the initial TOC into a node edit form only when the field is still empty.
- Preserve manually edited TOC text instead of overwriting it on form rebuild.
- Handle deleted or removed TOC fields without leaving a stray injected TOC on the page.
- Support documentation, handbook, policy, and knowledge-base content with many headings.
- Provide a consistent "jump to section" navigation block for editorial teams.
- Build a starter TOC that editors trim down to only the sections that matter.
- Pair with `toc_api`'s "TOC type" settings to control heading depth and template.
- Migrate long single-page articles to a navigable, anchored layout.
