<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CKEditor Abbreviation adds an **Abbreviation** button (and matching right-click context-menu item) to the CKEditor 5 toolbar so content editors can wrap selected text in an `<abbr>` tag with a `title` explanation, producing accessible tooltips for acronyms and abbreviations.

---

The module is a **CKEditor 5 plugin** with almost no PHP: its only PHP is a `hook_help()`. The plugin is declared in `ckeditor_abbreviation.ckeditor5.yml` under the id `ckeditor_abbreviation_abbreviation`, which loads the JavaScript plugin `abbreviation.Abbreviation`, exposes a toolbar item named `abbreviation` (label "Abbreviation"), and declares the HTML elements it produces: `<abbr>` and `<abbr title>`. To enable it you add the **Abbreviation** button to a text format's CKEditor 5 toolbar (Configuration → Content authoring → Text formats and editors) and, if you want the explanatory tooltip, allow the `title` attribute on `<abbr>` in that format's "Limit allowed HTML tags" filter. In the editor, selecting text and clicking the button (or picking "Edit Abbreviation" from the context menu when the cursor is inside an existing `<abbr>`) opens a balloon dialog with two fields — the abbreviation text and its title/explanation. Clearing the title removes the attribute; clearing the abbreviation untags it. The plugin ships a prebuilt DLL-compatible bundle (`js/build/abbreviation.js`) plus an SVG icon and a small admin CSS library. It has no settings form, no config schema, no permissions, and no configure route of its own — everything is configured through core's text-format/editor configuration.

---

- Add an **Abbreviation** button to a text format's CKEditor 5 toolbar.
- Tag an acronym like "HTML" with a `title` so readers get a hover tooltip explaining it.
- Wrap selected text in an `<abbr title="…">` element without editing source HTML.
- Edit an existing abbreviation's explanation by clicking inside it and reopening the dialog.
- Remove just the tooltip by clearing the title field (keeps the text, drops `title`).
- Untag an abbreviation entirely by clearing the abbreviation field in the dialog.
- Use the right-click context menu "Edit Abbreviation" to jump straight to an existing `<abbr>`.
- Improve accessibility by giving screen-reader-friendly expansions of acronyms.
- Standardize how editors mark up abbreviations across a site's content.
- Allow `<abbr title>` in the "Limit allowed HTML tags and correct faulty HTML" filter so tooltips survive filtering.
- Provide editors a WYSIWYG way to add semantic `<abbr>` markup instead of hand-writing tags.
- Enable the button only on formats meant for full-content editing (e.g. Full HTML).
- Keep abbreviation markup consistent with WCAG semantic-markup recommendations.
- Add abbreviation support to a custom text format used by a specific content type.
- Let authors define organization-specific acronym expansions inline.
- Tag units or jargon (e.g. "kg", "API") with explanatory titles in body copy.
- Combine with other CKEditor 5 plugins in the same toolbar configuration.
- Export the enabled button as part of a text format's config for deployment.
- Give multilingual sites a way to explain locale-specific abbreviations via the title attribute.
- Replace a manual "type raw `<abbr>` in Source view" workflow with a guided dialog.
- Ensure abbreviations render as real `<abbr>` elements in the front-end markup.
