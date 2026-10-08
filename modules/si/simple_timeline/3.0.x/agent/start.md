<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Simple Timeline — agent index

One Views **style plugin**, `simple_timeline`, that renders a view's rows as a vertical
timeline. No settings form, no configure route, no permissions, no Drush. All state is the
`style.options` of a view display.

- **Choose the style, its 4 options + allowed values, config location, drush recipe** →
  [configure/style.md](configure/style.md)
- **Theme hook, template, library, CSS override points** →
  [theming/timeline.md](theming/timeline.md)

Key facts:
- Style plugin id: `simple_timeline` (theme `views_view_simple_timeline`).
- Options: `position_items` (`alternate`/`left`/`right`), `position_marker`
  (`marker-top`/`marker-center`/`marker-bottom`), `wrapper_class` (`wrapper-list`),
  `class` (`item-list`).
- Stored at `views.view.<id>` → `display.<display>.display_options.style.{type, options}`.
- Depends on `views`.
