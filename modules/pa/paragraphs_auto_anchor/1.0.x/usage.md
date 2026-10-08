<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Paragraphs auto anchor gives every rendered Paragraph a stable in-page anchor so you can deep-link straight to a specific paragraph with a URL fragment (e.g. `/page#<uuid>`). Editors also get a one-click "Copy anchor to clipboard" button in the Paragraphs widget so they can grab a paragraph's link while editing.

---

On the display side it implements `hook_preprocess_paragraph()` to inject a `paragraphs_auto_anchor_target` themed element (rendered from the `paragraphs-auto-anchor-target` template) at the top of each paragraph's content, using the paragraph's UUID as the anchor id. On the editing side it implements `hook_field_widget_single_element_paragraphs_form_alter()` to add a "Copy anchor to clipboard" action button that carries the paragraph UUID (resolving the underlying reusable paragraph's UUID for `from_library` items). It depends on the `paragraphs` module, defines no permissions or configuration, and adds no Drush commands — behaviour is automatic once enabled.

---

- Deep-link to a specific paragraph on a long landing page via a URL fragment.
- Let editors copy a paragraph's anchor link directly from the edit form.
- Build in-page "jump to section" navigation targeting individual paragraphs.
- Share a link that scrolls straight to the relevant paragraph.
- Provide stable anchors that don't change when paragraph order changes (UUID-based).
- Support table-of-contents widgets that link into paragraph sections.
- Resolve library ("from_library") paragraphs to the real reusable paragraph's UUID for anchoring.
- Enable anchor-based navigation without adding manual anchor fields.
- Link support/FAQ answers to exact paragraphs from external docs.
- Improve accessibility of long pages with addressable sections.
- Reference a specific paragraph in analytics or QA notes by its anchor.
- Avoid hand-editing HTML `id` attributes for jump links.
- Keep anchors consistent across cache clears (derived from UUID).
- Point marketing links at a specific content block within a page.
- Let editors self-serve shareable section links.
