<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SDC Display — agent index

Renders Drupal fields, view modes, and field groups through **Single Directory Components
(SDC)**, mapping field values onto component props/slots. All config lives on *Manage
display* as `third_party_settings.sdc_display` (or a field group's `format_settings`).
Depends on `cl_editorial` + `sdc_tags`. No settings page, permission, entity, or Drush.

- **The three integration points, config keys, and how to set them** →
  [configure/component-mapping.md](configure/component-mapping.md)
- **Render mechanism (hooks, `#type => component`, prop/slot mapping) and component tags** →
  [api/mechanism.md](api/mechanism.md)

Key facts:
- Field-group formatter id: `sdc_display` ("Single Directory Component", **view** context only).
- Per-field and per-view-mode config: `entity_view_display` `third_party_settings.sdc_display`
  = `{ enabled, component: {machine_name}, mappings: {static, dynamic} }`.
- Component pickers are populated via tags `sdc_display:field_formatter` and
  `sdc_display:view_mode` (declared in `sdc_display.component_tags.yml`).
- Enabling a whole-view-mode mapping makes `sdc_display_entity_view_alter()` replace the
  entire entity build with `#type => component`.
