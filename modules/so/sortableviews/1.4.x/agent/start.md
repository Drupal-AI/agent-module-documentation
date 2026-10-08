# Sortable Views — agent index

Drag-and-drop reordering of View rows; the new order is saved into an **integer entity
field** (Field API) via AJAX. No settings page, permissions, or Drush — all config lives in
the View. Uses core entity `update` access for authorization.

- **The Views plugins/handlers it provides (3 styles + drag-handle field + save area) and
  the `/sortableviews/ajax` save flow** → [plugins/views-plugins.md](plugins/views-plugins.md)
- **Step-by-step: turn a View into a sortable one (style, weight_field, sort, handle, save
  area)** → [configure/setup.md](configure/setup.md)

Key facts: style plugin ids `sortable_default`, `sortable_html_list`, `sortable_table`, each
with a `weight_field` option; field handler id `sortable_views_handle` ("Sortableviews: Drag
and drop handle."); area handler id `save_sortable_changes` ("Save Sortableviews changes").
The weight field must be a spare integer field on the entity, and should also be added as a
view sort criterion.
