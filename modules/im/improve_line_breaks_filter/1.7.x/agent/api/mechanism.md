<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How the filter transforms text

The filter plugin `ImproveLineBreaksFilter::process()` delegates to
`Drupal\improve_line_breaks_filter\TextReplacement::processImproveLineBreaks($text, $remove)`.

## Skip list first

The text is split with `preg_split` on opening/closing `pre`, `script`, `style`, `object`,
`code`, `iframe` tags and HTML comments (`<!-- ... -->`), keeping the delimiters. Odd-indexed
chunks are the tags themselves; content **inside** an ignored tag pair is passed through
untouched so code samples, scripts and pre-formatted blocks are never rewritten.

## The replacement

For each non-ignored chunk it runs one of two regex replacements on `/<p>(&nbsp;|\s)*<\/p>/ui`
(case-insensitive, Unicode) — i.e. a `<p>` containing only `&nbsp;` and/or whitespace:

- `remove_empty_paragraphs = FALSE` → `replaceEmptyParagraph()` replaces the match with `<br />`.
- `remove_empty_paragraphs = TRUE` → `removeEmptyParagraph()` replaces the match with `''`.

## Notes for agents

- It is an **output** transform (`TYPE_TRANSFORM_IRREVERSIBLE`): the stored field value keeps its
  empty paragraphs; only the rendered HTML is cleaned. Re-check via a rendered node, not the raw body.
- Only *empty* paragraphs are affected — paragraphs with real content, and `<br>` tags, are left alone.
- `process()` short-circuits and returns the text unchanged when `$text` is empty.
- The unit test `tests/src/Unit/TextReplacementTest.php` exercises both branches; there are no
  services, hooks-for-you (`*.api.php`), Drush commands, or plugin types.
