# Theming the IEF table

`hook_theme()` registers one theme hook:

- **`inline_entity_form_entity_table`** — render element `form`; template
  `templates/inline-entity-form-entity-table.html.twig`.

This is the drag-sortable table of referenced entities rendered by the Complex widget.
Preprocessing lives in `template_preprocess_inline_entity_form_entity_table()`
(`inline_entity_form.module`): it builds `$variables['table']` as a `#type => 'table'`
render array, sorts columns by weight, adds tabledrag when the `inline_form` handler's
`isTableDragEnabled()` returns TRUE, and renders each row's fields (`label` / `field` /
`callback` column types) plus an Operations column.

## Override it

Copy the template into your theme and adjust markup:

```
themes/mytheme/templates/inline-entity-form-entity-table.html.twig
```

The template receives `{{ table }}` (the assembled table render array). To change **which
columns** appear rather than markup, use `hook_inline_entity_form_table_fields_alter()`
(see hooks doc) — that is the supported extension point for column content.

Themes can also implement the two form-alter hooks
(`hook_inline_entity_form_entity_form_alter`, `hook_inline_entity_form_reference_form_alter`)
to adjust the embedded forms. There is no CSS/JS library shipped as a public API; styling is
done through the table classes (`ief-entity-table`, `ief-row-entity`, `ief-row-form`, …).
