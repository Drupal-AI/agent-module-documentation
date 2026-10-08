<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Better Formats — agent index

Extends core's text-format system: per-text-field control of **allowed formats**, **format
order**, and **default format**, plus per-role hiding of the format selector and format tips.
One tiny global setting; most config is **per-field third-party settings**.

- **Global setting, per-field allowed/order/default settings, where stored** →
  [configure/settings.md](configure/settings.md)
- **The permissions it adds (static + dynamic per entity type)** →
  [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Configure route `better_formats.settings` → `/admin/config/content/formats/settings`
  (permission `administer filters`). Only key: `per_field_core` (bool, "Use field default").
- Per-field settings live on the FieldConfig at
  `field.field.<entity>.<bundle>.<field>.third_party.better_formats`:
  `allowed_formats_toggle`, `allowed_formats`, `default_order_toggle`,
  `default_order_wrapper.formats`. Shown for `text`, `text_long`, `text_with_summary` fields.
- Applies at render via `better_formats_filter_process_format()` (runs right after core
  `TextFormat::processFormat()`), altering the `text_format` element's `#options`/default.
- Permissions: `hide format tips`, `hide more format tips link`, and dynamic
  `hide format selection for <entity_type>` (one per fieldable entity type).
- Depends on core Filter only. No Drush, no plugin types.
