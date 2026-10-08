<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Layout Custom Section Classes — agent index

Adds ID / class / class-list / inline-style / `data-*` attribute fields to Layout Builder
**sections** and their **regions**, from the Configure section form. Global settings choose which
attribute types are offered and a predefined class list.

- **Global settings: which attributes are allowed, the predefined class list, CSS validation** →
  [configure/settings.md](configure/settings.md)
- **How per-section / per-region attribute values are stored and rendered (+ token support)** →
  [configure/section-attributes.md](configure/section-attributes.md)
- **The three permissions (settings / section attributes / region attributes)** →
  [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Configure route `layout_custom_section_classes.settings` →
  `/admin/config/content/layout-builder-section-attributes`; config object
  `layout_custom_section_classes.settings`.
- Global keys: `allowed_section_attributes.{id,class,class_list,style,data}` (booleans),
  `allowed_section_region_attributes.{...}`, `class_list` (sequence, `class|Friendly` lines),
  `relax_css_validation` (bool).
- Per-section values live on the layout config as `custom_id`, `custom_classes`,
  `custom_class_choose`, `custom_styles`, `custom_data_attributes`, and `regions.<id>.region_*`.
- The layout template MUST print `{{ attributes }}` / `{{ region_attributes.REGION }}` for the
  values to show. Requires the `neilime/php-css-lint` library (validates inline styles).
