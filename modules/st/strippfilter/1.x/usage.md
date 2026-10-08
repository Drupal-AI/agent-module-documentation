<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Strippfilter is a text-format filter that unwraps HTML paragraph tags, keeping the inner content of every `<p>` element and dropping the `<p>` wrapper so a rich-text format can render on one line.

---

Strippfilter ("Strip HTML tags - custom text format filter") adds one `@Filter` plugin, "Strip paragraph tags" (id `strippfilter`), to Drupal's text-format pipeline. When the filter runs it parses the text with Drupal's DOM-based `Html::load()`, collects every `<p>` element, and returns the concatenated inner HTML of those paragraphs — the `<p>` tags themselves (and any `dir`/`title`/other attributes CKEditor 5 leaves on them) are removed while the content between them is kept. If the text contains no `<p>` element it is returned unchanged. The intended use is a dedicated text format for inline, WYSIWYG-edited output: authors edit a title, caption, or credit in CKEditor 5 (which stubbornly wraps content in paragraph tags), but the rendered value has no paragraph breaks and is safe to place inside a heading or other one-line context. It has no settings, no config, no routes, and depends only on core `filter`; you configure it entirely from the Text formats and editors admin screen by enabling the filter on a format and, per the module's own advice, ordering it appropriately in the filter run.

---

- Create a text format whose output is always inline (no paragraph wrapping).
- Strip the `<p>` wrapper CKEditor 5 forces around single-line field content.
- Render a field title as bold inline text without a trailing paragraph break.
- Produce a caption that allows inline bold/italic but no paragraph breaks.
- Format a credit line that is always one line, edited in CKEditor 5.
- Build a three-part caption (title / caption / credit) each edited with a WYSIWYG editor but rendered inline.
- Place rich-text-edited content inside a heading tag without stray `<p>` tags.
- Remove `dir`, `title`, and other attributes CKEditor 5 leaves on pasted paragraph tags.
- Unwrap paragraphs while preserving inline markup (`<strong>`, `<em>`, links) inside them.
- Give editors CKEditor 5 for a one- or two-line textarea field and still get inline output.
- Pair the filter with the Textarea widget for text fields for a compact editing experience.
- Restrict a field's allowed formats to only the always-inline format so output stays single-line.
- Avoid the core "Strip HTML tags" filter, which would remove the paragraph content too, not just the tags.
- Add the filter to a format used by short teaser or summary fields.
- Normalize markup coming from copy-paste into a WYSIWYG editor down to inline content.
- Enforce inline rendering for a "subtitle" or "byline" field across a site.
- Keep a call-to-action label free of block-level paragraph markup.
- Apply the filter only where a dedicated inline format is selected, leaving other formats untouched.
- Order the filter appropriately in a format's filter chain when combining it with other filters.
- Use on Drupal 10.2+ or 11 where the DOM-based `Html::load()` paragraph handling is available.
- Provide a clean inline value for use in templates or downstream fields.
