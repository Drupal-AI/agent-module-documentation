No Non-breaking Space Filter removes all non-breaking spaces (`&nbsp;` and the U+00A0 character) from content and collapses the resulting runs of spaces, available both as a text-format filter and as a field formatter.

---

The module offers two ways to strip non-breaking spaces, both delegating to one helper `_no_nbsp_eraser()`. First, a **text-format filter** plugin `filter_no_nbsp` ("No Non-breaking Space Filter", a `TYPE_TRANSFORM_IRREVERSIBLE` filter) that you enable on any text format at *Configuration → Content authoring → Text formats and editors*; when content is rendered through that format, every `&nbsp;` entity and every raw U+00A0 byte is replaced with a normal space and multiple contiguous spaces are collapsed to one. It has a single setting, **Preserve placeholders** (`preserve_placeholders`, default off): when on, a non-breaking space that sits directly inside an otherwise-empty tag (e.g. `<p>&nbsp;</p>`) is kept as a spacing placeholder rather than removed. Second, a **field formatter** `no_nbsp` ("No Non-breaking Space Filter") for `text`, `text_long` and `text_with_summary` fields, which runs the same eraser over the field's already-processed output at display time — useful when you cannot or don't want to change the field's text format. The filter's setting is stored in the text format's config (`filter.format.<id>.filters.filter_no_nbsp`), validated by the schema `filter_settings.filter_no_nbsp`. The module has no configure route of its own, no permissions, no Drush, and defines no new plugin type.

---

- Strip stray `&nbsp;` entities that WYSIWYG editors (CKEditor) insert into body copy.
- Clean up content pasted from Microsoft Word or other rich-text sources that carries non-breaking spaces.
- Collapse multiple spaces down to a single space when rendering a text field.
- Remove U+00A0 characters copied from PDFs or web pages before display.
- Enable the filter on a specific text format (e.g. Basic HTML) so all content using it is cleaned.
- Keep intentional spacing placeholders like `<p>&nbsp;</p>` by turning on Preserve placeholders.
- Apply the cleanup only at display time, without altering stored content, via the field formatter.
- Clean a single field's output using the no_nbsp field formatter without touching its text format.
- Normalise imported/migrated content that is littered with non-breaking spaces.
- Prevent awkward non-breaking spaces from breaking responsive line wrapping.
- Ensure consistent, single-spaced text for search indexing or plain-text exports.
- Fix double spaces that appear after removing non-breaking spaces.
- Apply to text, long text, and text-with-summary fields via the formatter.
- Sanitise user-submitted content before it is shown to other visitors.
- Combine with other filters in a text format's pipeline to tidy markup.
- Provide editors a "just clean it up" format that removes nbsp noise automatically.
- Improve copy/paste consistency across a content team by cleaning nbsp on output.
- Reduce visual glitches where `&nbsp;` created unexpected gaps between words.
- Standardise whitespace in teaser/summary output using the formatter.
- Clean email/newsletter body fields rendered through a filtered format.
- Remove non-breaking spaces from third-party feed content before display.
- Keep exported data free of hidden U+00A0 characters.
- Offer a display-only cleanup for legacy fields whose stored markup must stay unchanged.
