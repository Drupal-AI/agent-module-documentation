<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Entity Form Field — agent index

Adds every form-configurable entity field to Views' *Add field* list as **"Form field: &lt;label&gt;"**,
rendering a real widget per row so a view becomes a bulk-edit form.
No settings page (`configure: null`), no permissions, no Drush, no services, no plugin types.

- **Add a form field to a view: field ids, `options.plugin` keys, config shape, access rules** →
  [configure/add-form-field.md](configure/add-form-field.md)

Key facts:

- Views field id (the `field` key in config): **`form_field_<field_name>`**; handler
  `plugin_id: entity_form_field` (`@ViewsField("entity_form_field")`).
- Registered by `hook_views_data_alter()` on the entity's **base table**, or its **data table**
  when the entity type is translatable.
- Options live under `options.plugin`: `type`, `settings`, `third_party_settings`,
  `hide_title` (default TRUE), `hide_description` (default TRUE), `fallback_view_mode` (default FALSE).
- Widgets are built with form mode **`views_view`**; the view must render a form
  (`viewsForm()`), so use a display/style that supports views forms (e.g. Table).
- Per-row access: `$entity->access('update')` **and** `$items->access('edit')`; otherwise the row is
  hidden or shown via `fallback_view_mode`. The submit button is hidden when nothing is editable.
- Config schema: `views.field.entity_form_field` (`views_entity_form_field.views.schema.yml`).
