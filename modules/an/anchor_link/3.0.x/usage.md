CKEditor Anchor Link adds an "Anchor link" toolbar button and an improved link dialog to CKEditor 5, letting editors create named anchors (`<a id="...">`) and jump links to them from within the rich-text editor.

---

Out of the box CKEditor 5 in Drupal can link to URLs but cannot place named anchors or link to a spot on the same page. This module bundles the `vardot/ckeditor5-anchor-drupal` CKEditor 5 plugin and wires it into Drupal's editor configuration system, exposing an "Anchor link" toolbar button you drag into a text format's toolbar. Editors can insert an anchor (a named target rendered as `<a id="name" class="ck-anchor">`) and create links that point to those anchors, enabling in-page navigation and tables of contents. The module registers the extra HTML attributes (`id`, `target`, `rel`, `class="ck-anchor"`) so Drupal's filter system permits them. It also ships a CKEditor 4-to-5 upgrade path plugin so sites migrating from the old anchor button keep working, and an optional Linkit matcher so the Linkit autocomplete can resolve anchor links. Styling for the anchor marker is provided by a small CSS library. Because everything is configured per text format, different formats (e.g. Full HTML vs. Basic HTML) can enable or omit the feature independently.

---

- Add an "Anchor link" button to a CKEditor 5 text format toolbar.
- Insert named anchors (`<a id="section-1">`) inside body content.
- Create in-page "jump" links that scroll to an anchor on the same page.
- Build a manual table of contents that links to headings on a long article.
- Link from a summary block down to a detailed section further on the page.
- Provide "back to top" style navigation within rich text.
- Migrate a CKEditor 4 site's anchor functionality to CKEditor 5.
- Allow the `id`, `rel`, and `target` attributes on links via a text format.
- Let editors set `target` (e.g. open in new window) through the link dialog.
- Add `rel` attributes (such as `nofollow`) to links from the editor UI.
- Enable anchors only in Full HTML while leaving Basic HTML plain.
- Give FAQ pages clickable question-to-answer anchor navigation.
- Cross-reference clauses in long legal or policy documents.
- Support deep-linking to a specific part of a landing page.
- Integrate with Linkit so autocomplete suggestions include anchors.
- Render a visible anchor marker in the editor via the `ck-anchor` class.
- Style anchor markers with the module's bundled CSS.
- Provide a richer link-insertion dialog than CKEditor 5's default.
- Keep anchor markup clean and filter-compatible across text formats.
- Let content teams create documentation pages with section jump links.
