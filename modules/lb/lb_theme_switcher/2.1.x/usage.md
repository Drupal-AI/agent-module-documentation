<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Layout Builder Theme Switcher swaps the active front-end theme to a Layout Builder-capable theme (such as Open Y Carnation) whenever a visitor views a Layout Builder page, so LB components render correctly while the rest of the site keeps its own custom theme.

---

Some sites run a bespoke front-end theme that lacks the regions/markup Layout Builder components expect. Rebuilding the theme for LB is costly; this module sidesteps it with a theme negotiator (`LayoutBuilderThemeNegotiator`, priority 1001) that detects LB pages and returns the configured LB theme for just those requests. It applies on the LB override/default view routes and on node canonical pages that use Layout Builder (node has a truthy `field_use_layout_builder`, or the LB overrides field is present), and — optionally, per configuration — on 404/403 error pages and on Webform canonical/submission pages. Admin routes are always excluded. For AJAX requests it honours core's `ajax_page_state[theme]` only when the accompanying CSRF `theme_token` validates.

Configuration lives at `/admin/config/openy/settings/theme-switcher` (route `lb_theme_switcher.form`, permission `administer site configuration`): pick the theme to switch to (validated as installed+enabled) and toggle the error-page and webform behaviours, stored in `lb_theme_switcher.settings`. A Drush command `lb_theme_switcher:reset-lb-header-footer` (alias `lbreset`) resets the shared `ws_header`/`ws_footer` LB sections on nodes back to their view-display template, with a `--dry-run`. The module targets the Open Y / YMCA Website Services stack and effectively requires core `layout_builder` (not declared in info.yml).

Setup: enable the LB-capable theme, then set it on the settings form and choose whether error pages and webforms should use it too.

---

- Render Layout Builder pages in a theme that supports LB while keeping a custom default theme
- Use Open Y Carnation for LB components on a YMCA Website Services site
- Switch theme automatically on node pages that opt into Layout Builder
- Switch theme on the LB override/default view routes
- Optionally theme 404/403 error pages with the LB theme
- Optionally theme Webform pages and user submission pages with the LB theme
- Pick the target theme from a validated list of enabled themes
- Keep admin routes on the admin theme (never switched)
- Preserve the AJAX theme token so in-place LB editing stays consistent
- Reset a content type's LB header/footer to the display template via Drush
- Reset header/footer across all LB-enabled node bundles with `lbreset all`
- Preview header/footer resets with `--dry-run` before saving
- Attach the module's LB styling library on pages
- Roll out a shared header/footer template change to existing nodes
- Limit theme switching to only the routes you enable
- Support content types that store LB templates in a non-default view mode (e.g. `full`)
