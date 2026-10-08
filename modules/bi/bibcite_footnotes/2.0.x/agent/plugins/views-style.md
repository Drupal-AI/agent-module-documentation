<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views style: "Bibcite Works Cited List"

`src/Plugin/views/style/WorksCited.php` — `#[ViewsStyle(id: 'bibcite_footnotes_works_cited', …)]`,
extends `StylePluginBase`, theme `views_style_bibcite_footnotes_works_cited`. Use it to render a
bibliography from a View of `bibcite_reference` entities in a block, as an alternative to the inline
bibliography section the filter appends.

- `usesRowPlugin = TRUE`, `usesRowClass = TRUE`.
- Options: `wrapper_class` (default `item-list`), exposed via `buildOptionsForm()` as a textfield.
- `render()` — normalizes every result row's `_entity` to CSL (`serializer`, format `csl`) and returns
  `['#theme' => 'bibcite_footnotes_works_cited', '#data' => $references]`, i.e. the same works-cited
  theme the filter uses. Because it does not pass filter settings, the styler falls back to defaults
  (bidirectional links on, no backlinks since there are no in-text citations).
- Template preprocessor `template_preprocess_views_style_bibcite_footnotes_works_cited()`
  (`bibcite_footnotes.module`) applies `wrapper_class` to the container and per-row classes;
  template `templates/views-style-bibcite-footnotes-works-cited.html.twig`.

Set up: create a View listing BibCite Reference entities, choose Format → "Bibcite Works Cited List",
optionally set the wrapper class, place the view in a block.
