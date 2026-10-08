<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Button Link — agent index

One field **formatter** for core Link fields: **"Link as Button"** (id `button_link`), which
renders a link as a Bootstrap `<a class="btn …">`. Extends core `LinkFormatter`. No settings
form, no configure route, no permissions, no Drush, no config schema, no plugin types of its
own. All configuration is the formatter's per-field, per-view-mode `settings` in the
`entity_view_display` config.

- **Selecting the formatter, every setting key + values, where it's stored, drush/PHP** →
  [configure/formatter.md](configure/formatter.md)
- **Theme hook, the Twig template, and the exact CSS classes emitted** →
  [theming/template.md](theming/template.md)

Key facts: formatter id `button_link`, field type `link`; Bootstrap CSS is **not** bundled
(load it in your theme); settings live at
`core.entity_view_display.<entity>.<bundle>.<view_mode>` →
`content.<field>.type: button_link` + `content.<field>.settings.*`.
