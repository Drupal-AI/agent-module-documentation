# Extrafield Views Integration — agent index

Exposes core **display** extra fields (`hook_entity_extra_field_info`) as Views fields, rendered
by a developer-supplied render class. Depends on `views` (+ Entity API). No config
(`configure` null), no permissions, no schema, no Drush, no UI beyond the Views field.

- **How to make an extra field appear in Views: the `render_class` key + the
  `ExtrafieldRenderClassInterface` you implement, and how the field handler renders it** →
  [api/render_class.md](api/render_class.md)

Key facts:
- `hook_views_data_alter()` registers a Views field `extrafield_views_integration__<field_name>`
  for every content-entity `display` extra field that declares a `render_class` key.
- The `@ViewsField("extrafield_views_integration")` handler has an empty `query()` and, in
  `render()`, calls `render_class::render($values->_entity)` (a missing class → messenger warning
  + empty output).
- Only `display`-type extra fields **with** a `render_class` key are exposed; others are skipped.
