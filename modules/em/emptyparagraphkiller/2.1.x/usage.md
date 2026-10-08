Empty Paragraph Killer is a text-format filter that non-destructively strips empty `<p>` paragraphs (including ones containing only whitespace or `&nbsp;`) from rendered content, cleaning up the extra blank lines editors create by hitting Return twice in a WYSIWYG editor.

---

The module provides a single Drupal filter plugin, id `emptyparagraphkiller` ("Empty Paragraph filter"), extending `FilterBase` with type `TYPE_TRANSFORM_REVERSIBLE`. It works in the standard two-phase filter pipeline: `prepare()` replaces every empty paragraph — matched by the regex `#<p[^>]*>(\s|&nbsp;?)*</p>#` — with a `[empty-para]` placeholder, and `process()` then removes those placeholders, so the filtering is reversible-safe and does not alter stored source content (only the rendered output). It has no settings form, no configuration, no schema, no permissions, and no dependencies beyond Drupal core's Filter module; you simply enable the "Empty paragraph filter" checkbox on a text format at `/admin/config/content/formats` and, per the maintainers, place it at (or near) the bottom of the format's filter processing order so other filters run first. It is aimed at sites using a WYSIWYG editor; on a site without one, core's "Convert line breaks" filter is usually enough. Enablement and ordering are stored in the text format's config entity (`filter.format.<id>` → `filters.emptyparagraphkiller` with `status` and `weight`).

---

- Remove blank paragraphs editors create by pressing Return twice at the end of a paragraph.
- Clean up pasted WYSIWYG/CKEditor content that arrives full of empty `<p></p>` tags.
- Strip paragraphs that contain only a non-breaking space (`&nbsp;`).
- Strip paragraphs that contain only whitespace.
- Keep rendered body copy consistent with the theme's paragraph spacing.
- Avoid large visual gaps between paragraphs on article and page content.
- Enforce clean markup on a "Full HTML" or "Basic HTML" text format.
- Apply the cleanup non-destructively so the original source text is never modified in storage.
- Combine with CKEditor so authors can type naturally without producing messy output.
- Add the filter to a custom text format used for a specific content type.
- Run the filter last in the processing order so it doesn't interfere with earlier filters.
- Tidy imported/migrated content whose HTML has stray empty paragraphs.
- Reduce reliance on manual HTML source editing to delete blank lines.
- Improve accessibility/readability by removing meaningless empty block elements.
- Standardize spacing across many editors' differing habits.
- Provide a friendlier authoring experience where double-Return is silently tolerated.
- Prevent empty paragraphs from pushing following content or images down the page.
- Keep email or newsletter HTML compact by filtering empty paragraphs before send.
- Use it on a comment text format to clean user-submitted markup.
- Ensure teaser/summary output is not padded with blank paragraphs.
