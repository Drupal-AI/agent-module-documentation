<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Varbase Styleguide (varbase_styleguide) — agent index

Extends the **Styleguide** module's living style guide with Varbase's Bootstrap 5 component
examples. Version **10.0.x**. Core **`~10.3.0 || ~11.0.0`** (Drupal 10.3+ and 11).
Info.yml depends on `styleguide:styleguide`; Composer also requires `drupal/vmi`,
`drupal/styleguide` and `vardot/varbase-patches`.

No routes, permissions, config, plugins or Drush of its own. Procedural module
(`varbase_styleguide.module`) — three hooks only. Access to the style guide page
(`/admin/appearance/styleguide`, route `styleguide.page`) is gated by the Styleguide
module's `access styleguide` permission; this module only alters what shows there.

Value: one page containing an instance of every element the theme must render — the fastest
check that a theme change broke nothing, and the fastest way to compare appearance across an
upgrade or hand a theme over.

- How it hooks into the style guide, the CSS library, and the install recipe → [extend/styleguide.md](extend/styleguide.md)

Theming-workflow module, not a production one. Tracks the Varbase distribution.
