<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Strip HTML tags - custom text format filter (strippfilter) — agent index

One text-format `@Filter` plugin that **unwraps paragraph tags**: it keeps the inner content of
every `<p>` element and drops the `<p>` wrappers (and their attributes). Purpose: a dedicated
inline text format for CKEditor-5-edited fields (titles, captions, credits) that should render on
one line. Depends only on core **`filter`**. Core requirement `^10.2 || ^11`.
License GPL-2.0-or-later. Version 1.1.0 (doc dir `1.x`).

- **The filter plugin, exact strip behavior, weight/ordering, and how to enable it** →
  [plugins/filter.md](plugins/filter.md)

## What it actually is

- One plugin: `StripParagraphTags` (id **`strippfilter`**, title *"Strip paragraph tags"*), in
  `src/Plugin/Filter/StripParagraphTags.php`, extending core `FilterBase`.
- Annotation: `type = TYPE_TRANSFORM_REVERSIBLE`, **`weight = -10`**.
- `process($text, $langcode)` returns `new FilterProcessResult(strippfilter_process($text))`; all
  work is in the two procedural helpers in `strippfilter.module`.
- **No** settings form, config object, config schema, routes, permissions, services, Drush
  commands, submodules, or install file. `provides_config_schema = false`.

## Mechanism (from source, `strippfilter.module`)

- `strippfilter_process($text)`: `Html::load($text)` (Drupal's DOM/HTML5-PHP wrapper — the support
  added in Drupal 10.2, hence the `^10.2` floor), then `getElementsByTagName('p')`. If there are
  **no** `<p>` elements it returns `$text` unchanged. Otherwise it concatenates the inner HTML of
  every paragraph and returns that — **content outside any `<p>` is dropped**, and the `<p>` tags
  plus their attributes (`dir`, `title`, etc. that CKEditor 5 leaves on pasted paragraphs) are
  removed.
- `strippfilter_inner_html($element)`: for each child node, imports it into a fresh `Html::load('')`
  DOM body and appends `Html::serialize($tmp_dom)`. This is a **DOM parse + re-serialize** (not
  `str_replace`, `preg_replace`, or `strip_tags`) — the module comment explains a naive string
  replace was rejected because CKEditor 5 keeps attributes on the paragraph tags.

## Notes / caveats

- Because it returns only the concatenation of `<p>` inner HTML, input with paragraphs loses any
  non-paragraph content and any inter-paragraph separation — intended for single-value inline
  fields, not general body text.
- `strippfilter_help()` (hook_help) documents the module on its help page; the README/help note
  the CKEditor 5 workaround use case (see ckeditor/ckeditor5#762).
- Plugin weight is `-10` (runs early); the project page advises making the filter run **last** in
  the format so it acts on already-processed markup — set the order deliberately per format.
