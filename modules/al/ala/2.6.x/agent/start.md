# Advanced Link Attributes (ala) — agent index

A richer widget + formatter for core `link` fields: preset CSS class, target, icon class, text/BG
colour, extra attributes, and per-role visibility. Depends on core `link`. Config schema provided;
no permissions of its own, no Drush, no plugin *types*.

- **Global settings form (`ala_default_classes`, `ala_extra_attributes`) + config keys** →
  [configure/settings.md](configure/settings.md)
- **The `ala_field_widget` widget and `ala` formatter: every setting, option storage, rendering** →
  [plugins/field.md](plugins/field.md)

Key facts:
- Global config route `ala.admin_settings` → `/admin/config/ala` (permission `administer site configuration`),
  config object `ala.settings` (`ala_default_classes`, `ala_extra_attributes`).
- Widget `ala_field_widget` (extends core `LinkWidget`) — set on *Manage form display*; its settings
  toggle which advanced sub-fields (class/icon/color/roles/target/extra) appear.
- Formatter `ala` (extends core `LinkFormatter`) — set on *Manage display*; renders class (element or
  parent, via `ala_preprocess_field`), icon (inside/class/data), inline colour `style`, role visibility.
- Per-link choices are stored in the link item's serialized `options` array (`class`, `icon`, `color`,
  `bgcolor`, `roles`, plus `attributes.target` and extra attributes).
