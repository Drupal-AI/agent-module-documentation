<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CKEditor 5 Pre adds a `<pre>` (preformatted text) option to the CKEditor 5 block-format / Headings dropdown.

---

CKEditor 5 Pre is a small, declarative CKEditor 5 plugin. It ships no PHP, JavaScript or routes: a single `ckeditor5_pre.ckeditor5.yml` file reuses core's built-in `ckeditor5_heading` plugin to register one extra heading option (model `pre`, view element `pre`), and a tiny admin CSS file renders that option's toolbar label in a monospace font. Once enabled, editors using a text format whose toolbar includes the Headings dropdown can pick "Pre" to mark a block as preformatted (for code snippets or fixed-width text). Because the plugin declares the `<pre>` element, Drupal automatically adds `<pre>` to the text format's Allowed HTML tags the next time the format is saved. It depends only on core `ckeditor5` and works reliably for plain text and single-level tags; wrapping many nested block-level elements may give unexpected results.

---

- Add a `<pre>` (preformatted) option to CKEditor 5.
- Extend the Headings / block-format dropdown with a "Pre" entry.
- Let content editors create preformatted blocks without HTML source editing.
- Format code snippets or fixed-width text inline in the editor.
- Reuse core's `ckeditor5_heading` plugin rather than shipping custom JS.
- Automatically allow `<pre>` in a text format's Allowed HTML tags on save.
- Style the "Pre" toolbar label in a monospace font for recognizability.
- Provide the same preformatted option across Full HTML, Basic HTML or custom formats.
- Give editors a one-click way to preserve whitespace/line breaks in a block.
- Depend only on Drupal core's CKEditor 5, with no external libraries.
- Support Drupal 10, 11 and 12 with the same declarative definition.
- Enable per text format by adding the Headings item to that format's toolbar.
- Re-save Basic HTML (or any restricted format) to pick up the `<pre>` allowed tag.
- Round-trip existing `<pre>` markup back into the editable "Pre" block on load.
- Avoid maintaining custom CKEditor 5 build tooling for a simple tag addition.
- Offer editors a preformatted option alongside the standard H2–H6 headings.
- Keep the site's allowed-HTML policy explicit and editor-driven.
- Serve as a minimal example of a declarative CKEditor 5 plugin definition.
