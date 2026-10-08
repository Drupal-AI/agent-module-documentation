<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Simple Styleguide — agent index

Renders one living-styleguide page at `/simple-styleguide` (perm **access style guide**) showing
selected built-in HTML patterns, a colour palette, and custom patterns. Custom patterns are
`styleguide_pattern` config entities. No Drush, no plugin types.

- **Settings form: pick built-in patterns + colour palette** →
  [configure/settings.md](configure/settings.md)
- **Custom patterns (the `styleguide_pattern` config entity): add / list / deploy** →
  [configure/patterns.md](configure/patterns.md)
- **Theme hooks, templates, per-pattern template suggestion, library** →
  [theming/templates.md](theming/templates.md)
- **Permissions (`access style guide`, `administer style guide`) + forced noindex** →
  [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Styleguide page route `simple_styleguide.controller` = `/simple-styleguide`.
- Settings config object is **`simple_styleguide.styleguidesettings`** (keys `default_patterns`,
  `default_colors`) — NOT the near-empty `simple_styleguide.patterns` install stub.
- Configure route (info.yml) `simple_styleguide.styleguide_settings` = `/admin/config/styleguide/settings`.
- Custom pattern config names: `simple_styleguide.styleguide_pattern.<id>` (config entity type
  `styleguide_pattern`, admin permission `administer style guide`), collection at
  `/admin/config/styleguide/patterns`.
