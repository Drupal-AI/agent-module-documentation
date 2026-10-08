<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Improve Line Breaks Filter adds a text-format filter that turns the empty paragraphs a WYSIWYG editor leaves behind (`<p></p>`, `<p>&nbsp;</p>`) into `<br />` tags, or removes them entirely.

---

The module provides a single core filter plugin, id `improve_line_breaks_filter` (title "Improve line breaks", type `TYPE_TRANSFORM_IRREVERSIBLE`, default weight 50). You enable it per text format on *Configuration → Content authoring → Text formats and editors*; there is no global settings page (`configure` is null). The filter has one setting, `remove_empty_paragraphs` (boolean, default FALSE): when FALSE it replaces each empty paragraph with `<br />`; when TRUE it deletes empty paragraphs outright. Processing is done by `Drupal\improve_line_breaks_filter\TextReplacement`, which first splits the text on `pre`, `script`, `style`, `object`, `code`, `iframe` tags and HTML comments so their contents are never touched, then runs the regex `/<p>(&nbsp;|\s)*<\/p>/ui` over the remaining chunks. The setting is stored inside the text format's own config at `filter.format.<format>.filters.improve_line_breaks_filter`. Depends only on core `filter`.

---

- Convert the empty `<p>&nbsp;</p>` paragraphs CKEditor inserts on Enter into simple `<br />` line breaks.
- Tighten article body spacing where margin-heavy empty paragraphs were weakening the layout.
- Completely delete empty paragraphs from imported/pasted content by enabling "Remove empty paragraphs".
- Keep code samples intact by relying on the filter's skip list (`pre`, `code`, `script`, `style`, `object`, `iframe`).
- Normalise line breaks in a "Full HTML" format used by editors who overuse the Enter key.
- Apply consistent whitespace handling across every text format on a multi-author site.
- Clean up legacy WYSIWYG markup on a content migration without touching stored source values (irreversible transform, applied on output).
- Add the filter near the end of a format's filter chain so other filters run first.
- Replace empty paragraphs with `<br />` in a "Basic HTML" format to preserve intentional single-line spacing.
- Strip decorative empty paragraphs from teaser text so summaries render compactly.
- Fix double-spacing between paragraphs in email-sourced content rendered through a text format.
- Give a "Restricted HTML" comment format tidier output without allowing raw `<br>` from users.
- Prevent empty paragraphs from breaking a fixed-height card or grid layout.
- Standardise editor output so front-end CSS spacing rules stay predictable.
- Handle both `<p></p>` and `<p>&nbsp;</p>` variants with a single filter.
- Deploy the filter setting through configuration (`filter.format.*.filters.improve_line_breaks_filter.settings.remove_empty_paragraphs`).
- Toggle between "replace with br" and "delete" behaviour per text format.
- Avoid a custom preprocess or Twig hack just to clean up trailing empty paragraphs.
- Ensure `<pre>` blocks with intentional blank lines survive the cleanup untouched.
- Improve the look of user-generated content in a forum or blog comment format.
- Apply minute whitespace cleanup only to formats where WYSIWYG editing is enabled.
- Use as a lightweight alternative to a broad HTML-tidy filter when only empty paragraphs are the problem.
