<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Multiple BR Filter is a text-format filter (`remove_multiple_br`) that replaces two or more consecutive `<br>` tags with a single `<br />`.
---
The filter plugin runs `preg_replace('/(<br\s*\/?>\s*){2,}/i', '<br />', $text)` in its `process()` method and is marked `TYPE_TRANSFORM_IRREVERSIBLE`, so it cleans up the rendered output without changing the stored source. It is useful for tidying content pasted from word processors or emails where editors leave stacks of blank lines represented as multiple line breaks.

It depends only on core `filter`, has no configuration, routes, permissions or UI, and is enabled per text format on the *Text formats and editors* admin page. Because it only affects rendered output, ordering it relative to other filters (e.g. after "Convert line breaks") is the only setup consideration. Setup: edit a text format, enable "Remove multiple consecutive `<br>` tags", and position it appropriately in the filter order.
---
- Collapse multiple `<br>` tags into one in rendered content.
- Remove stacks of blank lines from pasted content.
- Tidy output from Word/email paste in the WYSIWYG editor.
- Enable the filter on the Full HTML text format.
- Enable the filter on the Basic HTML text format.
- Clean up excessive line breaks without editing the source.
- Normalise spacing between paragraphs of body text.
- Apply the cleanup only at render time (irreversible transform).
- Combine with "Convert line breaks" for consistent output.
- Reduce visual gaps caused by repeated `<br>` tags.
- Improve typographic consistency across authored content.
- Order the filter after other line-break filters.
- Handle `<br>`, `<br/>` and `<br />` variants (case-insensitive).
- Apply to comment text formats as well as node bodies.
- Keep a single line break where editors added several.
