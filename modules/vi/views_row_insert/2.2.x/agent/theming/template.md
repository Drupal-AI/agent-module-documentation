# Theming / output

Theme hook `views_row_insert` (registered in `views_row_insert_theme()`, preprocessed by
`template_preprocess_views_row_insert()` in `views_row_insert.theme.inc`), template
`templates/views-row-insert.html.twig`.

## Preprocess variables

- `use_plugin` — bool; when TRUE the template swaps `rows` for `rows_insert`.
- `rows_insert` — the combined list of original + inserted rows, each `{ content, attributes }`.
  Built by walking the original `rows`, pushing an `insertRow` after every `rows_number` rows,
  honoring `row_header`, `row_footer`, and the `row_limit`.
- `rows` — the original view rows (used only when `use_plugin` is FALSE).

Class handling: `default_rows` adds `views-row` / `views-row-<n>`; `strip_rows` adds
`views-row-odd|even` and `views-row-first|last`; inserted rows get `class_name`, original rows
get `row_class`.

## Template (default)

```twig
{% if use_plugin %}{% set rows = rows_insert %}{% endif %}
{% for row in rows %}
  <div{{ row.attributes }}>{{ row.content | raw }}</div>
{% endfor %}
```

`row.content` is emitted with `| raw` — inserted custom HTML is **not filtered**.

## Override

Copy `views-row-insert.html.twig` into your theme (optionally as a
`views-row-insert--<view>--<display>.html.twig` suggestion) and adjust the wrapper markup.
Inserted vs original rows are only distinguishable by the CSS classes set via `class_name` /
`row_class`, so set those if your override needs to target them.
