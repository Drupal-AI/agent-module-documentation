<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field Group Link — agent index

Adds one **Field Group formatter** (`format_type: link`) that wraps a group's children in an
`<a>`. Requires `field_group`. **View context only** — it never appears on *Manage form
display*. No settings form, no configure route (`configure: null`), no permissions, no Drush,
no services, no plugin types of its own.

- **Add / read a link field group, its three settings and where the config lives** →
  [configure/link-group.md](configure/link-group.md)
- **The `link` FieldGroupFormatter plugin: target resolution, markup, render element, caveats** →
  [plugins/link-formatter.md](plugins/link-formatter.md)

Key fact: state lives in
`core.entity_view_display.<entity>.<bundle>.<view_mode>` →
`third_party_settings.field_group.<group_name>` with `format_type: link` and
`format_settings: {target, custom_uri, target_attribute}` on top of Field Group's base keys
(`label`, `classes`, `id`, `show_empty_fields`, `label_as_html`).
