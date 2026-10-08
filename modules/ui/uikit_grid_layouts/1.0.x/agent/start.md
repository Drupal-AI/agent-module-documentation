<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# UIkit Grid Layouts - agent index

**UIkit 3 grid Layout plugins** (1-4 columns) for Layout Builder / Layout API. Version **1.0.1**, core `^9 || ^10`.

- Single plugin class `UikitGridLayoutsClass` extends `LayoutDefault` + `PluginFormInterface`; layouts declared in `*.layouts.yml`.
- Config form options: section background (+ managed-file image), padding, container width, gutter, divider, card, column position, per-template column ratios.
- No routes/permissions of its own; requires a UIkit 3 theme and Layout API consumer.