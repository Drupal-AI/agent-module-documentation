<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Link Icon — agent index

Icon-agnostic **field formatter** for the core `link` field. Builds a CSS icon class from
each link's title using a predefined `key|value` allowed-titles list. Adds no field type.
Depends on core `link`.

- **Set up predefined titles + the `linkicon` formatter and its display options** →
  [configure/formatter.md](configure/formatter.md)
- **Global settings form, icon-font CSS path config, route and permission** →
  [configure/settings.md](configure/settings.md)
- **The `linkicon.manager` service, hooks it alters, and how the class-building works** →
  [api/manager.md](api/manager.md)

Key facts:
- Formatter plugin id `linkicon` (extends core `LinkFormatter`); `field_types = {link}`.
- Field-level "Predefined" title option = integer `5` in the link field `title` setting; allowed
  titles stored in the field's `title_predefined` setting as `key|value[|tooltip]` lines.
- Global config object `linkicon.settings` has a single key `font` (path(s) to icon-font CSS).
- Configure route `linkicon.settings` → `/admin/config/user-interface/linkicon`, permission `administer linkicon`.
- No plugins to implement, no Drush, no submodules.
