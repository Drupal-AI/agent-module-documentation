<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Pluggable (pluggable) — agent index

**Field-type framework: plugin-backed `pluggable_item` derivatives become selectable field values (select/radios widgets, default formatter).**

- **Version:** 2.0.x (git branch 2.x; no packaged version in info.yml)
- **Core:** ^8 || ^9 || ^10 || ^11
- **Field plugins:** field type `pluggable_item` (plugin-derived), widgets `pluggable_select` / `pluggable_radios`, formatter `pluggable_default`.
- **Glue:** `.module` implements `hook_field_widget_info_alter()` and `hook_field_formatter_info_alter()` to register derivatives (core does not do this automatically).
- **Routes/permissions:** none.

**Security:** Pure field/plugin building blocks; no routes, permissions or endpoints. Access follows host-entity field access. No security findings. See [extend/plugins.md](extend/plugins.md)
