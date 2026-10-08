<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Mask Field — agent index

Applies an input mask (jQuery Mask Plugin) to text inputs so values are typed in an allowed
format (phone, ZIP, dates, IP). Two entry points: **field-widget settings** and a Form API
**`#mask`** property. Client-side UX only — not server-side validation. Configure route
`mask.settings` (`admin/config/content/mask`), permission `administer mask module`.

- **Mask a field on Manage form display (supported widgets, options, where stored)** →
  [configure/mask-a-field.md](configure/mask-a-field.md)
- **Module settings: CDN vs local library, and the translation symbol/pattern table** →
  [configure/settings.md](configure/settings.md)
- **The `mask_field_widget` plugin type — let another module's widget support masks** →
  [plugins/mask-field-widget.md](plugins/mask-field-widget.md)
- **The `#mask` Form API property for custom forms (textfield/tel) + adding element types** →
  [api/mask-property.md](api/mask-property.md)
- **Permission `administer mask module`** → [permissions/permissions.md](permissions/permissions.md)

Key facts: supported widgets out of the box are `string_textfield` and `telephone_default`
(declared in `mask.mask_field_widgets.yml`). A field's mask is stored at
`core.entity_form_display.<entity>.<bundle>.<mode>` → `content.<field>.third_party_settings.mask`
with keys `value` (the mask), `reverse`, `clearifnotmatch`, `selectonfocus`. Settings live in
`mask.settings` (`use_cdn`, `plugin_path`, `translation`).
