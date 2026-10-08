<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Varbase Styleguide extends the Styleguide module's living style guide with Varbase's own Bootstrap 5 component examples, so a theme can be checked against every element it has to render on one page.

---

The Styleguide module builds a single page (`/admin/appearance/styleguide`) containing an instance of every text style, form element, list, table and message type Drupal produces — the fastest way to answer "did my theme change break anything" in one scroll. This module hooks into that page via `hook_styleguide_alter()` to add a whole "Varbase" group of Bootstrap 5 markup examples (navbars, buttons, typography, tables, forms, navs, alerts, badges, progress bars, list groups and more), and swaps the default styleguide preview image for its own `flag-earth.jpg`. It also implements `hook_page_attachments()` to attach a small CSS library (`varbase_styleguide/general-styles`) on any `styleguide.*` route.

Unlike the 9.2.x branch, 10.0.x is a plain procedural module: the examples live in the `varbase_styleguide.module` file (there is no `Hook/VarbaseStyleguideHooks` class, no `src/`, no config, no routes and no permissions of its own). On install it runs a bundled recipe (`recipes/default`) that installs the View Modes Inventory (`vmi`) module; its Composer package also pulls in `drupal/styleguide`, `drupal/vmi` and `vardot/varbase-patches`, though the `.info.yml` only hard-depends on `styleguide`.

Access to the style guide page is governed entirely by the Styleguide module (the `access styleguide` permission); this module only alters what that page shows.

It earns its place in a theming workflow, not a production one: build the theme, open the style guide, find the elements that look wrong, repeat. It is equally useful during an upgrade (which components changed appearance between versions) and during handover (a style guide is the fastest way to show what a theme covers). The core requirement is `~10.3.0 || ~11.0.0`, so this branch runs on both Drupal 10.3+ and Drupal 11.

---

- Review every element a theme must style in one page.
- Add Varbase's Bootstrap 5 components to the style guide.
- Check a theme change against all element types at once.
- Find unstyled elements before users do.
- Compare component appearance across an upgrade.
- Hand over a theme with a visual reference.
- Test typography and spacing systematically.
- Verify form element styling (inputs, selects, switches, ranges, floating labels).
- Verify message, alert and badge styling.
- Verify table, list-group and pagination styling.
- Verify button, button-group and navbar styling.
- Verify progress-bar variants (striped, animated, multiple).
- Review a theme against a Bootstrap-based design system.
- Onboard a front-end developer to a Varbase theme.
- Spot regressions after a Varbase update.
- Keep a living reference for a design team.
- Attach custom style-guide CSS on styleguide routes.
- Run the same style guide on both Drupal 10.3+ and 11.
- Pull View Modes Inventory into a Varbase build via the bundled recipe.
- Align a component reference with the Varbase distribution.
