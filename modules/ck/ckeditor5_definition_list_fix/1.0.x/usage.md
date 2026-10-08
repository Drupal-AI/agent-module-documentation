<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CKEditor 5 Definition List Fix is a JavaScript-only CKEditor 5 plugin that keeps `<dl>`/`<dt>`/`<dd>` markup semantic by preventing CKEditor from inserting unwanted `<p>` wrappers (and redundant `<em>` around `<i>`) while editing.

---

Drupal core's CKEditor 5 integration can normalize definition lists in unhelpful ways: turning `<dt>` into paragraphs, injecting `<p>` inside `<dt>`/`<dd>`, and reshaping valid `<dl>` structures on save. This module registers model elements (`definitionList`, `definitionTerm`, `definitionDescription`) plus upcast and data/editing downcast converters in `js/definition-list-fix.js` so the structure round-trips cleanly through the editor, carrying `id`/`class`/`style` attributes with it. It also hooks the editor's data processor to strip a redundant `<em>` wrapping a lone `<i>`, preserving semantic inline markup such as `<i lang="la">et cetera</i>`. The plugin is declared in `ckeditor5_definition_list_fix.ckeditor5.yml`, which also declares the source elements the format may allow and a toolbar button (with an SVG icon).

There is no PHP: no routes, permissions, services, config schema, or settings screen — the module only depends on core `ckeditor5`. To use it, enable the module, add the "Definition List Fix Plugin" button to the CKEditor 5 toolbar of the relevant text format, and make sure the definition-list elements are allowed by that format. Because it is editor-only, it has no server request surface; sanitization and access continue to be governed entirely by the text format's filters and the `use text format` permissions.
---
- Stop `<p>` wrappers appearing inside `<dt>` terms in CKEditor 5.
- Stop `<p>` wrappers appearing inside `<dd>` definitions.
- Produce clean, semantic `<dl>/<dt>/<dd>` markup on save.
- Add the "Definition List Fix Plugin" button to a text format's toolbar.
- Allow definition-list elements (`dl`, `dt`, `dd`) in a text format.
- Preserve `id`, `class` and `style` attributes on `dl`/`dt`/`dd`.
- Keep inline `<i>` markup instead of it being wrapped in `<em>`.
- Preserve `<i lang="la">et cetera</i>` for foreign words and phrases.
- Preserve `<i>` for scientific or taxonomic names.
- Improve semantic HTML for glossary-style content.
- Build FAQ layouts using proper definition-list structure.
- Author technical documentation with correct term/definition markup.
- Make definition-list content easier to style with CSS.
- Fix definition-list output on migrated content when it is re-edited.
- Keep authors in the WYSIWYG rather than the source-editing view.
- Support accessibility-focused, government or enterprise editorial content.
- Enable per text format (e.g. Full HTML) as needed.
- Avoid manual source cleanup after editing definition lists.
- Complement core source-editing for `dl` structures.
- Deploy a lightweight editor fix with no external libraries or runtime endpoints.
