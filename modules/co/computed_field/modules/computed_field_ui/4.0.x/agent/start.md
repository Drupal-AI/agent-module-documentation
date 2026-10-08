# computed_field_ui — agent start

Admin-UI submodule of **computed_field**. Adds computed fields through core Field UI —
no config of its own. Depends on `computed_field` + `field_ui`.

What it adds:
- **"Add computed field"** local action on each bundle's Manage fields page —
  path `{field_ui_base}/fields/add-computed-field`
  (e.g. `/admin/structure/types/manage/article/fields/add-computed-field`),
  route `entity.computed_field.computed_field_add_{entity_type}`. The form picks a
  computed field plugin (those without `no_ui`) and renders its config sub-form.
- **Edit / delete** forms for computed fields, wired into Field UI.
- **"Computed fields"** report at `/admin/reports/fields/computed`
  (route `entity.computed_field.collection`) listing all computed fields.
- Gated by the `administer computed_field entities` permission; new field names get the
  `computed_field.settings:field_prefix` prefix (default `computed_`).

Saving the form creates a `computed_field` config entity — the same entity you can build in
code. Plugins, the config entity shape, and programmatic creation are documented on the
parent module: `../../../../4.0.x/agent/start.md`.
