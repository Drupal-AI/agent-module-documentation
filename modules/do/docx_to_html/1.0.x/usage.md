<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
A one-page admin tool that converts a Word `.docx` file into HTML in the browser (via bundled Mammoth.js) so content authors can copy the result and paste it into a rich-text field.

---

DOCX to HTML Converter adds a single permission-gated page at `/docx-to-html` (linked from *Administration → Configuration → Content authoring*). The page is a thin Drupal controller that renders a file input, an output area and a "Copy the HTML" button, and attaches one asset library containing the vendored `mammoth.browser.min.js` plus a small behavior script. All work happens client-side: when the author picks a `.docx`, the JavaScript reads it as an ArrayBuffer with `FileReader`, calls `mammoth.convertToHtml()` in the browser, injects the returned HTML into the preview `#output` element, and lets the author copy it to the clipboard. No file is ever uploaded to, stored on, or parsed by the server, and the module ships no config form, entities, plugins, services, or Drush commands — just the route, a controller, a theme hook/template, a permission, two menu links, and the front-end library. It exists to work around CKEditor 5's limited free "Paste from Word" feature, preserving headings, lists, tables, footnotes/endnotes, images (as data URIs), links, and character formatting as far as Mammoth supports.

---

- Give trusted content editors a self-service tool to turn a Word document into paste-ready HTML.
- Work around CKEditor 5's paywalled "Paste from Word (Office)" feature without a paid plugin.
- Convert a `.docx` to HTML without installing any external library — Mammoth.js is bundled.
- Convert documents without sending them to a server or third-party service (privacy-friendly, fully local in the browser).
- Preserve heading structure (H1–H6) when migrating Word content into Drupal.
- Bring ordered and unordered lists across from Word into a text field.
- Carry tables from a `.docx` into HTML markup.
- Move footnotes and endnotes from a Word document into the converted output.
- Embed images from the document inline as data-URI `<img>` tags.
- Keep bold, italic, underline, strikethrough, superscript and subscript formatting.
- Preserve hyperlinks from the source document.
- Retain line breaks and text boxes where Mammoth supports them.
- Bulk-migrate legacy Word content into Drupal body fields during a content-entry project.
- Let authors preview the converted HTML rendered with the current theme before copying it.
- Copy the full converted HTML to the clipboard with one click for pasting elsewhere.
- Gate access to the tool behind a dedicated permission so only chosen roles can reach it.
- Reach the tool quickly from the admin toolbar shortcut or the Configuration → Content authoring menu.
- Provide a lightweight editor aid on sites where a full document-import pipeline is overkill.
- Standardize how a team converts Word documents so everyone produces consistent markup.
- Feed the copied HTML into any long-text field/format (subject to that format's own tag filtering).
- Prototype or spot-check how a Word document will look as HTML.
