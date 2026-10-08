<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Provides a field formatter that displays the value of a text or string field as syntax-highlighted source code instead of plain body text.

---

The module adds a single `syntax_highlighting_field_formatter` FormatterBase plugin that applies to `string_long`, `text_long`, `text` and `text_with_summary` fields. On any entity display (via **Manage display**) you switch a code-bearing field to this formatter and its stored value is rendered wrapped for a client-side highlighter rather than run through the normal text-format pipeline. It is a display-only concern: it changes how a field's existing value is shown, not how it is entered or stored, and there is no admin route, permission or service.

Typical use is a "code snippet" field on a blog, documentation or tutorial content type where authors paste source and want it rendered with highlighting. Because it is a formatter over field values authors already control, its trust boundary is the same as the field itself; it does not introduce request-handling endpoints.

---
- Render a code field as highlighted source instead of plain text
- Apply highlighting to a `string_long` field holding a snippet
- Apply highlighting to a `text_long` / body field
- Apply highlighting to a `text` or `text_with_summary` field
- Show code samples on a tutorial or documentation content type
- Switch a field to this formatter under Manage display
- Keep authoring unchanged while only altering display
- Present pasted config/YAML/PHP snippets legibly on node pages
- Use per view-mode (e.g. highlight in full view, plain in teaser)
- Add readable code blocks to blog posts
- Display API examples stored in a dedicated field
- Format command-line examples in help content
- Show highlighted code in a custom entity's display
- Provide consistent code presentation across a content type
- Avoid hand-writing `<pre><code>` markup in the body
