# Material Icons — agent index

Google **Material Icons / Material Symbols** for Drupal, two ways: a `material_icons` **field
type** (with autocomplete picker) and a **CKEditor 5** toolbar button.

- **Global settings (which font families load), widget settings, and permissions** →
  [configure/settings.md](configure/settings.md)
- **The field type / widget / formatter (columns, autocomplete, `material_icon` template)** →
  [plugins/field.md](plugins/field.md)
- **Adding the Material Icons button to a CKEditor 5 text format** →
  [configure/ckeditor.md](configure/ckeditor.md)

Key facts:
- Settings config: `material_icons.settings` → `families` (list; default `['baseline']`);
  form route `material_icons.settings` at `/admin/config/content/material_icons`.
- Field type `material_icons`, columns `icon` / `family` / `classes`; default widget +
  formatter both id `material_icons`.
- Permissions: `administer material icons`, `use material icons`.
- Depends on core `editor`. No Drush, no plugin types defined.
