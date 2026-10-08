<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Tamper Markdown provides a Feeds Tamper plugin that converts Markdown to HTML during import.

---

Tamper Markdown **converts Markdown to HTML during Feeds import** — a Feeds Tamper plugin that transforms a
field's Markdown content into HTML as items are imported. It depends on the Tamper and Feeds Tamper modules.

Use it to import Markdown as HTML. It is an import/data-transformation feature. Security note: Markdown can embed
**raw HTML**, so the converted HTML is only as safe as the input — ensure the resulting field uses a **text format
that sanitizes** the HTML (or that the feed source is trusted), so imported content can't introduce stored XSS. It
has no access-control role. Configure the Tamper plugin.

---

- Convert Markdown to HTML on import.
- Transform a field's Markdown.
- Import Markdown content.
- Depend on Tamper + Feeds Tamper.
- Serve import/transformation.
- Handle Markdown fields.
- Note Markdown can embed raw HTML (XSS if unsanitized).
- Ensure the field's text format sanitizes (or trust the source).
- Prevent imported content introducing stored XSS.
- Have no access-control role.
- Configure the Tamper plugin.
- Handle markdown conversion.
- Convert markdown.
- Configure the plugin.
- Render HTML.
- Handle the import.
- Transform content.
- Import markdown.
- Sanitize output.
- Provide markdown conversion.
