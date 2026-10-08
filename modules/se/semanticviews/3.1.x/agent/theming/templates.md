<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Templates, preprocessors & the attribute helper

Semantic Views renders through two Twig templates; the work is done in the preprocessors in
`semanticviews.module`.

## Templates

- `templates/semanticviews-style.html.twig` (theme hook `semanticviews_style`) — the list/group/row
  wrapper.
- `templates/semanticviews-row.html.twig` (theme hook `semanticviews_row`) — a single row's fields.

Copy either into your theme to override, but usually you don't need to — the point of the module
is to configure markup from the UI instead of theming.

## Preprocessors

- `template_preprocess_semanticviews_style(&$vars)` — reads `view->style_plugin->options`, builds
  `Attribute` objects for `group`, `list`, and each `row` (applying striping, first/last classes,
  and token replacement), exposing `vars['group']`, `vars['list']`, `vars['rows'][id]`
  (`content`, `element`, `attributes`).
- `template_preprocess_semanticviews_row(&$vars)` — iterates `view->field`, and per non-excluded
  field exposes `vars['fields'][id]` with `content`, `raw`, `handler`, `element_type`,
  `attributes`, `label`, `label_colon`, `label_element_type`, `label_attributes`. Fields with no
  saved `semantic_html` default to `element_type: div`, `label_element_type: label`.

## `semanticviews_extract_attributes($string)`

The helper that turns the `attribute|value` textareas into an array:
- Splits the string on newlines, trims, drops empty lines.
- For each line, `key|value` → `[key => value]`; a line without `|` → `[text => text]`.
- The result is applied with `Attribute::setAttribute($key, $value)`.

So `class|card\nrole|listitem` becomes `class="card" role="listitem"`. Row/field values are also
run through `tokenizeValue()` first, enabling Views tokens and `{{ row_index }}`.
