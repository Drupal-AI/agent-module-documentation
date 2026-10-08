<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Varbase Styleguide (varbase_styleguide) — agent index

Adds Varbase's own component examples to the **Styleguide** module's living style guide.
Version **9.2.1**. Core **`~11.4.0`**. Depends on `styleguide:styleguide`.
No routes, permissions or config. Single class: `Hook/VarbaseStyleguideHooks`.

Value: one page containing an instance of every element the theme must render — the fastest check
that a theme change broke nothing, and the fastest way to compare appearance across an upgrade or
hand a theme over.

Theming-workflow module, not a production one. Tracks the Varbase distribution (`~11.4.0` pin).