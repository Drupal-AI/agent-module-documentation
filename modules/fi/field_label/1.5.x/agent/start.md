# Field Label — agent index

Adds per-formatter **label** controls (override text, plural label, wrapper tag, CSS classes)
to every field formatter's *Manage display* form. Two layers of state: a global
**settings config** (which features are on + allowed tags + class list) and **per-component
third-party settings** on `entity_view_display` config entities.

- **Global settings, per-field overrides, where they are stored, and the Twig requirement** →
  [configure/settings.md](configure/settings.md)
- **The five feature permissions and what each gates** →
  [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Configure route: `field_label.module_config_form` → `/admin/config/content/field-label`
  (config object `field_label.settings`, requires `administer site configuration`).
- Per-field choices live at
  `core.entity_view_display.<entity>.<bundle>.<mode>` →
  `content.<field>.third_party_settings.field_label.{label_value,plural_label,label_class,label_class_select,label_tag}`.
- Applied at render by `hook_preprocess_field()`; the wrapper tag surfaces as the
  `label_tag` Twig variable — themes overriding `field.html.twig` must use
  `{{ label_tag|default('div') }}`.
- No Drush, no plugins, no config entity of its own.
